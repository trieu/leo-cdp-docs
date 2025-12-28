#!/usr/bin/env bash
set -e

# ==============================
# Configuration
# ==============================
BRANCH="main"

log() {
  echo "[`date '+%Y-%m-%d %H:%M:%S'`] [UPDATE] $1"
}

# ==============================
# Ensure git repo
# ==============================
if [ ! -d ".git" ]; then
  log "ERROR: Not a git repository"
  exit 1
fi

# ==============================
# Fetch & compare
# ==============================
git fetch origin $BRANCH >/dev/null 2>&1

LOCAL_HASH=$(git rev-parse $BRANCH)
REMOTE_HASH=$(git rev-parse origin/$BRANCH)

if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
  log "Changes detected. Pulling from origin/$BRANCH..."
  git pull origin $BRANCH
  echo "UPDATED=true"
else
  log "No changes detected."
  echo "UPDATED=false"
fi
