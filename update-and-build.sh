#!/usr/bin/env bash
set -e

log() {
  echo "[`date '+%Y-%m-%d %H:%M:%S'`] [ORCHESTRATOR] $1"
}

# ==============================
# Run update
# ==============================
UPDATE_RESULT=$(./update-docs.sh | tail -n 1)

if [[ "$UPDATE_RESULT" == "UPDATED=true" ]]; then
  log "Repository updated. Triggering build..."
  ./build-docs.sh
else
  log "No update. Build skipped."
fi
