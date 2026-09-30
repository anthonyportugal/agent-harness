---
name: skill-creator
description: "Trigger: new skills, agent instructions, documenting AI usage patterns. Create LLM-first skills with valid frontmatter."
license: Apache-2.0
metadata:
  author: anthonyportugal
  version: "1.0"
---

## Activation Contract

Create a skill when:
- A pattern is used repeatedly and AI needs guidance
- Project-specific conventions differ from generic best practices
- Complex workflows need step-by-step instructions
- Decision trees help AI choose the right approach

Do not create a skill when the pattern is trivial, one-off, or better served by normal documentation.

## Hard Rules

- First follow `references/skill-style-guide.md` as the normative source before creating or updating skills.
- A skill is a runtime instruction contract for an LLM, not human documentation.
- Do not add a `Keywords` section; preserve essential trigger words in `description`.
- References must point to local files.
- Keep the skill body concise: target 180–450 tokens, recommended max 700, hard max 1000.

## Decision Gates

| Need | Action |
|------|--------|
| Code templates, schemas, fixtures, generated examples | Put them in `assets/` |
| Conceptual detail, edge cases, existing docs | Put local links in `references/` |
| Long explanation in `SKILL.md` | Move it to a supporting file |
| Multiple meaningful paths | Add a compact decision table |

## Execution Steps

1. Read `references/skill-style-guide.md` before writing.
2. Confirm the skill does not already exist and the pattern is reusable.
3. Create or update `skills/{skill-name}/SKILL.md` using this required structure:

```text
skills/{skill-name}/
├── SKILL.md              # Required - main skill file
├── assets/               # Optional - templates, schemas, examples
└── references/           # Optional - links to local docs
```

4. Use this frontmatter shape:

```markdown
---
name: {skill-name}
description: "Trigger: {essential trigger words users or agents will say}. {What this skill does}."
license: Apache-2.0
metadata:
  author: "{your-github-username}"
  version: "1.0"
---
```

5. Write sections in this order: Activation Contract, Hard Rules, Decision Gates, Execution Steps, Output Contract, References.

## Inline Fallback Rules

- `description` MUST be one physical line, quoted, YAML-safe, and include essential trigger words first.
- `description` SHOULD be <=160 chars and MUST be <=250 chars.
- Frontmatter MUST include `name`, `description`, `license`, `metadata.author`, and `metadata.version`.
- Use imperative instructions, not tutorials or background prose.
- Put supporting material in `assets/` or `references/`, not the main skill body.

## Output Contract

Return:
- Files created or modified.
- Summary of activation contract and decision gates.
- Any supporting files added under `assets/` or `references/`.

## References

- `references/skill-style-guide.md` — normative LLM-first skill style guide.
