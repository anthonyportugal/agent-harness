# Protocol: Multi-Agent Orchestration & Tier-Based Delegation

This protocol governs the multi-agent orchestration lifecycle, role boundaries, and tier-based delegation across all supported agent runtimes (Antigravity, Claude Code, Codex, and OpenCode).

---

## 1. Cognitive Tier Abstraction (Decoupling Invariant)

To prevent repository obsolescence as foundation models evolve, rules and prompt contracts **must never hardcode commercial model identifiers** (e.g., `gemini-3.8-flash`, `claude-opus-5-5`, `gpt-6.1-sol`). Instead, tasks and subagents are bound to abstract **Cognitive Tiers**:

| Tier Identifier | Cognitive Profile | Primary Responsibilities | Target Economics |
| :--- | :--- | :--- | :--- |
| **`TIER_ARCHITECT`** (Lead / Thinker) | Deep Reasoning & Broad Context | System design, AST exploration, Engram memory retrieval, ODD specification, atomic milestone decomposition, and final alignment. | High reasoning effort; bounded execution turns. |
| **`TIER_WORKER`** (Builder / Executor) | High Throughput & Low Latency | Surgical implementation of agreed tasks, unit test generation, mechanical refactoring, syntax and lint fixes. | High tokens/sec, low cost per turn, parallel execution. |
| **`TIER_SENTINEL`** (Auditor / 4R Lens) | Analytical Verification & Strict Gate | Independent verification of diffs against the 4R Review Lens (Risk, Readability, Reliability, Resilience) before requesting user commit authorization. | Read-only sandbox; zero code modification privilege. |

> [!NOTE]
> Physical model mapping is resolved at the runtime/environment layer (`~/.config/agent-harness/models.env` or local agent CLI settings). The repository remains 100% stable across model generation upgrades.

---

## 2. Adaptive Two-Speed ODD Lifecycle

To prevent the administrative bloat and friction of excessive specification files, agents must follow an **adaptive two-speed workflow**:

### Track A: Micro-Tasks (Fast-Path)
- **Applicability:** Changes affecting `< 50` lines of code, single-file edits, minor bugfixes, or routine configuration adjustments.
- **Workflow:**
  1. Explore target file and local tests.
  2. Implement change surgically.
  3. Run local verification battery (`tests/smoke.sh`, linters).
  4. Present proposed diff and commit message directly to the user.
- **Zero Disk Pollution:** NEVER create temporary task files, specification documents, or tracking receipts on disk for micro-tasks.

### Track B: Macro-Tasks (Structured Architectural Path)
- **Applicability:** Architectural changes, new features touching multiple modules, schema migrations, or public API refactors.
- **Workflow:**
  1. **Phase 1 (Explore):** Inspect AST relationships with Codegraph, read existing code, and query Engram (`mem_context` / `mem_search`).
  2. **Phase 2 (Spec Gate):** Present a structured specification (Scope, Architecture Impact, Debt, Edge Cases) in the conversation or scratch area. **STOP and wait for user approval.**
  3. **Phase 3 (Tasks):** Decompose the approved spec into ordered, atomic milestones with verifiable completion gates.
  4. **Phase 4 (Apply):** Delegate surgical implementation to Worker subagents or execute task-by-task.
  5. **Phase 5 (Audit & Verify):** Run Sentinel audit and local smoke tests before asking for commit authorization.

---

## 3. Subagent Delegation Contract

When delegating sub-tasks across runtimes:

1. **Context Boundary:** Subagents must receive crisp, self-contained prompts containing:
   - Target files and exact symbol references.
   - Specific acceptance criteria and test commands.
   - Strict scope boundaries (do NOT touch unlisted files).
2. **Workspace Isolation:**
   - **Shared Workspace (`share`):** Used when the Worker subagent performs direct edits in the working tree that will be reviewed immediately.
   - **Branch / Worktree Workspace (`branch`):** Used for speculative research, hazardous refactoring, or independent spike experiments.
3. **No Autonomous Commits:** Subagents are strictly prohibited from staging (`git add`), committing (`git commit`), or pushing (`git push`) repository state. All persistence requires explicit human authorization through the primary Lead Architect.
4. **Sentinel Verification Lens:**
   - The Sentinel auditor runs with `edit: deny` (read-only) privileges.
   - Evaluates the working tree diff against R1 (Secrets/Threats), R2 (Complexity), R3 (Contracts/Tests), and R4 (Resilience).
   - If findings of severity `BLOCKER` or `CRITICAL` exist, execution halts and returns to the Builder before notifying the user.
5. **Hierarchical Topology & Contract-First Coordination:**
   - Subagents communicate strictly upward with the Lead Architect; direct horizontal communication between subagents is prohibited by default to prevent token burning, split-brain scope creep, and cognitive deadlocks.
   - When collaboration between tasks is required, the Architect defines explicit interface contracts. If a subagent discovers a contract flaw or requires additional capabilities, it escalates upward to the Architect.
6. **Concurrency Partitioning Invariant:**
   - The Lead Architect is the sole authority responsible for analyzing dependency boundaries.
   - When a macro-task spans multiple independent repositories or decoupled submodules with zero cross-dependencies, the Architect *must* partition the implementation into parallel Worker subagents to maximize throughput and minimize wall-clock latency.

---

## 4. Runtime Mapping Matrix

| Runtime | Lead / Architect | Worker / Builder | Sentinel / Auditor |
| :--- | :--- | :--- | :--- |
| **Antigravity CLI** | `Model: pro` or `inherit` | `invoke_subagent` (`Model: flash`, `Workspace: share`) | `invoke_subagent` (`Model: flash_lite`, `Role: Sentinel`) |
| **OpenCode** | `model` in `opencode.json` | `small_model` / `agent.builder` | `agent.sentinel` (`permission: { edit: deny }`) |
| **Claude Code** | Global session / `settings.json` | Background subagent / worktree | Subagent defined in `.claude/agents/sentinel.md` |
| **Codex CLI** | Primary terminal session | Multi-Agent V2 subagent | `AGENTS.md` verification gate |
