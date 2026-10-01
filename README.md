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

Modular, reproducible, and vendor-agnostic development harness for AI coding agent CLIs. Establishes a standardized ambient layer for agent behavior, semantic code intelligence (AST knowledge graphs), persistent memory protocols, 4R architectural audits, and curated skills across any workstation.

> [!TIP]
> 🧩 **Modular Dotfiles Ecosystem:**  
> [Base & CLI](https://github.com/anthonyportugal/dotfiles) • [MangoWM (Wayland)](https://github.com/anthonyportugal/dotfiles-mangowm) • [BSPWM (X11)](https://github.com/anthonyportugal/dotfiles-bspwm) • [Wallpapers](https://github.com/anthonyportugal/walls) • [System](https://github.com/anthonyportugal/dotfiles-system) • **Agent Harness [Current]**
> 
> Designed to integrate seamlessly with the dotfiles base and userland toolchains, providing ambient agent intelligence across all development projects without repository pollution or configuration drift.

---

## ✨ Key Highlights

- 🧠 **Senior Architect Persona:** Enforces a teaching-first philosophy ("Concepts > Code") where the agent explains the architectural *why* before producing code.
- 📐 **Organic Driven Development (ODD):** Strict 5-phase engineering lifecycle (Explore ➔ Spec ➔ Tasks ➔ Apply ➔ Verify) preventing hasty, unverified diffs.
- 🔍 **4R Architectural Review:** Objective audit framework evaluating Risk (security), Readability (maintainability), Reliability (contracts & tests), and Resilience (fault tolerance).
- 🌳 **Semantic Code Intelligence:** Declarative MCP integration with [Codegraph](https://github.com/colbymchenry/codegraph) for instant call-graph exploration, caller/callee paths, and blast radius analysis via local SQLite/AST.
- 💾 **Persistent Cross-Session Memory:** Engram memory protocol preserving architectural decisions, gotchas, and bug root causes across context compactions and separate sessions.
- ⚡ **Multi-Runtime CLI Adapters:** Single-command setup (`agent-harness setup`) linking MCP servers and compiled rules across **Antigravity CLI**, **Claude Code CLI**, **OpenAI Codex CLI**, and **OpenCode CLI**.
- 🎯 **Ambient by Default, Surgical by Activation:** Zero project-level configuration needed. Active projects enable AST graph indexing with a single `codegraph init`.
- 🛡️ **Fail-Closed Privacy:** Clean separation of concerns. Global instructions and MCP templates remain 100% public-safe; identities, credentials, and signing keys stay strictly isolated in private modules.
- 🧪 **Automated Local Verification:** Built-in test suite (`tests/smoke.sh`) validating shell syntax (`bash -n`), static analysis (`shellcheck`), directory boundaries, and CLI command contracts.

---

## 🧱 Repository Structure

```text
agent-harness/
├── bin/
│   └── agent-harness        # Management CLI (plan, doctor, rules, mcp, skills, setup)
├── config/                  # Cognitive tier model templates
│   └── models.env.example   # Decoupled tier mappings for frontier models
├── rules/                   # Master agent instructions
│   ├── persona.md           # Senior Architect & Mentor persona
│   ├── odd.md               # Adaptive Organic Driven Development workflow
│   ├── orchestration.md     # Multi-agent delegation & cognitive tiers
│   ├── conventions.md       # Engineering conventions & toolchain standards
│   ├── memory.md            # Persistent memory protocol (Engram)
│   └── review-4r.md         # 4R Architectural Review framework
├── mcp/                     # Declarative MCP server catalog
│   ├── codegraph.json       # AST code intelligence on stdio
│   └── engram.json          # Persistent memory database on stdio
├── skills/                  # Curated ambient skills
│   └── manifest.json        # Curated skills registry (Context7, Gitmoji, Discovery)
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
| **02** | **Persona & ODD** | Senior Architect teaching persona, ODD workflow, and commit standards | ✅ Complete |
| **03** | **Intelligence & Memory** | Codegraph AST MCP catalog, Engram memory protocol, and 4R review framework | ✅ Complete |
| **04** | **Skills & CLI Adapters** | Curated skills manifest, runtime adapters (Antigravity, Claude, Codex, OpenCode) & setup | ✅ Complete |
| **05** | **Multi-Agent Orchestration** | Cognitive tiers (Thinker, Worker, Sentinel), adaptive 2-speed ODD, and cross-runtime delegation | ✅ Complete |

---

## 🛠️ Management CLI (`bin/agent-harness`)

The repository includes a standalone management CLI to audit, inspect, and configure agent environments:

```bash
# Display active harness architecture and supported agent CLIs
./bin/agent-harness plan

# Audit local toolchains, CLI agents, and catalog integrity
./bin/agent-harness doctor

# Compile modular rules into a single markdown document
./bin/agent-harness rules assemble

# List registered MCP servers in catalog
./bin/agent-harness mcp list

# List curated skills from manifest
./bin/agent-harness skills list

# Setup and configure all agent CLIs (dry-run mode available)
./bin/agent-harness setup --target all --dry-run
./bin/agent-harness setup --target claude
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
