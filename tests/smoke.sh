#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd -P)
HARNESS_CLI="$REPO_ROOT/bin/agent-harness"

fail() {
  printf 'FAIL: %s\n' "$*" >&2
  exit 1
}

printf '==> Running smoke tests for agent-harness...\n'

# 1. Verify required commands
for cmd in bash git; do
  command -v "$cmd" >/dev/null 2>&1 || fail "Missing required test command: $cmd"
done

# 2. Verify repository structure
printf '  Checking directory boundaries...\n'
for dir_name in bin rules mcp skills tests; do
  [[ -d "$REPO_ROOT/$dir_name" ]] || fail "Missing required directory: $dir_name"
done

[[ -f "$REPO_ROOT/README.md" ]] || fail "Missing README.md"
[[ -f "$REPO_ROOT/README.es.md" ]] || fail "Missing README.es.md"
[[ -f "$REPO_ROOT/LICENSE" ]] || fail "Missing LICENSE"
[[ -f "$REPO_ROOT/.gitignore" ]] || fail "Missing .gitignore"
[[ -x "$HARNESS_CLI" ]] || fail "CLI $HARNESS_CLI is not executable"
[[ -f "$REPO_ROOT/rules/persona.md" ]] || fail "Missing rules/persona.md"
[[ -f "$REPO_ROOT/rules/odd.md" ]] || fail "Missing rules/odd.md"
[[ -f "$REPO_ROOT/rules/conventions.md" ]] || fail "Missing rules/conventions.md"

# 3. Validate syntax (bash -n)
printf '  Validating bash syntax...\n'
bash -n "$HARNESS_CLI" "$SCRIPT_DIR/smoke.sh" || fail "Syntax validation failed"

# 4. ShellCheck linting if available
if command -v shellcheck >/dev/null 2>&1; then
  printf '  Running shellcheck...\n'
  shellcheck "$HARNESS_CLI" "$SCRIPT_DIR/smoke.sh" || fail "ShellCheck detected issues"
else
  printf '  [SKIP] ShellCheck not installed, skipping static analysis\n'
fi

# 5. Validate CLI commands execution
printf '  Verifying CLI plan command...\n'
plan_output=$("$HARNESS_CLI" plan)
echo "$plan_output" | grep -q 'Ambient Multi-Agent Harness' || fail "CLI plan output is missing architecture title"
echo "$plan_output" | grep -q 'Rules:' || fail "CLI plan output is missing Rules component"

printf '  Verifying CLI doctor command...\n'
"$HARNESS_CLI" doctor >/dev/null || fail "CLI doctor failed"

printf '  Verifying CLI status command...\n'
"$HARNESS_CLI" status >/dev/null || fail "CLI status failed"

# 6. Verify .gitignore protection
printf '  Checking .gitignore guards...\n'
grep -q '\.codegraph/' "$REPO_ROOT/.gitignore" || fail ".gitignore is missing .codegraph/ guard"
grep -q '\.engram/' "$REPO_ROOT/.gitignore" || fail ".gitignore is missing .engram/ guard"
grep -q '\.agents/' "$REPO_ROOT/.gitignore" || fail ".gitignore is missing .agents/ guard"

printf 'OK: all agent-harness smoke tests passed successfully\n'
