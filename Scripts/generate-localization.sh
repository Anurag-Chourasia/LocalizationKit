#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="${SCRIPT_DIR}/generate-localization.py"

if ! command -v python3 &>/dev/null; then
    echo "Error: python3 is required to run localization generator." >&2
    exit 1
fi

python3 "${PYTHON_SCRIPT}" "$@"
