# Agent Skills

个人工程哲学 Agent Skills Suite 的唯一源码仓库。

当前稳定版本：v0.2.0 — Reliable Routing & Distribution

## What is this?

这是一套可独立触发、独立维护、独立评测的个人工程方法论 Skills。核心指令和 references 使用英文，仓库维护说明和示例说明使用中文，目标是让同一套工程判断在 Codex、Cline、OpenClaw 以及其他兼容 Agent Skills 规范的 Agent 中复用。

v0.2.0 不增加顶层 Skill，重点提高现有 11 个 Skill 的发现、选择、路由、安装和验证可靠性。仍然只有以下 11 个顶层 Skill：

- engineering-philosophy：显式工程治理与 Skill 路由总入口。
- architecture-boundaries：技术边界、Ports and Adapters、依赖反转、显式 DI 和测试缝。
- ddd-lite：以业务不变量和一致性需求为中心的务实 DDD。
- test-driven-development：Red-Green-Refactor 和行为驱动的增量实现。
- systematic-debugging：复现、证据、假设、最小修复和回归验证。
- spec-driven-development：问题定义、约束、验收标准和非目标。
- planning-and-task-breakdown：任务拆解、依赖、风险和检查点。
- incremental-implementation：Vertical Slice、安全迁移和小批量变更。
- code-review-and-quality：正确性、边界、回归风险和验证证据审查。
- git-workflow-and-versioning：分支、原子提交、版本、Tag 和变更记录。
- ci-cd-and-automation：自动化质量闸、构建、发布验证和失败处理。

architecture-boundaries 下包含 Go 落地参考和 C++ 边界 realization reference；这不是新的 C++ 顶层 Skill。

## Quick Start

普通用户推荐使用 npx skills 从公开 GitHub 仓库安装，不需要发布 npm 包：

~~~sh
npx skills@latest add hugo2lee/agent-skills \
  --skill '*' \
  --global \
  --agent codex \
  --agent cline
~~~

当前 skills CLI 的 Codex + Cline 组合安装会使用共享用户目录：

~~~text
~/.agents/skills/
~~~

这也是本仓库当前推荐的 Codex/Cline 全局 Skill 目录。OpenClaw 仍由 CLI 使用自己的用户目录。安装方式默认可能使用 symlink；如果环境不适合 symlink，可以加上 --copy。

查看仓库发现的全部 Skill：

~~~sh
npx skills@latest add hugo2lee/agent-skills --list
~~~

只安装一个 Skill：

~~~sh
npx skills@latest add hugo2lee/agent-skills \
  --skill architecture-boundaries \
  --global \
  --agent codex \
  --agent cline
~~~

## Verify Installation

查看已经安装的全局 Skill：

~~~sh
npx skills ls -g
~~~

确认共享目录中存在目标 Skill：

~~~sh
test -f ~/.agents/skills/architecture-boundaries/SKILL.md
~~~

在 Codex 中可以显式调用：

~~~text
$architecture-boundaries
$ddd-lite
$systematic-debugging
~~~

其他 Agent 可以根据各 Skill 的 description 自动选择 specialist Skill。description 只承担 discovery/routing 作用，详细规则留在对应的 SKILL.md 和 references 中。

## Entry Point

$engineering-philosophy 是显式总入口，用于：

- 用户要求整体工程分析；
- 不确定应该选择哪个 Skill；
- 一个任务确实横跨多个工程关注点；
- 判断规则应属于 global philosophy 还是 project-local guidance；
- 根据风险决定流程应该更轻还是更重。

它不会作为所有普通请求的必经层。明确的架构请求直接进入 architecture-boundaries，领域不变量直接进入 ddd-lite，实际失败直接进入 systematic-debugging。总纲中的路由矩阵见 skills/engineering-philosophy/references/routing-matrix.md。

## Skill Routing

选择能拥有当前主要工程决策的最小 Skill 集合：

| Signal | Primary Skill | 典型协作 |
| --- | --- | --- |
| 架构边界、DI、Port、Adapter、interface | architecture-boundaries | 发现业务不变量时再加 ddd-lite |
| Aggregate、Value Object、不变量、领域语言 | ddd-lite | 发现技术边界时再加 architecture-boundaries |
| Bug、异常、超时、回归、根因调查 | systematic-debugging | 需要回归测试时再加 test-driven-development |
| 需求不清、验收标准不明确 | spec-driven-development | 规格明确后再进入 planning |
| 目标明确但复杂、存在依赖 | planning-and-task-breakdown | 大型迁移再加 incremental-implementation |
| 大型变更、迁移、Vertical Slice | incremental-implementation | 每个行为切片可加 test-driven-development |
| 新行为、Red-Green-Refactor | test-driven-development | 跨层变更时可加 incremental-implementation |
| PR、MR、diff、代码质量审查 | code-review-and-quality | 发现真实失败时转 systematic-debugging |
| branch、commit、tag、版本 | git-workflow-and-versioning | 发布自动化时协作 ci-cd-and-automation |
| pipeline、质量闸、发布自动化 | ci-cd-and-automation | pipeline 失败时转 systematic-debugging |

不要因为出现 service、repository、CRUD 或 interface 这些词就自动激活 DDD 或完整架构流程。详细的 primary、secondary、forbidden 和升级条件见 routing matrix。

