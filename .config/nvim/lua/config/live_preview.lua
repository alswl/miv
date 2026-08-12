local M = { enabled = false }

local function render_plantuml_factory()
    local cache = {}

    return function(source)
        if vim.fn.executable("plantuml") ~= 1 then
            return nil, "`plantuml` was not found on $PATH"
        end

        local input = source:match("@startuml") and source or "@startuml\n" .. source .. "\n@enduml"
        local key = vim.fn.sha256(input)
        if cache[key] then
            return cache[key]
        end

        local svg = vim.fn.system({ "plantuml", "-tsvg", "-pipe" }, input)
        if vim.v.shell_error ~= 0 then
            return nil, svg
        end
        cache[key] = svg
        return svg
    end
end

local function plantuml_preprocessor()
    local render_plantuml = render_plantuml_factory()

    local function replace_fence(source)
        local svg, err = render_plantuml(source)
        if svg then
            return svg
        end
        return "```text\nPlantUML render error:\n" .. (err or "unknown error") .. "\n```"
    end

    return function(markdown)
        return (markdown:gsub("```plantuml[^\n]*\n(.-)\n```", replace_fence):gsub("```puml[^\n]*\n(.-)\n```", replace_fence))
    end
end

local d2_renderer = [[
<script type="module">
import { D2 } from "https://esm.sh/@terrastruct/d2@0.1.33";

const d2 = new D2();
const d2Cache = new Map();
async function renderD2() {
  for (const code of document.querySelectorAll("pre > code.language-d2")) {
    if (code.dataset.livepreviewD2Rendered) continue;
    code.dataset.livepreviewD2Rendered = "true";
    const target = document.createElement("div");
    target.className = "livepreview-d2";
    target.textContent = "Rendering D2…";
    code.parentElement.replaceWith(target);
    try {
      const source = code.textContent;
      let svg = d2Cache.get(source);
      if (!svg) {
        const result = await d2.compile(source);
        svg = await d2.render(result.diagram, result.renderOptions);
        d2Cache.set(source, svg);
      }
      target.innerHTML = svg;
    } catch (error) {
      target.textContent = `D2 render error: ${error.message || error}`;
      target.classList.add("livepreview-d2-error");
    }
  }
}

new MutationObserver(() => { void renderD2(); })
  .observe(document.querySelector(".markdown-body"), { childList: true, subtree: true });
void renderD2();
</script>
<style>
  .livepreview-d2 { overflow-x: auto; margin: 1em 0; }
  .livepreview-d2 > svg { max-width: 100%; height: auto; }
  .livepreview-d2-error { color: #cf222e; white-space: pre-wrap; }
</style>
]]

function M.setup()
    if M.enabled then
        return true
    end

    local ok_config, config = pcall(require, "livepreview.config")
    local ok_template, template = pcall(require, "livepreview.template")
    if not ok_config or not ok_template then
        return false
    end

    config.set({
        browser = "default",
        dynamic_root = false,
        sync_scroll = true,
        picker = "fzf-lua",
    })

    local preprocess = plantuml_preprocessor()
    local original_md2html = template.md2html
    template.md2html = function(markdown)
        -- Keep initial preview responsive.
        local content = vim.in_fast_event() and markdown or preprocess(markdown)
        return (original_md2html(content):gsub("</body>", d2_renderer .. "</body>", 1))
    end

    local function render_current_buffer()
        local filepath = vim.api.nvim_buf_get_name(0)
        if vim.bo.filetype ~= "markdown" or filepath == "" then
            return
        end

        local server = require("livepreview.server")
        local message = {
            filepath = filepath,
            type = "update",
            content = preprocess(table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")),
        }
        for _, client in ipairs(server.connecting_clients) do
            server.websocket.send_json(client, message)
        end
    end

    local render_timer = vim.uv.new_timer()
    local function debounce_render()
        if #require("livepreview.server").connecting_clients == 0 then
            return
        end
        render_timer:stop()
        render_timer:start(800, 0, vim.schedule_wrap(render_current_buffer))
    end

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("MarkdownDiagramPreview", { clear = true }),
        pattern = { "*.md", "*.markdown" },
        callback = render_current_buffer,
        desc = "Render local PlantUML diagrams after saving Markdown",
    })

    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        group = vim.api.nvim_create_augroup("MarkdownDiagramPreviewDebounce", { clear = true }),
        pattern = { "*.md", "*.markdown" },
        callback = debounce_render,
        desc = "Debounce local PlantUML rendering while editing Markdown",
    })

    function M.start()
        -- `autochdir` keeps cwd pinned to the current file's directory, which
        -- breaks livepreview's dynamic_root=false (webroot = cwd at server
        -- start). Root at the vault/repo boundary just for the start call.
        local filepath = vim.api.nvim_buf_get_name(0)
        local root = vim.fs.root(filepath, { ".obsidian", ".git" })
        local prev_cwd = root and vim.fn.chdir(root) or nil

        vim.cmd("LivePreview start")

        if prev_cwd and prev_cwd ~= "" then
            vim.fn.chdir(prev_cwd)
        end

        -- Render after preview connects.
        vim.defer_fn(render_current_buffer, 1000)
    end

    M.enabled = true
    return true
end

return M
