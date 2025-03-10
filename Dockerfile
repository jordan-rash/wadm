FROM debian:bullseye-slim AS base

FROM base AS base-amd64
ARG BIN_AMD64
ARG BIN=$BIN_AMD64

FROM base AS base-arm64
ARG BIN_ARM64
ARG BIN=$BIN_ARM64

FROM base-$TARGETARCH

ARG USERNAME=wadm
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN addgroup --gid $USER_GID $USERNAME \
    && adduser --disabled-login -u $USER_UID --ingroup $USERNAME $USERNAME

# Copy application binary from disk
COPY --chown=$USERNAME ${BIN} /usr/local/bin/wadm

USER $USERNAME
# Run the application
ENTRYPOINT ["/usr/local/bin/wadm"]
