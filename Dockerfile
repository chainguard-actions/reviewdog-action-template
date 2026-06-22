FROM alpine:3.23

ENV REVIEWDOG_VERSION=v0.21.0

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

# hadolint ignore=DL3006
RUN apk --no-cache add git

# Download reviewdog install script pinned to a specific commit, then execute separately
RUN wget -q -O /tmp/install-reviewdog.sh \
      https://raw.githubusercontent.com/reviewdog/reviewdog/fd59714416d6d9a1c0692d872e38e7f8448df4fc/install.sh \
    && sh /tmp/install-reviewdog.sh -b /usr/local/bin/ ${REVIEWDOG_VERSION} \
    && rm /tmp/install-reviewdog.sh

# TODO: Install a linter and/or change docker image as you need.
# Download misspell install script to a file, then execute separately (avoids pipe-to-shell)
RUN wget -q -O /tmp/install-misspell.sh \
      https://raw.githubusercontent.com/client9/misspell/master/install-misspell.sh \
    && sh /tmp/install-misspell.sh -b /usr/local/bin/ \
    && rm /tmp/install-misspell.sh

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
