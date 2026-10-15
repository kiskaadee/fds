#!/usr/bin/env bash
set -euo pipefail

# Configuration
IMAGE_NAME="fds:latest"
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure the container image exists; build it if missing
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
    echo "🔨 Building Docker image '$IMAGE_NAME'..."
    docker build -t "$IMAGE_NAME" "$WORKSPACE_DIR"
fi

echo "🚀 Entering $IMAGE_NAME container (workspace: $WORKSPACE_DIR)..."

# Run container interactively:
# - Mount local directory to /home/kiskaadee/fds for persistent work
# - Grant SYS_PTRACE and unconfined seccomp to allow strace / proc inspection of file descriptors
exec docker run --rm -it \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -v "$WORKSPACE_DIR:/home/kiskaadee/fds" \
    -w /home/kiskaadee/fds \
    "$IMAGE_NAME" "$@"
