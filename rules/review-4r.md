# 4R Architectural Review Protocol

This protocol defines the **4R Architectural Review framework** for evaluating code changes, pull requests, and system designs. Rather than relying on subjective code reviews, all architectural audits evaluate four concrete, objective dimensions.

---

## 1. The 4 Review Lenses (4R)

```
        ┌─────────────────────────────────────────────────────────┐
        │                 4R Architectural Review                 │
        └────────────────────────────┬────────────────────────────┘
                                     │
         ┌───────────────┬───────────┴───────────┬───────────────┐
         ▼               ▼                       ▼               ▼
     R1: RISK     R2: READABILITY         R3: RELIABILITY  R4: RESILIENCE
   (Security &     (Maintainability        (Contracts &     (Fault Tolerance
   Boundaries)        & Design)             Edge Cases)      & Degradation)
```

---

### R1 — Risk (Security & Privilege Boundaries)
Focuses on threat exposure, privilege escalation, and data leaks.

- **Secrets & Credentials**:
  - Flag any committed API keys, JWT secrets, database connection strings, or access tokens.
- **Privilege Boundaries**:
  - Prohibit frontend-only authorization checks. All business constraints must be enforced authoritatively in backend services or core domain layers.
- **Input Sanitization**:
  - Guard against injection vectors (SQL, shell/bash command execution, dynamic eval, HTML/DOM sinks).
  - Ensure all database queries use parameterized statements.
- **Dependency Hygiene**:
  - Audit added third-party dependencies for known CVEs, unmaintained status, or excessive privilege requirements.

---

### R2 — Readability (Maintainability & Architectural Clarity)
Focuses on cognitive load, long-term maintainability, and clean code foundations.

- **Expressive Intent**:
  - Identifiers (variables, functions, types) must reveal intent. Avoid cryptic abbreviations or misleading naming.
- **Cognitive & Cyclomatic Complexity**:
  - Flag deeply nested logic (`>3` indentation levels) and overgrown functions (`>50` lines). Decompose into single-responsibility units.
- **Structural Separation**:
  - Preserve architectural boundaries (e.g., domain logic decoupled from framework infrastructure, container vs. presentational components).
- **Technical Debt & Over-Engineering**:
  - Flag premature abstractions created without at least two concrete use cases. Remove dead code, redundant wrappers, and obsolete comments.

---

### R3 — Reliability (Contracts, Determinism & Tests)
Focuses on runtime correctness, contract guarantees, and regression prevention.

- **Behavior-First Testing**:
  - Tests must verify observable contracts, state transitions, and business invariants—not internal implementation trivia or fragile mocks.
- **Boundary & Edge-Case Coverage**:
  - Validate handling of nil/null, empty collections, extreme boundary inputs, and network timeouts.
- **Determinism & Idempotence**:
  - Eliminate test flakiness, race conditions, and hidden assumptions about execution order or filesystem state.
- **Regression Defense**:
  - Every bug fix must include an automated regression test reproducing the original defect.

---

### R4 — Resilience (Fault Tolerance & Graceful Degradation)
Focuses on operational stability under failure conditions and service degradation.

- **Graceful Degradation**:
  - Ensure operations degrade gracefully with sensible fallbacks when external APIs or optional services are unavailable.
- **Retry & Backoff Discipline**:
  - Prohibit unbounded retry loops. Require capped exponential backoff with jitter for network operations.
- **Observability**:
  - Emit structured, actionable error logs with context (request ID, tenant, timestamp). Avoid noisy, uninformative log spam.
- **Rollback Safety**:
  - Verify that migrations and data schema alterations are backward-compatible and safe for zero-downtime rollbacks.

---

## 2. Severity Classification

| Severity | Definition | Action Required |
| :--- | :--- | :--- |
| **`BLOCKER`** | Security vulnerability, data loss potential, or breaking architectural invariant. | **Must be resolved immediately.** Blocks merge/deployment. |
| **`CRITICAL`** | Severe logic flaw, missing auth check, or unhandled high-probability failure. | **Must be corrected** before passing review gate. |
| **`WARNING`** | Unwarranted complexity, missing edge-case test, or minor debt. | Flagged in review; can proceed with documented rationale. |
| **`SUGGESTION`**| Code style refinement, documentation enhancement, or micro-optimization. | Optional improvements; non-blocking. |

---

## 3. Findings Ledger Format

When auditing changes, the reviewer produces a structured findings report:

```markdown
### 4R Audit Findings

| ID | Lens | Severity | Location | Claim & Evidence | Recommended Mitigation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| R1-01 | R1 (Risk) | BLOCKER | `src/auth.ts:42` | Raw string concatenation in SQL query | Use parameterized query builder |
| R2-01 | R2 (Readability) | WARNING | `src/service.ts:115` | Cyclomatic complexity 14 in `processOrder` | Extract payment calculation helper |
| R3-01 | R3 (Reliability) | CRITICAL | `src/worker.ts:88` | Unhandled rejection when Redis drops connection | Wrap in try/catch and emit error metric |
| R4-01 | R4 (Resilience) | WARNING | `src/client.ts:30` | Infinite retry loop without exponential backoff | Add max 3 attempts with exponential backoff |
```
