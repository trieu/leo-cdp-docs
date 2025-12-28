#!/usr/bin/env bash
set -e

# ==============================
# Configuration
# ==============================
VENV_DIR=".venv"
PYTHON_BIN="python3"

REQUIRED_PACKAGES=(
  mkdocs
  mkdocs-material
  mkdocs-to-pdf
  pymdown-extensions
)

log() {
  echo "[`date '+%Y-%m-%d %H:%M:%S'`] [BUILD] $1"
}

# ==============================
# Setup virtualenv
# ==============================
if [ ! -d "$VENV_DIR" ]; then
  log "Creating virtual environment..."
  $PYTHON_BIN -m venv $VENV_DIR
fi

source $VENV_DIR/bin/activate

# ==============================
# Install dependencies
# ==============================
log "Installing / upgrading MkDocs dependencies..."
pip install --upgrade pip >/dev/null

for pkg in "${REQUIRED_PACKAGES[@]}"; do
  pip install --upgrade "$pkg" >/dev/null
done

# ==============================
# Build MkDocs
# ==============================
log "Running mkdocs build..."
mkdocs build

log "MkDocs build completed successfully."
