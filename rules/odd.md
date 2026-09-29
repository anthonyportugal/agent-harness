# Protocol: Organic Driven Development (ODD)

ODD is the mandatory engineering workflow for all tasks. No code may be written without an approved specification and an evidence-backed verification plan.

---

## 1. Phase 1: EXPLORE (Read-Only Investigation)

- **Objective:** Discover facts and map dependencies before assuming how code works.
- **Actions:** Inspect repository layout, read imports, check tests, and query Codegraph for AST relationships.
- **Architectural Watchdog:** If technical debt, scalability risks, code smells, or tight coupling are observed in the touched surfaces:
  - Do NOT modify the code yet.
  - Document the finding, its technical impact, and surface it in the next phase.

---

## 2. Phase 2: SPEC (Lossless Proposal & Trade-offs)

- **Objective:** Align on the blueprint before touching the disk.
- **Contents of the Spec:**
  1. *Goal & Scope:* Exactly what will be changed.
  2. *Architectural Impact:* Files touched and components affected.
  3. *Technical Debt & Opportunities:* Items surfaced during exploration with a concrete recommendation (address now vs. defer).
  4. *Edge Cases & Risks:* Potential breakage, race conditions, or performance costs.
- **Blocking Gate:** STOP and wait for user approval before moving to implementation.

---

## 3. Phase 3: TASKS (Ordered Atomic Milestones)

- Break the approved specification into small, testable, and logically independent steps.
- Each milestone must have an explicit verification criteria.

---

## 4. Phase 4: APPLY (Surgical Implementation)

- **Strict Scope Boundaries:** Edit ONLY the surfaces authorized in the specification.
- **No Drive-by Refactoring:** Never perform silent, unsolicited renames or rewrites outside the agreed scope.
- **Follow Existing Patterns:** Respect the project's established conventions, naming schemes, and error-handling paradigms.

---

## 5. Phase 5: VERIFY (Deterministic Proof & Mentorship)

- **Objective:** Prove the solution works and leave the codebase cleaner than before.
- **Verification Battery:** Run focused unit tests, smoke tests, linters, and type-checkers.
- **4R Review Lens Summary:**
  - *Readability:* Is the code self-documenting and clean?
  - *Reliability:* Are error paths and edge cases handled?
  - *Resilience:* Does it fail safely under unexpected inputs?
  - *Risk / Future Debt:* What should be monitored or refactored next?
