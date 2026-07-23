<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-template/v1.21.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-template/v1.21.0** was hardened automatically. 6 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): The `run:` block in dockerimage.yml directly interpolates `${{ github.repository }}` into a shell command string. This expression is substituted by the Actions runner before the shell sees it, allowing an attacker who controls the repository name to inject arbitrary shell commands. Offending line: `run: docker build . --file Dockerfile --tag ${{ github.repository }}:$(date +%s)`

Locations:

- `.github/workflows/dockerimage.yml:10`

### permissions (severity: medium)

missing-permissions: The workflow file has no top-level `permissions:` key and no job-level `permissions:` key on any job. Without explicit permissions, the GITHUB_TOKEN is granted its default (potentially broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/depup.yml:1`

### permissions (severity: medium)

missing-permissions: The workflow file has no top-level `permissions:` key and no job-level `permissions:` key on any job. Without explicit permissions, the GITHUB_TOKEN is granted its default (potentially broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/dockerimage.yml:1`

### permissions (severity: medium)

missing-permissions: The workflow file has no top-level `permissions:` key and no job-level `permissions:` key on any job. Without explicit permissions, the GITHUB_TOKEN is granted its default (potentially broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/release.yml:1`

### permissions (severity: medium)

missing-permissions: The workflow file has no top-level `permissions:` key and no job-level `permissions:` key on any job. Without explicit permissions, the GITHUB_TOKEN is granted its default (potentially broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/reviewdog.yml:1`

### permissions (severity: medium)

missing-permissions: The workflow file has no top-level `permissions:` key and no job-level `permissions:` key on any job. Without explicit permissions, the GITHUB_TOKEN is granted its default (potentially broad) permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/test.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, permissions

**Notes:**

Fixed all 6 findings across 5 workflow files:

1. dockerimage.yml (script-injection + permissions): Moved `${{ github.repository }}` from the `run:` shell string into an `env:` block as `REPOSITORY`, referencing it as `"${REPOSITORY}"` in the shell. Added top-level `permissions: {}`.

2. depup.yml (permissions): Added top-level `permissions: {}` and job-level `contents: write` + `pull-requests: write` for the job that creates PRs.

3. release.yml (permissions): Added top-level `permissions: {}` plus job-level `contents: write` for the release job and `contents: read` + `pull-requests: write` for the release-check job.

4. reviewdog.yml (permissions): Added top-level `permissions: {}` plus job-level permissions for each job (checks: write + pull-requests: write for shellcheck/hadolint; checks: write for misspell/alex).

5. test.yml (permissions): Added top-level `permissions: {}` plus job-level permissions for each test job appropriate to the reporter type used.

