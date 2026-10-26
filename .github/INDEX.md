# .github index

Documentation and instructions for AI agents and contributors.

This file is intentionally named `INDEX.md` instead of `README.md` so it does not compete with the root [`README.md`](../README.md) for GitHub's repository README detection.

## Files

- [`../README.md`](../README.md) - human-facing repository overview.
- [`../AGENTS.md`](../AGENTS.md) - main guide for AI agents working in this repo.
- [`copilot-instructions.md`](copilot-instructions.md) - GitHub Copilot repository-wide instructions.
- [`docs/architecture.md`](docs/architecture.md) - goal, Stow model, package map, wallpaper flow, known quirks.
- [`rules/repository.rules.md`](rules/repository.rules.md) - non-negotiable repository rules.
- [`instructions/`](instructions/) - path-specific instructions for GitHub Copilot and other agents:
  - `stow.instructions.md` - applies to all files
  - `hyprland.instructions.md` - applies to `hyprland/**`
  - `waybar.instructions.md` - applies to `waybar/**`

## Precedence

1. `rules/repository.rules.md`
2. `AGENTS.md`
3. `copilot-instructions.md`
4. path-specific instructions
5. architecture docs (context only)

If instructions conflict, ask the user instead of guessing.

Keep these files short. Update them when the repository structure or workflow changes.
