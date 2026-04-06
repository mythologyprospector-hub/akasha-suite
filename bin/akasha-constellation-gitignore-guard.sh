#!/usr/bin/env bash

echo "=================================="
echo " AKASHA CONSTELLATION SAFETY PASS "
echo "=================================="

cd ~ || exit

for repo in akasha-*; do
    if [ -d "$repo/.git" ]; then

        echo ""
        echo "Protecting: $repo"

        GI="$repo/.gitignore"

        if [ ! -f "$GI" ]; then
            touch "$GI"
        fi

        if grep -q "AKASHA_CANON_GUARD" "$GI"; then
            echo "  Guard already present"
        else

cat <<'BLOCK' >> "$GI"

# ==================================
# AKASHA_CANON_GUARD
# Protect canonical files
# ==================================
!/README.md
!/repo-manifest.yaml

# ==================================
# AKASHA_NOISE_FILTER
# Generated artifacts
# ==================================
ARCHETYPE_COVERAGE_MAP.md
*.log
*.tmp
*.cache
.DS_Store

# Discovery engine artifacts
tree.txt
output.txt
*_run_output.txt

BLOCK

            echo "  Guard installed"

        fi

    fi
done

echo ""
echo "Safety pass complete."
