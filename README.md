# Agent Skills

A collection of portable skills for AI coding agents.

## What are Agent Skills?

Skills are reusable extensions that give AI coding agents specialized capabilities. They work across multiple agents that support the emerging skills ecosystem:

| Agent | Skills Directory |
|-------|------------------|
| Claude Code | `.claude/skills/` |
| GitHub Copilot | `.github/skills/` |
| Cursor | `.cursor/skills/` |
| OpenCode | `.opencode/skills/` |
| Generic | `.agent/skills/` |

## Available Skills

| Skill | Description |
|-------|-------------|
| [github-gist](skills/github-gist/) | Create GitHub gists from files or snippets |

## Installation

Copy a skill to your project or global skills directory:

```bash
# Example: Install github-gist for Claude Code
cp -r skills/github-gist ~/.claude/skills/
```

## Creating Skills

Each skill follows a standard structure:

```
skills/<skill-name>/
├── SKILL.md      # Documentation with frontmatter metadata
└── <scripts>     # Implementation files
```

The `SKILL.md` frontmatter includes:
- `name`: Skill identifier
- `description`: What the skill does (used by agents for tool selection)
- `license`: License type
- `metadata`: Author, version, tags, compatibility info

## License

MIT
