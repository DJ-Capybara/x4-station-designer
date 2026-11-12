#!/bin/sh
set -eu

cd "$(dirname "$0")"

for tool in cargo node npm cc pkg-config; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        printf 'Missing required tool: %s. See BUILDING.md for setup.\n' "$tool" >&2
        exit 1
    fi
done

if ! node -e 'const [major, minor] = process.versions.node.split(".").map(Number); process.exit(major > 22 || (major === 22 && minor >= 12) ? 0 : 1)'; then
    printf 'Node.js 22.12 or newer is required.\n' >&2
    exit 1
fi

if ! pkg-config --exists webkit2gtk-4.1 gtk+-3.0; then
    printf 'Missing GTK or WebKitGTK development libraries. See BUILDING.md for setup.\n' >&2
    exit 1
fi

cargo fetch --locked
npm --prefix ui ci
npm --prefix ui run check
npm --prefix ui run build
cargo build -p x4sd --release --locked

printf '\nBuilt target/release/x4sd\n'