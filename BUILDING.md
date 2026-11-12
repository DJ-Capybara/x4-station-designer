# Building x4sd

## Linux setup

On Ubuntu, install the native build dependencies required by Tauri:
```sh
sudo apt update
sudo apt install build-essential pkg-config libwebkit2gtk-4.1-dev libxdo-dev libssl-dev libayatana-appindicator3-dev librsvg2-dev curl wget file
```

Install Rust stable and Node.js 22.12 or newer, and make sure `cargo`, `node` and `npm` are on `PATH`. From the project root, fetch the locked dependencies and build:
```sh
./build.sh
```

The equivalent manual steps are:
```sh
cargo fetch --locked
npm --prefix ui ci
npm --prefix ui run check
npm --prefix ui run build
cargo build -p x4sd --release --locked
```

The UI dependencies are installed in `ui/node_modules`, and build output is placed in `ui/dist` and `target`. Cargo and npm use their normal user-level caches. The selected game directory is saved in `x4sd/game-dir.txt` under `XDG_CONFIG_HOME`, or `~/.config` by default. Game integration has not yet been verified on Linux.

## Tests
```sh
cargo test --workspace --locked
npm --prefix ui run check
```
The game-data tests need X4: Foundations installed and skip when it cannot be found. Set `X4_GAME_DIR` to the game folder to run them. GitHub Actions runs these checks without the game and lints the workflow files.
