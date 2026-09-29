# Agent Harness (Arnés para Agentes de Desarrollo)

<p align="center">
  <a href="https://github.com/anthonyportugal/agent-harness/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/anthonyportugal/agent-harness/ci.yml?branch=main&style=flat-square&logo=githubactions&logoColor=white&label=CI" alt="CI"></a>
  <a href="https://kernel.org"><img src="https://img.shields.io/badge/OS-Linux-FCC624?style=flat-square&logo=linux&logoColor=black" alt="Linux"></a>
  <a href="https://archlinux.org"><img src="https://img.shields.io/badge/Arch_Linux-1793D1?style=flat-square&logo=archlinux&logoColor=white" alt="Arch Linux"></a>
  <a href="https://cachyos.org"><img src="https://img.shields.io/badge/CachyOS-Supported-00A86B?style=flat-square" alt="CachyOS"></a>
  <a href="https://modelcontextprotocol.io/"><img src="https://img.shields.io/badge/Protocol-MCP-8A2BE2?style=flat-square" alt="MCP"></a>
  <a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/CLI-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white" alt="Bash CLI"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License"></a>
</p>

*Leer esto en otros idiomas:* [English](README.md)

Arnés modular, reproducible y agnóstico de proveedor para agentes de desarrollo e IA. Establece una capa ambiental estandarizada para el comportamiento de agentes, inteligencia de código semántica (grafos de conocimiento AST), protocolos de memoria persistente y habilidades seleccionadas en cualquier estación de trabajo.

> [!TIP]
> 🧩 **Ecosistema Modular de Dotfiles:**  
> [Base y CLI](https://github.com/anthonyportugal/dotfiles) • [MangoWM (Wayland)](https://github.com/anthonyportugal/dotfiles-mangowm) • [BSPWM (X11)](https://github.com/anthonyportugal/dotfiles-bspwm) • [Fondos de Pantalla](https://github.com/anthonyportugal/walls) • [Sistema](https://github.com/anthonyportugal/dotfiles-system) • **Agent Harness [Actual]**
> 
> Diseñado para integrarse transparentemente con la base de dotfiles y el entorno de usuario, proporcionando inteligencia agéntica ambiental en todos tus proyectos de desarrollo sin contaminar repositorios ni generar deriva de configuración.

---

## ✨ Características Principales

- 🧠 **Persona de Arquitecto Sénior:** Impone una filosofía docente ("Conceptos > Código") donde el agente explica el *porqué* arquitectónico antes de generar soluciones.
- 📐 **Desarrollo Dirigido Orgánico (ODD):** Ciclo de vida estricto de 5 fases (Explorar ➔ Spec ➔ Tareas ➔ Aplicar ➔ Verificar) para evitar modificaciones apresuradas y sin validar.
- 🌳 **Inteligencia Semántica de Código:** Integración MCP declarativa con [Codegraph](https://github.com/anthonyportugal/codegraph) para exploración instantánea de grafos de llamadas, dependencias y análisis de impacto mediante AST y SQLite local.
- 💾 **Memoria Persistente entre Sesiones:** Protocolo de memoria Engram para preservar decisiones de arquitectura, gotchas y causas raíz de errores frente a compactaciones de contexto y sesiones independientes.
- 🎯 **Ambiental por Defecto, Quirúrgico por Demanda:** Cero configuración en proyectos individuales. Repositorios activos activan la indexación AST con un simple comando: `codegraph init`.
- 🛡️ **Seguridad por Aislamiento:** Separación estricta de responsabilidades. Las reglas globales y plantillas MCP son 100% públicas y seguras; identidades, credenciales y claves de firma permanecen aisladas en módulos privados.
- 🧪 **Verificación Local Automatizada:** Suite de pruebas integrada (`tests/smoke.sh`) que valida sintaxis bash (`bash -n`), análisis estático (`shellcheck`), límites de directorios y contratos de la CLI.

---

## 🧱 Estructura del Repositorio

```text
agent-harness/
├── bin/
│   └── agent-harness        # CLI de gestión (plan, doctor, status)
├── rules/                   # Instrucciones maestras (ODD, persona, convenciones)
├── mcp/                     # Catálogo declarativo de servidores MCP (Codegraph, Context7)
├── skills/                  # Registro de habilidades y manifiestos de instalación
├── tests/
│   └── smoke.sh             # Suite de pruebas automatizadas y análisis estático
├── LICENSE                  # Licencia MIT
├── README.md                # Documentación en inglés
└── README.es.md             # Documentación en español
```

---

## 🗺️ Estado de Implementación y Hoja de Ruta

| Fase | Hito | Capacidad | Estado |
| :--- | :--- | :--- | :---: |
| **01** | **Scaffolding y CI** | Estructura base, entrypoint CLI y suite de pruebas automatizadas | ✅ Completado |
| **02** | **Persona y ODD** | Persona docente de Arquitecto Sénior, flujo ODD y estándares de commit | ✅ Completado |
| **03** | **Inteligencia y Memoria** | Catálogo MCP de Codegraph y protocolo de memoria persistente Engram | 🔄 En Progreso |
| **04** | **Skills y Adaptadores** | Registro declarativo de skills y adaptadores de runtime (Antigravity, Claude, Codex, Gemini) | ⏳ Planificado |
| **05** | **Orquestación de Flotas** | Concurrencia multi-agente y coordinación distribuida mediante `herdr` | ⏳ Futuro |

---

## 🛠️ CLI de Gestión (`bin/agent-harness`)

El repositorio incluye una CLI independiente para auditar e inspeccionar el entorno de agentes:

```bash
# Mostrar la configuración activa del arnés y las rutas de sus componentes
./bin/agent-harness plan

# Auditar dependencias y herramientas locales (git, pnpm, codegraph, shellcheck)
./bin/agent-harness doctor

# Mostrar el estado actual del repositorio y metadatos de Git
./bin/agent-harness status
```

---

## 🧪 Pruebas y Verificación

Ejecutar la suite de pruebas de humo localmente:

```bash
./tests/smoke.sh
```

---

## 👤 Autor

Diseñado y mantenido por [Anthony Portugal](https://anthonyportugal.github.io/es/).

---

## 📄 Licencia y Reconocimientos

- **Licencia:** Distribuido bajo la [Licencia MIT](LICENSE).
- **Estándares:** Construido en torno al estándar abierto [Model Context Protocol (MCP)](https://modelcontextprotocol.io/) y los principios de Organic Driven Development.
