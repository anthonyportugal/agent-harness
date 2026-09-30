# Persistent Memory Protocol (Engram)

This protocol governs persistent memory retention across agent sessions, context compactions, and restarts using **Engram**.

---

## 1. Core Philosophy

Memory is persistent institutional knowledge, not ephemeral conversation scratch space.
- **Concepts > Dumps**: Store distilled insights, design rationale, and root causes—never verbatim file dumps or chat history.
- **Delivery Guarantee (Golden Rule)**: Saving to memory (`mem_save`) is internal bookkeeping. It **NEVER** counts as answering the user. The user never sees memory tool executions. Always conclude turns with a complete, structured user-facing response.

---

## 2. When to Query Memory

1. **Task Bootstrap**:
   - Call `mem_context` at the beginning of a complex task or session to retrieve recent relevant context from previous sessions.
2. **Knowledge Retrieval**:
   - When the user asks *"remember"*, *"how did we solve"*, or references past architecture choices, invoke `mem_search` with focused keywords.
   - Use `mem_get_observation` to expand complete details when search results point to relevant prior solutions.

---

## 3. Proactive Save Triggers

Call `mem_save` **immediately and without waiting for explicit user prompting** when any of the following events occur:

| Trigger | Description | Required Memory Type |
| :--- | :--- | :--- |
| **Architectural Decision** | Selection of pattern, boundary design, state model, or structural boundary. | `architecture` |
| **Engineering Convention** | Newly documented workflow, naming scheme, toolchain standard, or rule. | `pattern` |
| **Root-Cause Bugfix** | Resolution of a non-trivial defect, including root cause and regression defense. | `bugfix` |
| **Codebase Discovery** | Discovery of hidden invariants, non-obvious gotchas, or legacy constraints. | `discovery` |
| **Tool / Dependency Choice** | Decision on libraries, bundlers, CLIs, or linters evaluated against tradeoffs. | `decision` |

---

## 4. Structured Memory Record Format

When persisting an observation via `mem_save`, adhere strictly to this schema:

- **title**: Concise, searchable verb phrase (e.g., `Configured Codegraph AST MCP server`).
- **type**: One of `architecture`, `decision`, `bugfix`, `discovery`, `pattern`, `config`.
- **scope**: `project` (default for repository work) or `personal` (for user-specific environment preferences).
- **content**:
  - **What**: One crisp sentence describing the change or conclusion.
  - **Why**: Motivation, user requirement, or technical problem solved.
  - **Where**: Concrete affected paths or files.
  - **Learned**: Non-obvious discoveries, gotchas, edge cases, or tradeoffs.

---

## 5. Security & Hygiene Boundaries

- **Zero-Secrets Policy**: NEVER persist API keys, tokens, credentials, SSH keys, private keys, passwords, or personal data.
- **No Speculation**: Only persist facts verified by working tree evidence, tests, or explicit user confirmation.
- **Topic Evolution**: For topics that evolve over time (e.g. `architecture/auth-boundary`), use consistent `topic_key` values to update existing knowledge rather than fragmenting it.
