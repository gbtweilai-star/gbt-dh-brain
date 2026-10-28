#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_dh_brain info
PYTHONPATH=src python -m gbt_dh_brain check --payload '{}'
PYTHONPATH=src python -m gbt_dh_brain run   --payload '{}'
