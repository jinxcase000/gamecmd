#!/bin/bash
# gamecmd installer

set -e

echo "==> Installing gamecmd..."

# --- Install yq if missing ---
if ! command -v yq &> /dev/null; then
    echo "==> yq not found, installing..."

    # Detect package manager and install
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm yq
    elif command -v apt &> /dev/null; then
        sudo apt install -y yq
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y yq
    elif command -v zypper &> /dev/null; then
        sudo zypper install -y yq
    else
        echo "ERROR: Could not detect package manager. Please install yq manually:"
        echo "  https://github.com/mikefarah/yq"
        exit 1
    fi
else
    echo "==> yq already installed, skipping."
fi

# --- Create config directory ---
mkdir -p "$HOME/.config/gamecmd"

# --- Copy games.yaml only if one doesn't already exist ---
if [ ! -f "$HOME/.config/gamecmd/games.yaml" ]; then
    cp games.yaml "$HOME/.config/gamecmd/games.yaml"
    echo "==> Copied games.yaml to $HOME/.config/gamecmd/"
else
    echo "==> games.yaml already exists at $HOME/.config/gamecmd/, skipping to avoid overwrite."
fi

# --- Install gamecmd script ---
mkdir -p "$HOME/.local/bin"
cp gamecmd "$HOME/.local/bin/gamecmd"
chmod +x "$HOME/.local/bin/gamecmd"
echo "==> Installed gamecmd to $HOME/.local/bin/"

# --- Check if ~/.local/bin is in PATH ---
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "WARNING: $HOME/.local/bin is not in your PATH."
    echo "Add the following to your shell config (~/.config/fish/config.fish for fish):"
    echo ""
    echo "  fish_add_path \$HOME/.local/bin"
    echo ""
fi

echo ""
echo "==> Done! Usage in Steam launch options:"
echo "    gamecmd <profile> %command%"
echo ""
echo "Edit your profiles at: $HOME/.config/gamecmd/games.yaml"
