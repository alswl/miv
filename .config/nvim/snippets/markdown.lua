-- Custom markdown snippets (mini.snippets format).
-- Placeholders: ${N:default}, ${0}, $TM_SELECTED_TEXT (visual selection).
return {
	{
		prefix = "more",
		body = "<!-- more -->",
		desc = "more",
	},

	{
		prefix = "h1",
		body = "# ${0}",
		desc = "h1",
	},

	{
		prefix = "h2",
		body = "## ${0}",
		desc = "h2",
	},

	{
		prefix = "h3",
		body = "### ${0}",
		desc = "h3",
	},

	{
		prefix = "h4",
		body = "#### ${0}",
		desc = "h4",
	},

	{
		prefix = "h5",
		body = "##### ${0}",
		desc = "h5",
	},

	{
		prefix = "del",
		body = "<del>${0:$TM_SELECTED_TEXT}</del>",
		desc = "del",
	},

	{
		prefix = "**",
		body = "**${0:$TM_SELECTED_TEXT}**",
		desc = "**",
	},

	{
		prefix = "~~",
		body = "~~${0:$TM_SELECTED_TEXT}~~",
		desc = "~~",
	},

	{
		prefix = "m",
		body = "<mark>${0:$TM_SELECTED_TEXT}</mark>",
		desc = "m",
	},

	{
		prefix = "mb",
		body = "<mark><b>${0:$TM_SELECTED_TEXT}</b></mark>",
		desc = "mb",
	},

	{
		prefix = "mcb",
		body = "<center><mark><b>${0:$TM_SELECTED_TEXT}</b></mark></center>",
		desc = "cmb",
	},

	{
		prefix = "small",
		body = "<small>${0:$TM_SELECTED_TEXT}</small>",
		desc = "small",
	},

	{
		prefix = "s",
		body = "<small>${0:$TM_SELECTED_TEXT}</small>",
		desc = "small",
	},

	{
		prefix = "linku",
		body = "[${1:link}](${3:${Text:$TM_SELECTED_TEXT}})$0",
		desc = "Link to something with url",
	},

	{
		prefix = "today",
		body = [=[
`#!/bin/bash
date '+%Y-%m-%d'`]=],
		desc = "Today",
	},

	{
		prefix = "now",
		body = [=[
`#!/bin/bash
date '+%Y-%m-%d %H:%M:%S'`]=],
		desc = "Now",
	},

	{
		prefix = "30l",
		body = [=[
${0}




























]=],
		desc = "30 Empty Lines",
	},

	{
		prefix = "ib",
		body = [=[

## Inbox - `#!/bin/bash
date '+%Y-%m-%d'`
]=],
		desc = "Inbox",
	},

	{
		prefix = "table",
		body = [=[
| A             | B             | C             | D             |
| ---           | ---           | ---           | ---           |
|               |               |               |               |
|               |               |               |               |
|               |               |               |               |
|               |               |               |               |
]=],
		desc = "Table",
	},

	{
		prefix = "10l",
		body = [=[
${0}








]=],
		desc = "10 Empty Lines",
	},

	{
		prefix = "meeting",
		body = [=[


## ${0}会议记录 - `#!/bin/bash
date '+%Y-%m-%d'`

**参会人**



**会议材料**




**需要讨论解决问题**



**会议过程记录**



**遗留问题**


]=],
		desc = "会议记录",
	},

	{
		prefix = "meetingamz",
		body = [=[


## ${0}会议准备 - `#!/bin/bash
date '+%Y-%m-%d'`

## 1. What we do?（背景）


## 2. Why we do it? or What’s the problem（解决什么问题）


## 3. How we do it?（我们怎样做）


## 4. Validation（如何验证）


## 5. Discussion/Analysis（讨论、分析）


## 6. Summary（总结）


]=],
		desc = "会议记录 Amazon",
	},

	{
		prefix = "card",
		body = [=[

## 术语卡


## 人名卡


## 反常识卡


## 金句卡


## 行动卡


## 技巧卡


## 任意卡

]=],
		desc = "卡片",
	},

	{
		prefix = "issuedoc",
		body = [=[

# ${0} `#!/bin/bash
date '+%Y-%m-%d'`

## 综述



## 问题



## 解决方案



## 过程记录



## 待办项


]=],
		desc = "Issue",
	},

	{
		prefix = "issue",
		body = [=[

## Issue - ${0} `#!/bin/bash
date '+%Y-%m-%d'`

**参会人**



**问题**



**解决问题方向**



**解决方案**



**优劣分析**



**待办项**


]=],
		desc = "问题",
	},

	{
		prefix = "planning",
		body = [=[
## 计划 `#!/bin/bash
date '+%Y-%m-%d'`


**本周任务**



**上周任务遗留**



**Inbox**



**风险和问题**



**个人思考**



**会议记录**


]=],
		desc = "计划",
	},

	{
		prefix = "review",
		body = [=[

## Review - `#!/bin/bash
date '+%Y-%m-%d'`

**感受**：



**正面**：



**负面**：



**问题**:



**思考**：



**行动**：



**记录**：


]=],
		desc = "Review",
	},

	{
		prefix = "interview",
		body = [=[

## Interview - ${1}

**优**


**劣**


**小结**


**问题**

- 最近几年从事的技术领域是什么
  - ${0}

]=],
		desc = "Interview",
	},

	{
		prefix = "api",
		body = [=[
- Name：${1}
- Path
- Method:
- Params
- Request Payload
- Response]=],
		desc = "API Document",
	},

	{
		prefix = "readingdoc",
		body = [=[

## 感想

> 做总体，写感受，要扑面而来不假思索的那种

${0}


## 笔记

> 固定格式，读作者心，问作者话

- 链接
  -
- 题材
  -
- 主题
  -
- 阅读对象
  -
- 阅读前问题
  -
- 阅读中问题
  -
- 脉络
  -
- 给我带来的冲击和改变
  -
- 本文提到的其他书籍
  -
- 作者
  -
- 评价
  - 优点
    -
  - 缺点
    -

## 摘抄

> 给自己 Hint 的那种文字

]=],
		desc = "Reading Note",
	},

	{
		prefix = "docvoting",
		body = [=[

- 类型 指南 / 产品手册 / 产品开发 / 专项 / 记录 / 管理 / 其他
- 紧急度 低 / 中 / 高
- 重要度 低 / 中 / 高
- 难度 低 / 中 / 高
- 文档质量 低 / 中 / 高
]=],
		desc = "文档标记",
	},

	{
		prefix = "failure",
		body = [=[

## 故障 - `#!/bin/bash
date '+%Y-%m-%d'`

元数据：

- 开始时间：
- 结束时间：
- 吹哨人：
- 参与人：



**表现**



**时间线**



**补充资料**



**根因**



**如何防范**



Hint：

]=],
		desc = "故障事件",
	},

	{
		prefix = "designdoc",
		body = [=[

> Status: Draft (Draft -> In Review -> Approved/Abandon）
>
> Author(s): [Author Name, Co-Author Name]
>
> Last updated: [Date]


## Abstract

> 必选，关于方案的简要描述


## Motivation

> 必选，介绍方案的背景，解决的问题和困难


### Goals

> 可选，一般和 Non-Goal 成对出现，描述文档关注的目标


### Non-Goal

> 可选，一般和 Goal 成对出现，描述文档不解决的目标



### Definitions

> 可选，涉及本案的概念申明


## Proposal

> 必选，方案的详细描述


### Use Cases

> 必选，介绍用户场景下的行为 / 流程，使用案例等


## Implementations

> 必选，方案的详细实现描述，包括但不限于流程图，组件交互图，状态机，关键配置等。


### API Changes

> 可选，如果对系统带来改动，需要在这里集中描述


## Alternatives

> 必选，有其他参考方案或实现都可以在这里列出，形成优缺点对比


## Tasks

> 必选，描述完成本方案需要任务拆解、负责人和时间评估


## References

> 必选，文档中引用的关联内容

]=],
		desc = "Design Document",
	},

	{
		prefix = "oncall",
		body = [=[

## On-call - `#!/bin/bash
date '+%Y-%m-%d'`

**元数据**：

- 开始时间：
- 结束时间：
- 吹哨人：
- 参与人：


**表现** ：



**时间线**：



**补充资料**：



**根因**：



**如何防范**：



**Hint**：


]=],
		desc = "On-call 处理",
	},

	{
		prefix = "playbookdoc",
		body = [=[

## 告警影响面

> 这段是用来说明两个点：
>
> - 这个告警是做什么的？
> - 产生这个告警的影响面通常是什么？



## 告警排查思路

> 这段是用来列举产生这个告警的常用排查思路。
> 例如，常用的预先设计好的 dashboard 的URL，临场分析的 PromQL 的一些引导语句，日志目录需要排查的字段等等。
>
> 这段会有对应的现象和应对止血手段。内容会随着告警的一次次的排查而变的丰富。



## 告警升级（Playbook无效怎么办）

> 这段记录这个 Playbook 的相关元数据，以及对应如果 Playbook 内容无法解决告警问题，该怎么办。
> 例如，给出告警 owner 的名字，系统 owner的名字等等。



## 告警数据源（Optional）

]=],
		desc = "Playbook",
	},

	{
		prefix = "guidedoc",
		body = [=[

## Overview



## Topic



## Next Steps

]=],
		desc = "Guide",
	},

	{
		prefix = "gsdoc",
		body = [=[

## Overview



## Setting Up



## Build



## Run



## Summary



## Next Steps

]=],
		desc = "Getting Start Doc",
	},

	{
		prefix = "doc",
		body = [=[

## Overview



## Concepts



## Use cases and Features



## Faq



## References

]=],
		desc = "General Doc",
	},

	{
		prefix = "okr",
		body = [=[

某事项

- 个人角色
- 业务价值和结果
  - 业务痛点
  - 业务价值
  - 业务结果
- 技术实现和结果
  - 技术实现
  - 技术结果
- 未来思考]=],
		desc = "okr values",
	},

	{
		prefix = "okr2",
		body = [=[

关键产出 - ?：

**我的角色和价值产出**

**我是如何达成的**
]=],
		desc = "okr values 2",
	},

	{
		prefix = "mfpf",
		body = [=[
> [!mf-private] Feedback
> ]=],
		desc = "mind-forge private feedback",
	},
}
