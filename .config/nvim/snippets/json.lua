-- Custom json snippets (mini.snippets format).
-- Placeholders: ${N:default}, ${0}, $TM_SELECTED_TEXT (visual selection).
return {
	{
		prefix = "docker",
		body = [=[
{
  "registry-mirrors": [
    "https://1nj0zren.mirror.aliyuncs.com",
    "https://docker.mirrors.ustc.edu.cn",
    "http://f1361db2.m.daocloud.io",
    "https://dockerhub.azk8s.cn"
  ],
  "live-restore": true
}]=],
		desc = "docker",
	},
}
