#!/usr/bin/env bash
set -euo pipefail

# Keep only the 18 example notebooks requested.
# This removes all other files in the repository root that are not on the keep list.
# Run from the repository root:
#   bash cleanup_examples_18.sh

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$repo_root"

keep=(
  "Example 4.1.ipynb"
  "Example 4.1-revised.ipynb"
  "Example 4.1L1-revised.ipynb"
  "Example 4.1L12-revised.ipynb"
  "Example 4.1IP2.ipynb"
  "Example 4.1IP2L1.ipynb"
  "Example 4.1IP2L12.ipynb"

  "Example 4.2.ipynb"
  "Example 4.2-2.ipynb"
  "Example 4.2L1.ipynb"
  "Example 4.2L12.ipynb"

  "Example 4.3.ipynb"
  "Example 4.3IP2.ipynb"
  "Example 4.3L1.ipynb"
  "Example 4.3L12.ipynb"

  "Example 4.4.ipynb"
  "Example 4.4L1.ipynb"
  "Example 4.4L12.ipynb"
)

declare -A keep_map=()
for f in "${keep[@]}"; do
  keep_map["$f"]=1
done

for f in *; do
  [[ -e "$f" ]] || continue
  if [[ -d "$f" ]]; then
    continue
  fi
  if [[ -z "${keep_map[$f]:-}" ]]; then
    rm -f -- "$f"
    echo "Deleted: $f"
  fi
done

echo "Remaining files:"
ls -1 | sort
