#!/usr/bin/env bash
set -euo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

# 1) Remove "-revised" from any remaining notebooks
for f in *.ipynb; do
  [[ -e "$f" ]] || continue
  if [[ "$f" == *"-revised.ipynb" ]]; then
    new="${f//-revised/}"
    mv -- "$f" "$new"
    echo "Renamed: $f -> $new"
  fi
done

# 2) Rename the main examples to final names
for old in "Example 4.1.ipynb" "Example 4.2.ipynb" "Example 4.3.ipynb" "Example 4.4.ipynb"; do
  if [[ -f "$old" ]]; then
    case "$old" in
      "Example 4.1.ipynb")
        new="ExampleFP 4.1L2.ipynb"
        ;;
      "Example 4.2.ipynb")
        new="ExampleIP1 4.2L2.ipynb"
        ;;
      "Example 4.3.ipynb")
        new="ExampleFP 4.3L2.ipynb"
        ;;
      "Example 4.4.ipynb")
        new="ExampleIP1 4.4L2.ipynb"
        ;;
      *)
        continue
        ;;
    esac

    mv -- "$old" "$new"
    echo "Renamed: $old -> $new"
  fi
done

# 3) Rename IP2 main files to L2
for old in "Example 4.1IP2.ipynb" "Example 4.3IP2.ipynb"; do
  if [[ -f "$old" ]]; then
    new="${old/.ipynb/L2.ipynb}"
    mv -- "$old" "$new"
    echo "Renamed: $old -> $new"
  fi
done

# 4) Rename all 4.1 and 4.3 L1/L12 to ExampleFP
for old in "Example 4.1L1.ipynb" "Example 4.1L12.ipynb" "Example 4.3L1.ipynb" "Example 4.3L12.ipynb"; do
  if [[ -f "$old" ]]; then
    new="${old/Example /ExampleFP }"
    mv -- "$old" "$new"
    echo "Renamed: $old -> $new"
  fi
done

# 5) Rename all 4.2 and 4.4 L1/L12 to ExampleIP1
for old in "Example 4.2L1.ipynb" "Example 4.2L12.ipynb" "Example 4.4L1.ipynb" "Example 4.4L12.ipynb"; do
  if [[ -f "$old" ]]; then
    new="${old/Example /ExampleIP1 }"
    mv -- "$old" "$new"
    echo "Renamed: $old -> $new"
  fi
done

# 6) Rename 4.1IP2 L1/L12 and 4.3IP2 L1/L12 to their final names
for old in "Example 4.1IP2L1.ipynb" "Example 4.1IP2L12.ipynb" "Example 4.3IP2L1.ipynb" "Example 4.3IP2L12.ipynb"; do
  if [[ -f "$old" ]]; then
    new="${old/Example /Example }"
    mv -- "$old" "$new"
    echo "Renamed: $old -> $new"
  fi
done

# 7) Keep only the final desired files and delete everything else
keep=(
  "ExampleFP 4.1L2.ipynb"
  "ExampleFP 4.1L1.ipynb"
  "ExampleFP 4.1L12.ipynb"
  "Example 4.1IP2L2.ipynb"
  "Example 4.1IP2L1.ipynb"
  "Example 4.1IP2L12.ipynb"

  "ExampleIP1 4.2L2.ipynb"
  "ExampleIP1 4.2L1.ipynb"
  "ExampleIP1 4.2L12.ipynb"
  "Example 4.2-2.ipynb"

  "ExampleFP 4.3L2.ipynb"
  "ExampleFP 4.3L1.ipynb"
  "ExampleFP 4.3L12.ipynb"
  "Example 4.3IP2L2.ipynb"
  "Example 4.3IP2L1.ipynb"
  "Example 4.3IP2L12.ipynb"

  "ExampleIP1 4.4L2.ipynb"
  "ExampleIP1 4.4L1.ipynb"
  "ExampleIP1 4.4L12.ipynb"
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

echo "Final notebook files:"
ls -1 | sort
