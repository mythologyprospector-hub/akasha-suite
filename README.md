# Akasha CLI Suite

A Termux-friendly command suite for operating the Akasha repo ecosystem.

## Tools

- `akasha-console` — overview dashboard
- `akasha-doctor` — repo and git health checks
- `akasha-run` — runs the discovery loop
- `akasha-log` — shows latest outputs and logs
- `akasha-clean` — cleans generated artifacts safely
- `akasha-sync` — add / commit / push all configured repos
- `akasha-remotes` — fix Akasha remotes to the correct GitHub namespace

## Install

```bash
chmod +x install.sh
./install.sh
source ~/.bashrc
```

## Notes

- Assumes repos are cloned directly into `~/`
- Assumes `akasha-discovery/run_discovery.py` exists
- Assumes Akasha SSH host alias is `github-akasha`

---

This repository participates in the Akasha ecosystem and is described by repo-manifest.yaml.
