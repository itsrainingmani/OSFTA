# One Skill to Find Them All

An OpenCode Skill that lets you discover OpenCode plugins and skills by searching curated sources and returns categorized recommendations with install steps.

## Install

Local installation (current project only):

```bash
curl -fsSL https://raw.githubusercontent.com/itsrainingmani/OSFTA/main/install.sh | bash
```

Global installation (available in all projects):

```bash
curl -fsSL https://raw.githubusercontent.com/itsrainingmani/OSFTA/main/install.sh | bash -s -- --global
```

## Usage

Once installed, the skill appears in OpenCode's `<available_skills>` list. The agent loads it automatically when searching for plugins.

Use the `/discover-plugins` command to search for plugins:

```shell
/discover-plugins notifications
/discover-plugins memory persistence
/discover-plugins github integration
```

### Updating

To update to the latest version:

```shell
/discover-plugins --update-skill
```

## Structure

The installer adds both a skill and a command:

```shell
# Skill (search logic + sources)
skill/discover-plugins/
└── SKILL.md              # Main manifest + workflow

# Command (slash command)
command/discover-plugins.md    # /discover-plugins entrypoint
```

## Sources

The skill queries these curated sources in parallel:

| Source | Format | Description |
|--------|--------|-------------|
| [opencode.cafe](https://raw.githubusercontent.com/R44VC0RP/opencode.cafe/main/bulk/plugins.json) | JSON | Best structured data with install guidance |
| [awesome-opencode](https://raw.githubusercontent.com/awesome-opencode/awesome-opencode/main/README.md) | Markdown | Community-curated list |
| [OpenCode ecosystem](https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/web/src/content/docs/ecosystem.mdx) | MDX | Official ecosystem docs |

## Categories

Results are grouped into these categories:

| Category | Keywords |
|----------|----------|
| **auth** | oauth, authentication, login, credentials, api key |
| **memory** | memory, persistence, context, vector, recall |
| **workflow** | workflow, orchestration, background agents, sessions |
| **notifications** | notify, notification, alert, bell, sound |
| **code-tools** | lsp, ast, shell, fast apply, formatter |
| **integrations** | github, linear, slack, web, devcontainers |
| **skills** | skills, skill packs, skill loader, prompt library |
| **ui** | ui, theme, dashboard, web, interface |

## Output Format

```markdown
## Extensions for "<user need>"

### <Category>

**<Name>**
<One-line description>
```json
{
  "plugin": ["<package>"]
}

[Repo](url)

---

Searched: <sources> • Indexed: <count>
```

## License

[MIT](LICENSE)
