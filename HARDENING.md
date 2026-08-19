<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-template/v1.21.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-template/v1.21.3** was hardened automatically. 7 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): The `run:` block in the 'Build the Docker image' step directly interpolates the GitHub Actions expression `${{ github.repository }}` into a shell command string: `docker build . --file Dockerfile --tag ${{ github.repository }}:$(date +%s)`. This expression is substituted by the Actions runner before the shell ever sees the command, allowing an attacker who controls the repository name to inject arbitrary shell commands.

Locations:

- `.github/workflows/dockerimage.yml:12`

### script-injection (severity: high)

Sub-rule (b): In entrypoint.sh, the shell variable `${INPUT_REVIEWDOG_FLAGS}` (sourced from `inputs.reviewdog_flags`, a workflow-controlled value) is expanded **unquoted** as a positional argument to the `reviewdog` command on the final line: `${INPUT_REVIEWDOG_FLAGS}`. Without double-quoting, the shell parses metacharacters (`;`, `|`, `&`, `$(...)`, whitespace, glob chars) from the value, enabling command injection by any caller of this action. It should be `"${INPUT_REVIEWDOG_FLAGS}"` or use the guarded form `${INPUT_REVIEWDOG_FLAGS:+"$INPUT_REVIEWDOG_FLAGS"}`.

Locations:

- `entrypoint.sh:18`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and none of its jobs define a `permissions:` block. Without explicit permissions, the GITHUB_TOKEN is granted its default (often broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/depup.yml:1`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and none of its jobs define a `permissions:` block. Without explicit permissions, the GITHUB_TOKEN is granted its default (often broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/dockerimage.yml:1`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and none of its jobs define a `permissions:` block. Without explicit permissions, the GITHUB_TOKEN is granted its default (often broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/release.yml:1`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and none of its jobs define a `permissions:` block. Without explicit permissions, the GITHUB_TOKEN is granted its default (often broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/reviewdog.yml:1`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and none of its jobs define a `permissions:` block. Without explicit permissions, the GITHUB_TOKEN is granted its default (often broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, missing-permissions

**Notes:**

Fixed 7 findings across 6 files:
1. dockerimage.yml: Moved `${{ github.repository }}` to an env: block (REPOSITORY) and referenced it as "${REPOSITORY}" in the shell run command to prevent script injection. Also added `permissions: {}` top-level block.
2. entrypoint.sh: Changed unquoted `${INPUT_REVIEWDOG_FLAGS}` to the guarded form `${INPUT_REVIEWDOG_FLAGS:+"${INPUT_REVIEWDOG_FLAGS}"}` to prevent shell metacharacter injection while preserving optional-argument semantics.
3. depup.yml, release.yml, reviewdog.yml, test.yml: Added `permissions: {}` top-level block to each workflow to enforce least privilege instead of relying on broad default GITHUB_TOKEN permissions.

