# Agent Harness

<p align="center">
  <a href="https://github.com/anthonyportugal/agent-harness/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/anthonyportugal/agent-harness/ci.yml?branch=main&style=flat-square&logo=githubactions&logoColor=white&label=CI" alt="CI"></a>
  <a href="https://kernel.org"><img src="https://img.shields.io/badge/OS-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux"></a>
  <a href="https://archlinux.org"><img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=archlinux&logoColor=white" alt="Arch Linux"></a>
  <a href="https://cachyos.org"><img src="https://img.shields.io/badge/CachyOS-Supported-00A86B?style=flat-square" alt="CachyOS"></a>
  <a href="https://modelcontextprotocol.io/"><img src="https://img.shields.io/badge/Protocol-MCP-8A2BE2?style=flat-square" alt="MCP"></a>
  <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/CLI-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white" alt="Bash CLI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License"></a>
</p>

*Read this in other languages:* [Español](README.es.md)

Modular, reproducible, and vendor-agnostic development harness for AI coding agents. Establishes a standardized ambient layer for agent behavior, semantic code intelligence (AST knowledge graphs), persistent memory protocols, and curated skills across any workstation.

> [!TIP]
> 🧩 **Modular Dotfiles Ecosystem:**  
> [Base & CLI](https://github.com/anthonyportugal/dotfiles) • [MangoWM (Wayland)](https://github.com/anthonyportugal/dotfiles-mangowm) • [BSPWM (X11)](https://github.com/anthonyportugal/dotfiles-bspwm) • [Wallpapers](https://github.com/anthonyportugal/walls) • [System](https://github.com/anthonyportugal/dotfiles-system) • **Agent Harness [Current]**
> 
> Designed to integrate seamlessly with the dotfiles base and userland toolchains, providing ambient agent intelligence across all development projects without repository pollution or configuration drift.

---

## ✨ Key Highlights

- 🧠 **Senior Architect Persona:** Enforces a teaching-first philosophy ("Concepts > Code") where the agent explains the architectural *why* before producing code.
- 📐 **Organic Driven Development (ODD):** Strict 5-phase engineering lifecycle (Explore ➔ Spec ➔ Tasks ➔ Apply ➔ Verify) preventing hasty, unverified diffs.
- 🌳 **Semantic Code Intelligence:** Declarative MCP integration with [Codegraph](https://github.com/anthonyportugal/codegraph) for instant call-graph exploration, caller/callee paths, and blast radius analysis via local SQLite/AST.
- 💾 **Persistent Cross-Session Memory:** Engram memory protocol preserving architectural decisions, gotchas, and bug root causes across context compactions and separate sessions.
- 🎯 **Ambient by Default, Surgical by Activation:** Zero project-level configuration needed. Active projects enable AST graph indexing with a single `codegraph init`.
- 🛡️ **Fail-Closed Privacy:** Clean separation of concerns. Global instructions and MCP templates remain 100% public-safe; identities, credentials, and signing keys stay strictly isolated in private modules.
- 🧪 **Automated Local Verification:** Built-in test suite (`tests/smoke.sh`) validating shell syntax (`bash -n`), static analysis (`shellcheck`), directory boundaries, and CLI command contracts.

---

## 🧱 Repository Structure

```text
agent-harness/
├── bin/
│   └── agent-harness        # Management CLI (plan, doctor, status)
├── rules/                   # Master agent instructions (ODD, persona, conventions)
├── mcp/                     # Declarative MCP server catalog (Codegraph, Context7)
├── skills/                  # Curated skills registry and installation manifests
├── tests/
│   └── smoke.sh             # Local automated smoke tests and static analysis
├── LICENSE                  # MIT License
├── README.md                # English documentation
└── README.es.md             # Spanish documentation
```

---

## 🗺️ Roadmap & Implementation Status

| Phase | Milestone | Capability | Status |
| :--- | :--- | :--- | :---: |
| **01** | **Scaffolding & CI** | Clean architecture layout, CLI entrypoint, and automated test suite | ✅ Complete |
| **02** | **Persona & ODD** | Senior Architect teaching persona, ODD workflow, and commit standards | 🔄 In Progress |
| **03** | **Intelligence & Memory** | Codegraph AST MCP catalog and Engram persistent memory protocol | ⏳ Planned |
| **04** | **Skills & Adapters** | Declarative skills registry and runtime adapters (Antigravity, Claude, Codex, Gemini) | ⏳ Planned |
| **05** | **Fleet Orchestration** | Multi-agent concurrency and distributed coordination via `herdr` | ⏳ Future |

---

## 🛠️ Management CLI (`bin/agent-harness`)

The repository includes a standalone management CLI to audit and inspect the ambient agent environment:

```bash
# Display the active agent harness configuration and component paths
./bin/agent-harness plan

# Audit local toolchains and dependencies (git, pnpm, codegraph, shellcheck)
./bin/agent-harness doctor

# Display current repository status and Git metadata
./bin/agent-harness status
```

---

## 🧪 Testing & Verification

Run the automated smoke test suite locally:

```bash
./tests/smoke.sh
```

---

## 👤 Author

Architected and maintained by [Anthony Portugal](https://anthonyportugal.github.io).

---

## 📄 License & Acknowledgements

- **License:** Distributed under the [MIT License](LICENSE).
- **Standards:** Built around the open [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) and Organic Driven Development principles.
