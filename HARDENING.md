<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-template/v1.20.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-template/v1.20.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a) violation: The `run:` block in dockerimage.yml directly interpolates the GitHub Actions expression `${{ github.repository }}` into a shell command string: `docker build . --file Dockerfile --tag ${{ github.repository }}:$(date +%s)`. Any `${{ ... }}` expression inside a `run:` block is substituted by the YAML template engine before the shell ever sees it, allowing an attacker who can influence the value (e.g. via a fork with a crafted repository name) to inject arbitrary shell commands. The value should be passed via an `env:` variable and referenced as a quoted shell variable instead.

Locations:

- `.github/workflows/dockerimage.yml:13`

### missing-permissions (severity: medium)

None of the workflow files define a top-level `permissions:` block, and no individual job within any of these files defines a job-level `permissions:` block. This means all workflows run with GitHub's default permissions, which grant `contents: write` on push events and other broad access. Each workflow should declare the minimal permissions required (e.g. `permissions: read-all` or specific scopes like `contents: read`).

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

Fixed script-injection in dockerimage.yml by moving `${{ github.repository }}` into an `env:` block (as REPOSITORY) and referencing it as a quoted shell variable `"$REPOSITORY"` in the run command. Added top-level `permissions:` blocks to all 5 workflow files with minimal required permissions: dockerimage.yml gets `contents: read`; depup.yml gets `contents: write` and `pull-requests: write`; release.yml gets `contents: write`; reviewdog.yml gets `contents: read`, `checks: write`, and `pull-requests: write`; test.yml gets `contents: read`, `checks: write`, and `pull-requests: write`.

