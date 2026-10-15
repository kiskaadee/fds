#!/usr/bin/env bash
set -euo pipefail

# Configuration
IMAGE_NAME="fds:latest"
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DATA_DIR="$WORKSPACE_DIR/data"
mkdir -p "$DATA_DIR"

# Ensure the container image exists; build it if missing
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
    echo "🔨 Building Docker image '$IMAGE_NAME'..."
    docker build -t "$IMAGE_NAME" "$WORKSPACE_DIR"
fi

echo "🚀 Entering $IMAGE_NAME container (workspace: $DATA_DIR)..."

# Run container interactively:
# - Mount host data directory to /home/kiskaadee/fds for persistent work
# - Grant SYS_PTRACE and unconfined seccomp to allow strace / proc inspection of file descriptors
exec docker run --rm -it \
    --hostname fds-lab \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -v "$DATA_DIR:/home/kiskaadee/fds" \
    -w /home/kiskaadee/fds \
    "$IMAGE_NAME" "$@"
