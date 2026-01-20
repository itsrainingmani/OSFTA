---
description: Discover OpenCode plugins and skills from curated sources
---

Load the discover-plugins skill and search for plugins, extensions, or skills that match your needs.

## Workflow

### Step 1: Check for --update-skill flag

If $ARGUMENTS contains `--update-skill`:

1. Determine install location by checking which exists:
   - Local: `.opencode/skill/discover-plugins/`
   - Global: `~/.config/opencode/skill/discover-plugins/`

2. Run the appropriate install command:
   ```bash
   # For local installation
   curl -fsSL https://raw.githubusercontent.com/msmps/discover-plugins-skill/main/install.sh | bash

   # For global installation
   curl -fsSL https://raw.githubusercontent.com/msmps/discover-plugins-skill/main/install.sh | bash -s -- --global
   ```

3. Output success message and stop (do not continue to other steps).

### Step 2: Load discover-plugins skill

```
skill({ name: 'discover-plugins' })
```

### Step 3: Clarify user's goal

If $ARGUMENTS is empty or vague, ask the user what kind of functionality they need:
- Authentication / API keys
- Memory / persistence
- Workflow / orchestration
- Notifications / alerts
- Code tools (LSP, AST, formatting)
- Integrations (GitHub, Slack, etc.)
- Skills / prompt libraries
- UI / themes

### Step 4: Fetch plugin sources

Fetch all sources in parallel using WebFetch:

1. **opencode.cafe** (JSON): `https://raw.githubusercontent.com/R44VC0RP/opencode.cafe/main/bulk/plugins.json`
2. **awesome-opencode** (Markdown): `https://raw.githubusercontent.com/awesome-opencode/awesome-opencode/main/README.md`
3. **OpenCode ecosystem** (MDX): `https://raw.githubusercontent.com/anomalyco/opencode/dev/packages/web/src/content/docs/ecosystem.mdx`

### Step 5: Process and match

1. Normalize entries into a unified catalog
2. Deduplicate by repo URL or package ID
3. Semantically match entries to user's request
4. Group results by category

### Step 6: Return recommendations

Output using this format:

```markdown
## Extensions for "<user need>"

### <Category>

**<Name>**
<One-line description>
<Install instructions>
[Repo](url)

---

Searched: <sources> • Indexed: <count>
```

<user-request>
$ARGUMENTS
</user-request>
