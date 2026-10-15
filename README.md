# File Descriptors Playground (`fds`)

A dedicated containerized sandbox for learning and experimenting with Linux file descriptors, system calls (`open`, `read`, `write`, `close`, `dup`, `pipe`), and inspection utilities (`strace`, `lsof`, `/proc/<pid>/fd`).

Follows the tutorial: [YouTube: File Descriptors Explained](https://www.youtube.com/watch?v=o9iZucYSkQA).

## Environment

The environment runs Void Linux inside Docker and includes:
- **Build toolchain**: `gcc`, `make`, `coreutils`
- **Tracing & Inspection**: `strace`, `lsof`, `procps-ng`
- **Documentation**: `man-pages`, `man-db`
- **Utilities**: `tree`, `less`, `curl`, `vim`, `nano`

The container mounts the `./data` directory directly at `/home/kiskaadee/fds` with matching host user UID (1000) so any code or notes created inside persist across container sessions while keeping the repository root clean. Tracing capabilities (`SYS_PTRACE`) are enabled.

## Quick Start

### 1. Enter the Container

Run the wrapper script from the host:

```bash
./enter.sh
```

This will automatically build the image if needed and open an interactive bash shell in the sandbox.

You can also pass one-off commands directly:

```bash
./enter.sh gcc --version
```

### 2. Basic Inspections to Try

Inspect the standard file descriptors of the current shell:

```bash
ls -l /proc/$$/fd
```

Trace file descriptor operations for any command:

```bash
strace -e trace=open,openat,read,write,close,dup,dup2 ls -l
```

List open files for a process:

```bash
lsof -p $$
```

## License

This repository is dedicated to the public domain under the [UNLICENSE](UNLICENSE).
