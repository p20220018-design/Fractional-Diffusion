#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

rename_if_exists() {
  src="$1"
  dst="$2"
  if [[ -f "$src" ]]; then
    if [[ -e "$dst" ]]; then
      rm -f -- "$src"
      echo "Removed duplicate: $src"
    else
      mv -- "$src" "$dst"
      echo "Renamed: $src -> $dst"
    fi
  fi
}

rename_if_exists "Example 4.1.ipynb" "Example 4.1FPL2.ipynb"
rename_if_exists "Example 4.1-revised.ipynb" "Example 4.1FPL2.ipynb"
rename_if_exists "Example 4.1L1-revised.ipynb" "Example 4.1FPL1.ipynb"
rename_if_exists "Example 4.1L12-revised.ipynb" "Example 4.1FPL12.ipynb"
rename_if_exists "Example 4.1IP2.ipynb" "Example 4.1IP2L2.ipynb"

rename_if_exists "Example 4.2.ipynb" "Example 4.2IP1L2.ipynb"
rename_if_exists "Example 4.2-2.ipynb" "Example 4.2IP1L1.ipynb"
rename_if_exists "Example 4.2L1.ipynb" "Example 4.2IP1L1.ipynb"
rename_if_exists "Example 4.2L12.ipynb" "Example 4.2IP1L12.ipynb"

rename_if_exists "Example 4.3.ipynb" "Example 4.3FPL2.ipynb"
rename_if_exists "Example 4.3L1.ipynb" "Example 4.3FPL1.ipynb"
rename_if_exists "Example 4.3L12.ipynb" "Example 4.3FPL12.ipynb"
rename_if_exists "Example 4.3IP2.ipynb" "Example 4.3IP2L2.ipynb"

rename_if_exists "Example 4.4.ipynb" "Example 4.4IP1L2.ipynb"
rename_if_exists "Example 4.4L1.ipynb" "Example 4.4IP1L1.ipynb"
rename_if_exists "Example 4.4L12.ipynb" "Example 4.4IP1L12.ipynb"

keep=(
  "Example 4.1FPL2.ipynb"
  "Example 4.1FPL1.ipynb"
  "Example 4.1FPL12.ipynb"
  "Example 4.1IP2L2.ipynb"
  "Example 4.1IP2L1.ipynb"
  "Example 4.1IP2L12.ipynb"

  "Example 4.2IP1L2.ipynb"
  "Example 4.2IP1L1.ipynb"
  "Example 4.2IP1L12.ipynb"

  "Example 4.3FPL2.ipynb"
  "Example 4.3FPL1.ipynb"
  "Example 4.3FPL12.ipynb"
  "Example 4.3IP2L2.ipynb"
  "Example 4.3IP2L1.ipynb"
  "Example 4.3IP2L12.ipynb"

  "Example 4.4IP1L2.ipynb"
  "Example 4.4IP1L1.ipynb"
  "Example 4.4IP1L12.ipynb"
)

declare -A keep_map=()
for f in "${keep[@]}"; do
  keep_map["$f"]=1
done

for f in *.ipynb; do
  [[ -e "$f" ]] || continue
  if [[ -z "${keep_map[$f]:-}" ]]; then
    rm -f -- "$f"
    echo "Deleted: $f"
  fi
done

echo "Final files:"
ls -1 | sort
