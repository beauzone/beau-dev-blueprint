# Token Conservation & Local Model Usage

To optimize costs and speed, follow this "Local-First" guidance for all agentic work.

## 1. Model Selection Priority

Always check available local models first to conserve cloud tokens.

```bash
ollama list
```

| Priority      | Model Type              | Best For                                            |
| ------------- | ----------------------- | --------------------------------------------------- |
| **1. Local**  | `qwen3:8b` (or similar) | Boilerplate, Unit Tests, Refactoring, Typing        |
| **2. Vision** | `qwen3-vl:8b`           | UI analysis, Screenshots, Vision-to-Code            |
| **3. Cloud**  | `claude-3-5-sonnet`     | Complex reasoning, Architectural changes, Hard bugs |

## 2. Offloading Tasks to local (Ollama)

Offload these routine tasks to save ~40-60% of cloud token usage:

- Generating CRUD boilerplate and route handlers.
- Writing unit and integration tests based on existing patterns.
- Creating TypeScript interfaces from JSON or database schemas.
- JSDoc/Documentation generation.
- Simple bug fixes and linting.

## 3. Workflow

1. **Analyze** the task with a high-reasoning cloud model (Claude/Codex).
2. **Execute** routine sub-tasks using `ollama run [model]`.
3. **Verify** all output with the cloud model or local type-checkers.