## Usage Examples

中文请求：

~~~text
这个 Go service 直接创建 postgres client，repository 需要加 interface 吗？
~~~

首先使用 architecture-boundaries，判断是否存在真实技术边界、谁拥有 contract、依赖如何注入；不要因为 service 或 repository 这些名字自动引入 DDD。

~~~text
订单状态规则应该放 aggregate 还是 application service？
~~~

首先使用 ddd-lite，先识别业务不变量和一致性边界；只有问题进一步涉及 Adapter 或依赖方向时才协作 architecture-boundaries。

~~~text
这个 bug 先别改，先帮我定位 timeout 的根因。
~~~

首先使用 systematic-debugging，建立稳定复现并保留证据；不要用随机修改或大规模架构重构替代调查。

~~~text
需求比较复杂但已经明确，先帮我拆任务并标出依赖。
~~~

首先使用 planning-and-task-breakdown；如果涉及迁移或需要旧新路径并存，再进入 incremental-implementation。

## Global vs Project Rules

全局哲学保留跨项目、可验证、经过重复验证的工程原则。以下内容应放在项目规则、项目级 Skill 或 ADR 中：

- Go、C++ 或其他项目的具体版本；
- 数据库、消息系统、云服务和框架选型；
- 公司目录结构和命名规范；
- GitHub/GitLab 分支策略及 pipeline 命令；
- 特定领域的 Aggregate、Entity 或状态模型；
- 某项目强制使用的测试框架。

规则等级统一为 MUST、SHOULD、CONDITIONAL。经验只有在 Observation → Repeated Pattern → Candidate Rule → Eval Case → Real-project Validation → Global Rule 之后才适合晋升为全局规则。

## Update

更新已安装的 Skill：

~~~sh
npx skills update -g -y
~~~

如果只想更新本仓库的某一个 Skill：

~~~sh
npx skills update architecture-boundaries -g -y
~~~

更新后重新运行 npx skills ls -g，并检查 ~/.agents/skills 下的 SKILL.md。

## Contributor Workflow

普通用户不需要使用仓库内的 copy-based deploy 工具。维护者在本地修改 Skill 时可以按以下顺序工作：

~~~sh
scripts/validate.sh
scripts/smoke-test-npx.sh
scripts/deploy.sh --dry-run
scripts/deploy.sh
~~~

deploy.sh 是 contributor/maintainer local development helper，不是普通用户安装入口。它默认将 Codex 和 Cline 的本仓库 Skill 复制到 ~/.agents/skills，将 OpenClaw 复制到 ~/.openclaw/skills；通过 marker、ownership 检查、--dry-run 和 --force 保护其他 Skill，不修改 Codex system Skill。若需要兼容旧的个人布局，可以显式传入 --cline-root、--codex-root 或 --openclaw-root。

## Validation

仓库验证由两层组成：

1. Agent Skills 标准层：skills-ref validate；
2. 仓库层：11 个 Skill、metadata/version、references、eval IDs、routing cases、语言分布、negative routing 和 npx smoke test。

本地依赖安装示例。官方 reference source 的命令名是 skills-ref；当前 PyPI 包可能暴露为 agentskills，scripts/validate.sh 兼容这两个命令名：

~~~sh
python3 -m venv .venv
.venv/bin/python -m pip install "PyYAML>=6,<7" "skills-ref==0.1.1"
scripts/validate.sh
~~~

GitHub Actions 在 push 和 pull_request 上自动执行 validation、shellcheck，以及使用临时 HOME 的 npx discovery/installation smoke test。CI 不会写入维护者机器的 Agent 配置。

## Releases

版本发布需要让以下内容保持一致：

- 每个 Skill 的 metadata.version；
- README 和 CHANGELOG；
- Git commit；
- annotated tag；
- GitHub Release；
- 发布后的 npx 安装验证。

维护者发布步骤见 docs/release-checklist.md。版本变更见 CHANGELOG.md，参考来源和许可证边界见 ATTRIBUTION.md。

### Automated GitHub Release

推送符合 `vMAJOR.MINOR.PATCH` 格式的 Tag 后，GitHub Actions 会自动执行发布流程：

1. 在该 Tag 对应的提交上运行全部 validation、ShellCheck 和 npx smoke test；
2. 只有 `validate` job 成功时，才运行 `Publish GitHub Release` job；
3. 使用 GitHub 内置 `GITHUB_TOKEN` 验证远端 Tag 并创建正式 GitHub Release；
4. 使用 GitHub 自动生成 release notes，并将该版本标记为 latest。

因此，维护者只需要创建并推送一个 annotated Tag：

~~~sh
git tag -a v0.2.1 <release-commit> -m "v0.2.1 — CI-gated automated release"
git push origin v0.2.1
~~~

不需要手动打开 GitHub Release 页面，也不需要个人 access token。`v0.2.0` Tag 在自动发布 workflow 加入之前已经存在，因此不会被历史性重放；自动发布从后续符合格式的新 Tag 开始生效。若 job 报告 `Resource not accessible by integration`，在仓库的 Settings → Actions → General → Workflow permissions 中允许 workflow 使用 read and write permissions，然后重新推送一个新的版本 Tag。

## Design Principle

> Prefer the simplest architecture that preserves meaningful boundaries.
