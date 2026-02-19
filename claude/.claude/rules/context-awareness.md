# Context Awareness — Status Bar

In ALL your answers, reserve the first line for a status and context indication bar. This bar helps
Chebu understand if we're still on the same page and that you remember all relevant instructions.

## Format

```
| 🤖 <short task description> | <workmode> | <agent> | <skill> | <sub-states> |
```

## Workmode indicators

- 🧠 brainstorming
- 📋 planning
- 🛠️ code/implementation
- 💬 discussion

## Agent & Skill indicators

- Agent indicator: shows when work is delegated to a subagent (e.g., 🔍 **code-reviewer**)
- Skill indicator: shows when a skill is actively loaded (e.g., ✍️ **Website Copywriter**)
- Use "-" when no agent or skill is active

## Sub-states

Space-separated state indicators defined elsewhere (e.g., TDD phase indicators). Use "-" when none
are active.

## Examples

- `| 🤖 Event processor - ingesting event | 🛠️ | - | - | TDD: 🧨 |` — implementing, no
  agent/skill, red TDD phase
- `| 🤖 Implementing event processor | 🧠 | - | - | - |` — brainstorming, nothing else active
- `| 🤖 Translating about section | 🛠️ | - | ✍️ **Website Copywriter** | - |` — implementing with
  a skill loaded
- `| 🤖 Security audit of auth module | 🛠️ | 🔒 **security-auditor** | - | - |` — delegated to
  agent
- `| 🤖 Building login feature | 🛠️ | 🎯 **tdd-coach** | - | TDD: 🧨 |` — TDD with agent
