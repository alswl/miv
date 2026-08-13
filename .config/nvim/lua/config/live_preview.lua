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

local function html_escape(text)
    return (text:gsub("[&<>\"']", {
        ["&"] = "&amp;",
        ["<"] = "&lt;",
        [">"] = "&gt;",
        ['"'] = "&quot;",
        ["'"] = "&#39;",
    }))
end

-- Pure vim.uv/vim.fs calls only: this runs in a libuv fast-event callback
-- (server:serve_file has no vim.schedule), where vim.fn/vim.api would error.
local function scandir_markdown_files(dir)
    local names = {}
    local req = vim.uv.fs_scandir(dir)
    if not req then
        return names
    end
    while true do
        local name, typ = vim.uv.fs_scandir_next(req)
        if not name then
            break
        end
        if typ == "file" and (name:match("%.md$") or name:match("%.markdown$")) then
            table.insert(names, name)
        end
    end
    table.sort(names)
    return names
end

local function path_to_href(webroot, abs_path)
    local rel = abs_path
    if webroot and abs_path:sub(1, #webroot) == webroot then
        rel = abs_path:sub(#webroot + 1)
    end
    local parts = {}
    for part in rel:gmatch("[^/]+") do
        table.insert(parts, vim.uri_encode(part))
    end
    return "/" .. table.concat(parts, "/")
end

-- Sidebar listing markdown files in the same directory as the file being
-- served, so the browser can jump between notes without switching buffers
-- in Neovim. Built per-request from `M.current_filepath` (set by the
-- handler.serve_file wrapper below) since livepreview's toHTML/md2html
-- pipeline never receives the file path itself.
local function dirlist_sidebar_html(webroot, filepath)
    if not webroot or not filepath or filepath == "" then
        return ""
    end
    local dir = vim.fs.dirname(filepath)
    local names = scandir_markdown_files(dir)
    if #names == 0 then
        return ""
    end

    local current_name = vim.fs.basename(filepath)
    local items = {}
    for _, name in ipairs(names) do
        local href = path_to_href(webroot, dir .. "/" .. name)
        table.insert(
            items,
            string.format(
                '<li><a href="%s"%s>%s</a></li>',
                href,
                name == current_name and ' class="livepreview-dirlist-active"' or "",
                html_escape(name)
            )
        )
    end

    return [[
<div id="livepreview-dirlist">
  <button id="livepreview-dirlist-toggle" title="Files in this directory">&#9776;</button>
  <div id="livepreview-dirlist-panel"><ul>]] .. table.concat(items) .. [[</ul></div>
</div>
<style>
  #livepreview-dirlist { position: fixed; top: 0; left: 0; z-index: 1000; font-family: sans-serif; }
  #livepreview-dirlist-toggle { border: none; background: #24292f; color: #fff; padding: 6px 10px; cursor: pointer; opacity: .55; font-size: 14px; }
  #livepreview-dirlist-toggle:hover { opacity: 1; }
  #livepreview-dirlist-panel { display: none; background: #fff; color: #1f2328; border: 1px solid #d0d7de; border-radius: 0 0 6px 0; max-height: 80vh; overflow-y: auto; min-width: 200px; box-shadow: 2px 2px 8px rgba(0,0,0,.2); }
  #livepreview-dirlist.open #livepreview-dirlist-panel { display: block; }
  #livepreview-dirlist-panel ul { list-style: none; margin: 0; padding: 4px; }
  #livepreview-dirlist-panel li a { display: block; padding: 4px 8px; text-decoration: none; color: #0969da; border-radius: 4px; font-size: 13px; }
  #livepreview-dirlist-panel li a:hover { background: #f6f8fa; }
  #livepreview-dirlist-panel li a.livepreview-dirlist-active { font-weight: 600; background: #eef2ff; }
</style>
<script>
(function () {
  var bar = document.getElementById("livepreview-dirlist");
  document.getElementById("livepreview-dirlist-toggle").addEventListener("click", function () {
    bar.classList.toggle("open");
  });
})();
</script>
]]
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
    local ok_handler, handler = pcall(require, "livepreview.server.handler")
    if not ok_config or not ok_template or not ok_handler then
        return false
    end

    config.set({
        browser = "default",
        dynamic_root = false,
        sync_scroll = true,
        picker = "fzf-lua",
    })

    -- Set by the handler.serve_file wrapper right before each request is
    -- served, so md2html (called deeper in that same call chain) knows
    -- which file's directory to list in the sidebar.
    M.current_filepath = nil
    local original_serve_file = handler.serve_file
    handler.serve_file = function(client, file_path, if_none_match, accept)
        M.current_filepath = file_path
        return original_serve_file(client, file_path, if_none_match, accept)
    end

    local preprocess = plantuml_preprocessor()
    local original_md2html = template.md2html
    template.md2html = function(markdown)
        -- Keep initial preview responsive.
        local content = vim.in_fast_event() and markdown or preprocess(markdown)
        local sidebar = dirlist_sidebar_html(M.webroot, M.current_filepath)
        return (original_md2html(content):gsub("</body>", sidebar .. d2_renderer .. "</body>", 1))
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
        M.webroot = root or vim.uv.cwd()

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
