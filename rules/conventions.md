# Protocol: Universal Engineering Conventions

Strict standards governing Git workflows, package management, runtime safety, and documentation queries.

---

## 1. Git Workflow & Commit Authorization

- **Mandatory Authorization Gate:** NEVER execute `git commit` or `git push` autonomously. You must ALWAYS draft and propose the commit message first, stopping and waiting for explicit user confirmation.
- **Gitmoji + Conventional Commits:**
  - Format: `<emoji> <type>(<scope>): <subject>`
  - The `<subject>` must be written in **English**, imperative present tense, lowercase for the first word following the colon, and have **no trailing period**.
  - Example: `✨ feat(rules): add unified conventions protocol`
- **Zero AI Attribution:** NEVER include `Co-Authored-By`, generative AI signatures, bot watermarks, or model identifiers in commit messages.

---

## 2. Package Management & OS Toolchains

- **JavaScript / Node.js Ecosystem:**
  - Exclusively use `pnpm` (and `pnpm dlx`) as the package manager and CLI runner.
  - The use of `npm`, `npx`, or `yarn` is strictly forbidden unless an existing legacy repository contains an incompatible lockfile (`package-lock.json` or `yarn.lock`).
- **Arch Linux & CachyOS Toolchains:**
  - Respect the active userland AUR helper (`shelly`, `paru`, `yay`) **without `sudo`**.
  - NEVER execute `sudo yay`, `sudo paru`, or `sudo shelly`.
  - Use `sudo pacman` only as a secondary fallback when no AUR helper is present in the environment.

---

## 3. Live Documentation Protocol (Context7)

- When an implementation depends on an external library, framework, SDK, CLI tool, or cloud API, query up-to-date documentation via Context7 instead of relying on stale or hallucinated model memory.
- **Standard Context7 Flow:**
  1. Resolve the authoritative library ID:
     ```bash
     pnpm dlx ctx7@latest library <name> "<query>"
     ```
  2. Query specific concepts using the resolved ID:
     ```bash
     pnpm dlx ctx7@latest docs <library-id> "<query>"
     ```
- Do not use Context7 for general programming concepts, domain business logic, or pure refactoring. Limit queries to at most three focused requests per problem.

---

## 4. Secret Hygiene & Data Safety

- Never output, copy, stage, or log secrets, API keys, tokens, SSH/GPG private keys, or `.env` credential files into chat prompts, persistent memory stores, or tracked Git files.
- Fail closed: if a command or script attempts to expose sensitive environment variables, abort immediately and alert the user.
