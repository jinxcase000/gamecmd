# gamecmd

A simple Steam launch option manager for Linux. Define per-game environment variables, prefix commands, and suffix arguments in a clean YAML config file — no more fiddling with long strings in Steam's launch options box.

---

## Requirements

- Fish shell
- [`yq`](https://github.com/mikefarah/yq) (installed automatically by the install script)

---

## Installation

```bash
git clone https://github.com/jinxcase000/gamecmd.git
cd gamecmd
chmod +x install.sh
./install.sh
```

The installer will:
- Install `yq` if it isn't already present (supports pacman, apt, dnf, zypper)
- Copy `games.yaml` to `~/.config/gamecmd/games.yaml`
- Copy the `gamecmd` script to `~/.local/bin/gamecmd`

---

## Usage

In Steam, set the launch options for your game to:

```
gamecmd <profile> %command%
```

For example:

```
gamecmd stalker2 %command%
```

---

## Configuration

Edit `~/.config/gamecmd/games.yaml` to manage your game profiles:

```yaml
# Each profile supports three optional fields:
#   env_vars: environment variables set before launch
#   prefix:   commands that run before the game executable
#   suffix:   arguments passed after the game executable

stalker2:
  env_vars: __GL_THREADED_OPTIMIZATIONS=1
  prefix: gamemoderun
  suffix: -novid -high

blasphemous2:
  env_vars: GAMEMODE=1
  prefix: mangohud gamemoderun game-performance
  suffix: -targetFrameRate 120
```

All three fields are optional — you can omit any that you don't need for a given game.

---

## License

This is free and unencumbered software released into the public domain under [The Unlicense](LICENSE). Do whatever you want with it.
