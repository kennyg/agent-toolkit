# Zensical Configuration Reference

Zensical uses TOML for configuration (`zensical.toml`), chosen over YAML for clarity and reduced indentation errors.

## Minimal zensical.toml

```toml
[project]
site_name = "My Docs"
```

## Full Configuration

```toml
[project]
site_name = "Project Name"
site_url = "https://example.com/"
site_description = "Project documentation"
site_author = "Author Name"
copyright = "Copyright © 2025 Author Name"

repo_url = "https://github.com/user/repo"
repo_name = "GitHub"
edit_uri = "edit/main/docs"

docs_dir = "docs"
site_dir = "site"
use_directory_urls = true
dev_addr = "localhost:8000"

[project.theme]
variant = "modern"
custom_dir = "docs/overrides"
language = "en"
logo = "logo.svg"
favicon = "favicon.ico"

[project.theme.palette]
scheme = "default"
primary = "indigo"
accent = "indigo"

[project.theme.palette.toggle]
icon = "material/brightness-7"
name = "Switch to dark mode"

[project.theme.font]
text = "Roboto"
code = "Roboto Mono"

[project.theme.features]
features = [
    "navigation.instant",
    "navigation.tracking",
    "navigation.tabs",
    "navigation.sections",
    "navigation.top",
    "search.suggest",
    "search.highlight",
    "content.code.copy",
    "content.code.annotate",
    "content.tabs.link",
]

[project.extra]
social = [
    { icon = "fontawesome/brands/github", link = "https://github.com/user" },
    { icon = "fontawesome/brands/twitter", link = "https://twitter.com/user" },
]

[project.extra_css]
extra_css = ["stylesheets/extra.css"]

[project.extra_javascript]
extra_javascript = ["javascripts/extra.js"]

[project.markdown_extensions]
extensions = [
    "admonition",
    "pymdownx.details",
    "pymdownx.superfences",
    "pymdownx.tabbed",
    "pymdownx.highlight",
    "pymdownx.inlinehilite",
    "pymdownx.emoji",
    "attr_list",
    "md_in_html",
    "def_list",
    "tables",
    "footnotes",
    "toc",
]

[project.plugins]
plugins = ["search"]
```

## Configuration Settings

| Setting | Purpose | Default |
|---------|---------|---------|
| `site_name` | Site title in header and HTML head | Required |
| `site_url` | Canonical URL (omit for offline builds) | - |
| `site_description` | Meta description fallback | - |
| `site_author` | Author meta tag | - |
| `copyright` | Footer copyright (supports HTML) | - |
| `docs_dir` | Source markdown directory | `docs` |
| `site_dir` | Build output directory | `site` |
| `use_directory_urls` | Clean URLs without .html | `true` |
| `dev_addr` | Dev server address | `localhost:8000` |

## Navigation

Navigation is auto-generated from the `docs/` folder structure. Files are ordered alphabetically; use numeric prefixes (e.g., `01-intro.md`) to control order.

## Theme Variants

- `modern` - Default, optimized for readability
- `classic` - Traditional style

## Theme Features

| Feature | Description |
|---------|-------------|
| `navigation.instant` | Single-page app behavior |
| `navigation.tracking` | URL updates with scroll position |
| `navigation.tabs` | Top-level nav as tabs |
| `navigation.sections` | Render sections as groups |
| `navigation.expand` | Expand all nav sections |
| `navigation.top` | Back-to-top button |
| `search.suggest` | Search suggestions |
| `search.highlight` | Highlight search terms on page |
| `content.code.copy` | Copy button on code blocks |
| `content.code.annotate` | Enable code annotations |
| `content.tabs.link` | Sync content tabs across page |

## Color Schemes

**Schemes:** `default` (light), `slate` (dark)

**Primary colors:** `red`, `pink`, `purple`, `deep-purple`, `indigo`, `blue`, `light-blue`, `cyan`, `teal`, `green`, `light-green`, `lime`, `yellow`, `amber`, `orange`, `deep-orange`, `brown`, `grey`, `blue-grey`, `black`, `white`

## Markdown Extensions

Extensions are configured under `[project.markdown_extensions]`:

```toml
[project.markdown_extensions]
extensions = [
    "admonition",
    "pymdownx.details",
    "pymdownx.superfences",
    "pymdownx.tabbed",
    "pymdownx.highlight",
    "pymdownx.inlinehilite",
    "pymdownx.emoji",
    "pymdownx.caret",
    "pymdownx.keys",
    "pymdownx.mark",
    "pymdownx.tilde",
    "attr_list",
    "md_in_html",
    "def_list",
    "tables",
    "footnotes",
    "toc",
]
```

| Extension | Enables |
|-----------|---------|
| `admonition` | Note/warning/tip boxes |
| `pymdownx.details` | Collapsible sections |
| `pymdownx.superfences` | Fenced code blocks, mermaid |
| `pymdownx.tabbed` | Content tabs |
| `pymdownx.highlight` | Code syntax highlighting |
| `pymdownx.inlinehilite` | Inline code highlighting |
| `pymdownx.emoji` | Icons and emoji |
| `pymdownx.caret` | Superscript (`^^text^^`) |
| `pymdownx.keys` | Keyboard keys (`++ctrl+c++`) |
| `pymdownx.mark` | Highlighted text (`==text==`) |
| `pymdownx.tilde` | Subscript, strikethrough |
| `attr_list` | Add attributes to elements |
| `md_in_html` | Markdown inside HTML |
| `def_list` | Definition lists |
| `tables` | Tables |
| `footnotes` | Footnotes |
| `toc` | Table of contents |
