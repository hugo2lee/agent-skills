# Agent Skills

个人工程哲学 Skill Suite 的唯一源码仓库。

当前版本：v0.1.0

## 内容

这套 Skill 以英文编写核心指令，以中文维护仓库说明，目标是让同一套工程判断可以在 Cline、Codex 和 OpenClaw 中复用。

当前包含 11 个独立 Skill：

- engineering-philosophy：工程哲学总纲、规则分级和 Skill 路由。
- architecture-boundaries：架构边界、Ports and Adapters、依赖反转和测试缝。
- ddd-lite：以业务不变量为中心的务实 DDD。
- test-driven-development：Red-Green-Refactor 和行为驱动的增量实现。
- systematic-debugging：复现、证据、假设、最小修复和回归验证。
- spec-driven-development：问题定义、约束、验收标准和非目标。
- planning-and-task-breakdown：任务拆解、依赖、风险和检查点。
- incremental-implementation：Vertical Slice、安全迁移和小批量变更。
- code-review-and-quality：正确性、边界、质量和验证证据审查。
- git-workflow-and-versioning：分支、原子提交、版本和变更记录。
- ci-cd-and-automation：自动化质量闸、构建、发布验证和失败处理。

首版只提供 Go 代码示例和语言落地参考，不包含 C++ Skill。

## 使用 npx skills 安装

本仓库不需要发布 npm 包。npx skills 会直接从 GitHub 仓库发现
skills/<skill-name>/SKILL.md，并使用每个 Skill 的 frontmatter 和描述完成安装。

查看所有 Skill：

~~~sh
npx skills add hugo2lee/agent-skills --list
~~~

安装全部 Skill：

~~~sh
npx skills add hugo2lee/agent-skills --skill '*'
~~~

只安装 architecture-boundaries：

~~~sh
npx skills add hugo2lee/agent-skills \
  --skill architecture-boundaries
~~~

全局安装到 Codex、Cline 和 OpenClaw：

~~~sh
npx skills add hugo2lee/agent-skills \
  --skill '*' \
  --global \
  --agent codex \
  --agent cline \
  --agent openclaw \
  --yes
~~~

安装后可以使用 npx skills ls 查看已安装 Skill，使用
npx skills update 更新到仓库中的最新版本。Codex 中可以通过
$architecture-boundaries 这样的显式调用名使用 Skill；其他 Agent 可以根据
Skill 的 description 自动触发。

## 设计原则

> Prefer the simplest architecture that preserves meaningful boundaries.

这套 Skill 区分全局工程哲学与项目工程规则。项目特有的 Go 版本、数据库、GitLab 流程、目录约定和领域模型应放在项目自己的规则文件或项目级 Skill 中，不应污染全局工程哲学。

规则统一使用三种等级：

- MUST：个人工程宪法。
- SHOULD：默认实践，可以基于明确原因偏离。
- CONDITIONAL：满足清晰条件时才启用。

## 校验和部署

在仓库根目录运行：

~~~sh
scripts/validate.sh
scripts/deploy.sh --dry-run
scripts/deploy.sh
~~~

deploy.sh 默认复制到：

- ~/.codex/skills/
- ~/.agents/skills/
- ~/.openclaw/skills/

这些路径与 npx skills 的全局 Agent 目录保持一致。deploy.sh 是可选的、可审计的
直接复制方式，只管理本仓库的 11 个 Skill，不会修改其他 Skill，也不会修改
~/.codex/skills/.system。它保留 --cline-root、--codex-root、--openclaw-root
参数以及对应的 AGENT_SKILLS_*_ROOT 环境变量；如果个人环境仍使用旧的
~/.cline/skills，可以显式传入 --cline-root "$HOME/.cline/skills"，不会破坏现有布局。

## 维护方式

不要因为一次偶发问题就修改全局 Skill。先记录 Observation，在真实项目中确认重复模式，再补充 eval case，最后才把 Candidate Rule 晋升为全局规则。

详细版本变化见 CHANGELOG.md，参考来源和许可证边界见 ATTRIBUTION.md。
