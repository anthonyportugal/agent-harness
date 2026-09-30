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

# Rules checks
[[ -f "$REPO_ROOT/rules/persona.md" ]] || fail "Missing rules/persona.md"
[[ -f "$REPO_ROOT/rules/odd.md" ]] || fail "Missing rules/odd.md"
[[ -f "$REPO_ROOT/rules/conventions.md" ]] || fail "Missing rules/conventions.md"
[[ -f "$REPO_ROOT/rules/memory.md" ]] || fail "Missing rules/memory.md"
[[ -f "$REPO_ROOT/rules/review-4r.md" ]] || fail "Missing rules/review-4r.md"

# MCP Catalog checks
[[ -f "$REPO_ROOT/mcp/codegraph.json" ]] || fail "Missing mcp/codegraph.json"
[[ -f "$REPO_ROOT/mcp/engram.json" ]] || fail "Missing mcp/engram.json"

# 3. Validate JSON syntax for MCP catalog
if command -v jq >/dev/null 2>&1; then
  printf '  Validating MCP JSON schemas and syntax...\n'
  for json_file in "$REPO_ROOT"/mcp/*.json; do
    jq . "$json_file" >/dev/null || fail "JSON validation failed for $json_file"
  done
fi

# 4. Validate bash syntax (bash -n)
printf '  Validating bash syntax...\n'
bash -n "$HARNESS_CLI" "$SCRIPT_DIR/smoke.sh" || fail "Syntax validation failed"

# 5. ShellCheck linting if available
if command -v shellcheck >/dev/null 2>&1; then
  printf '  Running shellcheck...\n'
  shellcheck "$HARNESS_CLI" "$SCRIPT_DIR/smoke.sh" || fail "ShellCheck detected issues"
else
  printf '  [SKIP] ShellCheck not installed, skipping static analysis\n'
fi

# 6. Validate CLI commands execution
printf '  Verifying CLI plan command...\n'
plan_output=$("$HARNESS_CLI" plan)
echo "$plan_output" | grep -q 'Ambient Multi-Agent Harness' || fail "CLI plan output is missing architecture title"
echo "$plan_output" | grep -q 'codegraph.json' || fail "CLI plan output is missing codegraph.json"
echo "$plan_output" | grep -q 'memory.md' || fail "CLI plan output is missing memory.md"
echo "$plan_output" | grep -q 'review-4r.md' || fail "CLI plan output is missing review-4r.md"

printf '  Verifying CLI doctor command...\n'
"$HARNESS_CLI" doctor >/dev/null || fail "CLI doctor failed"

printf '  Verifying CLI status command...\n'
"$HARNESS_CLI" status >/dev/null || fail "CLI status failed"

printf '  Verifying CLI mcp commands...\n'
mcp_list=$("$HARNESS_CLI" mcp list)
echo "$mcp_list" | grep -q 'codegraph' || fail "CLI mcp list is missing codegraph"
echo "$mcp_list" | grep -q 'engram' || fail "CLI mcp list is missing engram"

mcp_cfg=$("$HARNESS_CLI" mcp config generic)
echo "$mcp_cfg" | grep -q 'codegraph' || fail "CLI mcp config is missing codegraph"
echo "$mcp_cfg" | grep -q 'engram' || fail "CLI mcp config is missing engram"

# 7. Verify .gitignore protection
printf '  Checking .gitignore guards...\n'
grep -q '\.codegraph/' "$REPO_ROOT/.gitignore" || fail ".gitignore is missing .codegraph/ guard"
grep -q '\.engram/' "$REPO_ROOT/.gitignore" || fail ".gitignore is missing .engram/ guard"
grep -q '\.agents/' "$REPO_ROOT/.gitignore" || fail ".gitignore is missing .agents/ guard"

printf 'OK: all agent-harness smoke tests passed successfully\n'
