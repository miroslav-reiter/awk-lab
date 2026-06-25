#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

for script in solutions/*.sh; do
  echo
  echo "===== $script ====="
  bash "$script"
done
