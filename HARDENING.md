<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-template/v1.21.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-template/v1.21.1** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): A ${{ github.repository }} expression is directly interpolated inside a run: shell command string. This allows the value to be parsed by the shell before quoting, enabling script injection. The offending line is: `run: docker build . --file Dockerfile --tag ${{ github.repository }}:$(date +%s)`. Fix: move github.repository into an env: variable and reference it as "$ENV_VAR" in the run: block.

Locations:

- `.github/workflows/dockerimage.yml:10`

### missing-permissions (severity: medium)

None of the workflow files define a top-level `permissions:` key, and no job within any of these files defines job-level permissions either. Without explicit permissions, workflows run with the default (potentially broad) token permissions. All five workflow files are affected: depup.yml, dockerimage.yml, release.yml, reviewdog.yml, and test.yml.

Locations:

- `.github/workflows/depup.yml:1`
- `.github/workflows/dockerimage.yml:1`
- `.github/workflows/release.yml:1`
- `.github/workflows/reviewdog.yml:1`
- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, missing-permissions

**Notes:**

Fixed script injection in dockerimage.yml by moving `${{ github.repository }}` into an env: variable (REPOSITORY) and referencing it as "$REPOSITORY" in the run: block. Added minimal permissions blocks to all 5 workflow files: dockerimage.yml gets `permissions: {}` (no token needed), depup.yml gets `contents: write` + `pull-requests: write` (for PR creation), release.yml gets `contents: write` (for releases and tag updates), reviewdog.yml gets `checks: write` + `pull-requests: write` (for review annotations), and test.yml gets `checks: write` + `pull-requests: write` (for linter check reporting).

