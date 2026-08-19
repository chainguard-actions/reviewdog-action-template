<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-template/v1.21.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-template/v1.21.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): A `${{ github.repository }}` expression is directly interpolated inside a `run:` shell command string. This value flows through YAML template substitution before the shell processes it, enabling script injection if the repository name contains shell metacharacters. Offending line: `run: docker build . --file Dockerfile --tag ${{ github.repository }}:$(date +%s)`

Locations:

- `.github/workflows/dockerimage.yml:12`

### missing-permissions (severity: medium)

None of the workflow files define a `permissions:` key at the top level or at the job level. Without explicit permissions, workflows run with the default (potentially broad) token permissions. All five workflow files are affected: depup.yml, dockerimage.yml, release.yml, reviewdog.yml, and test.yml.

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

Fixed script-injection in dockerimage.yml by moving `${{ github.repository }}` into an `env:` block (as REPOSITORY) and referencing it as `"$REPOSITORY"` in the run command. Added `permissions: {}` at the top level of all five workflow files (depup.yml, dockerimage.yml, release.yml, reviewdog.yml, test.yml) to address the missing-permissions finding.

