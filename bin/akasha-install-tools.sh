#!/usr/bin/env bash

BIN="$HOME/akasha-suite/bin"
mkdir -p "$BIN"

########################################
# akasha-status
########################################
cat <<'PY' > "$BIN/akasha-status"
#!/usr/bin/env python3
from pathlib import Path

HOME = Path.home()
REQ = HOME / "akasha-requests" / "requests"

stages = ["open","exploring","approved","forged","archived"]

print("\nAKASHA REQUEST STATUS\n")

for stage in stages:
    path = REQ / stage
    count = len(list(path.glob("REQ-*.json"))) if path.exists() else 0
    print(f"{stage:10} {count}")

print("")
PY

########################################
# akasha-brainstorm
########################################
cat <<'PY' > "$BIN/akasha-brainstorm"
#!/usr/bin/env python3
import sys, subprocess
from pathlib import Path

HOME = Path.home()
ENGINE = HOME / "akasha-idea-mutation" / "src" / "mutation_engine.py"

if len(sys.argv) < 2:
    print('Usage: akasha-brainstorm "idea"')
    sys.exit(1)

idea = " ".join(sys.argv[1:])

code = f"""
import json, importlib.util
spec = importlib.util.spec_from_file_location("mutation_engine", r"{ENGINE}")
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)
print(json.dumps(mod.mutate_idea("Brainstorm Seed", {idea!r}), indent=2))
"""

subprocess.run(["python","-c",code])
PY

########################################
# akasha-populate
########################################
cat <<'PY' > "$BIN/akasha-populate"
#!/usr/bin/env python3
import sys
from pathlib import Path

HOME = Path.home()

if len(sys.argv) < 2:
    print("Usage: akasha-populate <repo>")
    sys.exit(1)

repo = sys.argv[1]
path = HOME / repo

if not path.exists():
    print("Repo not found:", path)
    sys.exit(1)

(path/"src").mkdir(exist_ok=True)
(path/"docs").mkdir(exist_ok=True)
(path/"tests").mkdir(exist_ok=True)

title = repo.replace("akasha-","").replace("-"," ").title()

(path/"README.md").write_text(f"# {title}\n\nAkasha organ.\n")
(path/"repo-manifest.yaml").write_text(
f"repo: {repo}\ntype: organ\nfamily: unspecified\nrole: {repo.replace('akasha-','')}\n"
)

(path/"docs"/"design.md").write_text("# Design\n\nDescribe system.\n")

(path/"src"/"main.py").write_text(
'def main():\n'
'    print("organ initialized")\n\n'
'if __name__ == "__main__":\n'
'    main()\n'
)

(path/"tests"/"test_smoke.py").write_text("def test_smoke(): assert True\n")

print("Populated:", path)
PY

########################################
# akasha-map
########################################
cat <<'PY' > "$BIN/akasha-map"
#!/usr/bin/env python3
from pathlib import Path

HOME = Path.home()

repos = sorted(
    p for p in HOME.iterdir()
    if p.is_dir() and p.name.startswith("akasha-")
)

print("\nAKASHA CONSTELLATION MAP\n")

for r in repos:
    print("-", r.name)

print("\nTotal Akasha repos:", len(repos),"\n")
PY

chmod +x "$BIN"/akasha-*
echo "Akasha tools installed."
