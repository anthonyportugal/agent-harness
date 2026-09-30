# Instructions for AI Agents & Collaborators

These standards apply to the entire `agent-harness` repository.

---

## 1. Golden Rule & Authorization Gate

- **Mandatory Authorization Gate:** NEVER execute `git commit` or `git push` autonomously. You must ALWAYS propose the commit message first, stopping and waiting for explicit user approval before staging or committing.
- The user's most recent explicit instruction takes absolute precedence.

---

## 2. Engineering Protocol (ODD & 4R)

All tasks must strictly adhere to the built-in protocols:

1. **Phase 1: EXPLORE (Read-Only):**
   - Inspect files, map dependencies, and read rules before proposing changes.
2. **Phase 2: SPEC (Lossless Proposal):**
   - Detail scope, architectural impact, debt items, and edge cases. Stop for user approval.
3. **Phase 3: TASKS (Milestones):**
   - Break changes into testable, ordered steps.
4. **Phase 4: APPLY (Surgical Implementation):**
   - Edit ONLY authorized surfaces. No unsolicited refactors.
5. **Phase 5: VERIFY (Deterministic Proof):**
   - Run smoke tests, linters, and evaluate against the **4R Architectural Review Lenses**:
     - **R1: Risk** (Zero credentials, privilege boundaries, secure defaults).
     - **R2: Readability** (Catppuccin Mocha UI, clear naming, modular boundaries).
     - **R3: Reliability** (Deterministic contracts, automated smoke tests).
     - **R4: Resilience** (Graceful degradation, pipe safety with TTY detection).

---

## 3. Secret Hygiene & Data Safety

- Never output, copy, stage, or log secrets, API keys, tokens, SSH/GPG private keys, or `.env` credential files into chat prompts, persistent memory stores, or tracked Git files.
- Fail closed: if a command or script attempts to expose sensitive environment variables, abort immediately and alert the user.

---

## 4. Minimum Local Validations

Before proposing a diff or pull request, run the verification battery:

```bash
bash -n bin/agent-harness tests/smoke.sh .githooks/*
shellcheck -x bin/agent-harness tests/smoke.sh .githooks/*
./tests/smoke.sh
git diff --check
```

---

## 5. Commit Standards & Review Budget

When a commit is explicitly authorized by the user:

- **Gitmoji + Conventional Commits:** `<emoji> <type>(<scope>): <subject>`.
- **Subject:** English, imperative present tense, lowercase first word, no trailing period.
- **Review Budget:** Target under 400 lines of change per commit/PR.
- **Zero AI Attribution:** NEVER include `Co-Authored-By`, generative AI signatures, bot watermarks, or model identifiers in commit messages.
