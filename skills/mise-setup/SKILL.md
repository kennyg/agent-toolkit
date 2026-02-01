---
name: mise-setup
description: Set up mise (dev tool version manager) for any project. Detects project type and configures appropriate tools, virtual environments, and tasks. Use when user wants to configure mise, set up dev tools, manage tool versions, or mentions mise.toml.
---

# mise Setup

Configure [mise](https://mise.jdx.dev) (modern tool version manager) for any project.

## Prerequisites

```bash
brew install mise
# Add to shell: eval "$(mise activate zsh)"
```

## Workflow

1. Detect project type (look for pyproject.toml, package.json, go.mod, etc.)
2. Create `mise.toml` with appropriate tools
3. Run `mise trust && mise install`
4. Test with `mise doctor`

## Project Detection

| File | Type | Recommended Tools |
|------|------|-------------------|
| `pyproject.toml` | Python | `python`, `uv`, `ruff` |
| `package.json` | Node | `node`, `bun` or `pnpm` |
| `go.mod` | Go | `go`, `golangci-lint` |
| `Cargo.toml` | Rust | `rust` |
| `*.sh` | Shell | `shellcheck`, `shfmt` |
| Any | Universal | `typos`, `taplo` |

## mise.toml Template

```toml
[tools]
# Add tools based on project type

[env]
# Environment variables and venv config

[tasks]
# Custom tasks (optional)
```

## Project Templates

### Python

```toml
[tools]
python = "3.13"
uv = "latest"
ruff = "latest"

[env]
_.python.venv = { path = ".venv", create = true }
```

The `_.python.venv` setting:
- Auto-creates `.venv` when entering the directory
- Activates the venv (sets `VIRTUAL_ENV`, prepends to `PATH`)
- Works with `uv` for fast package management

### Node.js

```toml
[tools]
node = "22"
bun = "latest"
```

Or with pnpm:

```toml
[tools]
node = "22"
pnpm = "latest"
```

### Go

```toml
[tools]
go = "1.23"
golangci-lint = "latest"
```

### Rust

```toml
[tools]
rust = "stable"
```

### Multi-language

```toml
[tools]
# Languages
python = "3.13"
node = "22"
go = "1.23"

# Python env
uv = "latest"

# Linters (for hk pre-commit hooks)
shellcheck = "latest"
shfmt = "latest"
ruff = "latest"
taplo = "latest"
typos = "latest"

[env]
_.python.venv = { path = ".venv", create = true }
```

## Universal Tools

Add to any project for code quality:

```toml
[tools]
typos = "latest"      # Spell checker
taplo = "latest"      # TOML linter
shellcheck = "latest" # Shell linter
shfmt = "latest"      # Shell formatter
```

## Tasks

Define project-specific commands:

```toml
[tasks]
dev = "npm run dev"
test = "pytest"
lint = "ruff check ."
build = "npm run build"

# Task with dependencies
ci = { depends = ["lint", "test"] }

# Task with description
deploy = { run = "./deploy.sh", description = "Deploy to production" }
```

Run with `mise run <task>` or `mise r <task>`.

## Environment Variables

```toml
[env]
DATABASE_URL = "postgres://localhost/dev"
DEBUG = "true"

# Load from .env file
_.file = ".env"

# Path modifications
_.path = ["./bin", "./scripts"]
```

## Commands

```bash
mise install       # Install all tools
mise trust         # Trust the config file
mise doctor        # Check mise health
mise ls            # List installed tools
mise run <task>    # Run a task
mise use <tool>    # Add tool to config
mise upgrade       # Upgrade all tools
```

## Tips

- **Pin versions** for reproducibility: `python = "3.13.1"` not `"latest"`
- **Use `latest`** for dev tools that don't affect builds: linters, formatters
- **Add `.venv/`** to `.gitignore` when using Python venv
- **Pair with hk-setup** for pre-commit hooks using the same linters

## Resources

- [mise Documentation](https://mise.jdx.dev)
- [Tool Registry](https://mise.jdx.dev/registry.html) - All available tools
- [Configuration Reference](https://mise.jdx.dev/configuration.html)
