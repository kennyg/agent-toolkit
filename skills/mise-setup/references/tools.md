# mise Tools Reference

Common tools available via mise. Run `mise registry` for the full list.

## Languages

| Tool | mise name | Notes |
|------|-----------|-------|
| Python | `python` | Use with `uv` for fast packages |
| Node.js | `node` | LTS versions recommended |
| Go | `go` | |
| Rust | `rust` | `stable`, `nightly`, or version |
| Ruby | `ruby` | |
| Java | `java` | OpenJDK by default |
| Deno | `deno` | |
| Bun | `bun` | Fast JS runtime + package manager |

## Python Ecosystem

| Tool | Description |
|------|-------------|
| `uv` | Fast package manager (replaces pip, pip-tools, virtualenv) |
| `ruff` | Fast linter + formatter (replaces black, isort, flake8) |
| `mypy` | Static type checker |
| `poetry` | Dependency management |
| `pdm` | PEP-compliant package manager |

## Node.js Ecosystem

| Tool | Description |
|------|-------------|
| `pnpm` | Fast, disk-efficient package manager |
| `bun` | Fast runtime + package manager |
| `yarn` | Classic package manager |
| `biome` | Fast linter + formatter |

## Go Ecosystem

| Tool | Description |
|------|-------------|
| `golangci-lint` | Meta-linter (runs many linters) |
| `gopls` | Language server |
| `goreleaser` | Release automation |

## Rust Ecosystem

| Tool | Description |
|------|-------------|
| `rust` | Toolchain (includes cargo, rustc, rustfmt) |
| `cargo-binstall` | Binary package installer |

## Shell & Config

| Tool | Description |
|------|-------------|
| `shellcheck` | Shell script linter |
| `shfmt` | Shell script formatter |
| `taplo` | TOML linter/formatter |
| `yamlfmt` | YAML formatter |

## Universal

| Tool | Description |
|------|-------------|
| `typos` | Source code spell checker |
| `delta` | Better git diffs |
| `fd` | Fast file finder |
| `ripgrep` | Fast grep |
| `jq` | JSON processor |
| `yq` | YAML processor |
| `gh` | GitHub CLI |
| `hk` | Git hook manager |

## DevOps

| Tool | Description |
|------|-------------|
| `terraform` | Infrastructure as code |
| `kubectl` | Kubernetes CLI |
| `helm` | Kubernetes package manager |
| `docker-compose` | Container orchestration |
| `aws-cli` | AWS CLI |
| `gcloud` | Google Cloud CLI |

## Version Syntax

```toml
[tools]
# Exact version
python = "3.13.1"

# Minor version (latest patch)
python = "3.13"

# Major version (latest minor + patch)
node = "22"

# Latest stable
rust = "latest"

# Rust channels
rust = "stable"
rust = "nightly"
rust = "beta"

# Multiple versions (first is default)
python = ["3.13", "3.12"]
```
