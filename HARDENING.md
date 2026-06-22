<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-template/v1.21.3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **reviewdog--action-template/v1.21.3** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile (referenced directly from action.yml via `image: 'Dockerfile'`) pipes remote content directly to a shell interpreter in two RUN steps. Line 9: `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/.../install.sh | sh -s -- ...` and Line 12: `wget -O - -q https://git.io/misspell | sh -s -- ...`. An attacker who can intercept or tamper with the remote URL (e.g. via a compromised CDN, DNS hijack, or a redirect from the URL shortener git.io) can execute arbitrary code during the Docker image build. The script should be downloaded to a file, its checksum verified, and then executed separately.

Locations:

- `Dockerfile:9`
- `Dockerfile:12`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed both unsafe pipe-to-shell patterns in the Dockerfile:
1. Line 9 (reviewdog): Changed `wget -O - -q <url> | sh -s -- ...` to download the script to /tmp/install-reviewdog.sh first, then execute with `sh`, then remove. The URL remains pinned to commit SHA fd59714416d6d9a1c0692d872e38e7f8448df4fc.
2. Line 12 (misspell): Changed `wget -O - -q https://git.io/misspell | sh -s -- ...` to use the direct GitHub raw URL (eliminating the git.io URL shortener), download to /tmp/install-misspell.sh, execute with `sh`, then remove. Both changes eliminate the unsafe wget|sh pipe-to-shell pattern.

