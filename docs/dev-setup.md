# Development setup

See [BUILDING.md](../BUILDING.md) for Linux dependencies, build commands and tests. The release executable is `target/release/x4sd`.

The MCP smoke test uses a scratch profile and requires game data:
```sh
python3 -I research/mcp_smoke.py target/release/x4sd <scratch-profile-dir>
```
Close any open builder first: the MCP server connects to its live design.

The frontend is built with Vite, TypeScript and Three.js and embedded by Tauri. The game uses left-handed coordinates (Y up), while Three.js uses right-handed coordinates; `ui/src/view3d.ts` mirrors Z when converting positions and rotations.

The Windows WebView2 smoke tests are not compatible with Linux WebKitGTK. Linux GUI smoke coverage remains to be implemented.