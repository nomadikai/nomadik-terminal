#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[*] Updating Termux packages..."
pkg update -y && pkg upgrade -y

echo "[*] Installing dependencies..."
pkg install -y git python rust clang fftw openssl libffi make zlib nano curl

# Install Poetry if missing
if ! command -v poetry >/dev/null 2>&1; then
  echo "[*] Installing Poetry..."
  curl -sSL https://install.python-poetry.org | python3 -
fi

# Add Poetry to PATH permanently if not already in .bashrc
if ! grep -q '.local/bin' ~/.bashrc; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi
export PATH="$HOME/.local/bin:$PATH"

PROJECT_DIR="$HOME/nomadik_terminal"
mkdir -p "$PROJECT_DIR"

echo "[*] Writing pyproject.toml..."
cat > "$PROJECT_DIR/pyproject.toml" << 'EOF'
[tool.poetry]
name = "nomadik_terminal"
version = "0.1.0"
description = "NOMADIK TERMINAL is a mobile-first, crypto trading toolkit built for survivalists, digital nomads, and tactical traders. Designed to run inside Termux on Android, it deploys algorithmic strategies like RSI and EMA crossover through the open-source Freqtrade engine. With multi-exchange support (BinanceUS, KuCoin), Telegram alerts, and a fuzzily-navigable command-line interface, this tool transforms your phone into a field-ready trading terminal. It installs with one command, runs in a clean virtual environment, and includes branded shortcuts, log rotation, and strategy templates you can evolve or swap on the fly."
authors = ["Kalen Vandenbos <kalen.vandenbos@gmail.com>"]

[tool.poetry.dependencies]
python = "^3.10"
freqtrade = "*"
orjson = "*"
pandas-ta = "*"
python-telegram-bot = "*"

[tool.poetry.scripts]
toolkit = "nomadik_terminal.cli:main"

[build-system]
requires = ["poetry-core>=1.0.0"]
build-backend = "poetry.core.masonry.api"
EOF

echo "[*] Writing minimal cli.py..."
mkdir -p "$PROJECT_DIR/nomadik_terminal"
cat > "$PROJECT_DIR/nomadik_terminal/cli.py" << 'EOF'
def main():
    print("Welcome to NOMADIK TERMINAL CLI!")
EOF

cd "$PROJECT_DIR"
echo "[*] Installing Python dependencies with Poetry..."
poetry install

echo "[✅] Setup complete!"
echo "Run your CLI with these commands:"
echo "  cd ~/nomadik_terminal"
echo "  poetry run toolkit"
echo
echo "Remember to run: source ~/.bashrc  (or restart Termux) to have Poetry in your PATH."
