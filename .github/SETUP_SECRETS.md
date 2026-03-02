# GitHub Secrets Setup Guide

Required secrets for Lore-Anchor automation.

## Required Secrets

### AI/LLM APIs

| Secret | Purpose | Get From |
|--------|---------|----------|
| `ANTHROPIC_API_KEY` | Claude Sonnet/Haiku for complex tasks | https://console.anthropic.com/ |
| `OPENAI_API_KEY` | GPT-4o-mini for task classification | https://platform.openai.com/ |
| `GROQ_API_KEY` | Fast inference for medium tasks | https://console.groq.com/ |

### Figma Integration

| Secret | Purpose | Get From |
|--------|---------|----------|
| `FIGMA_TOKEN` | Fetch designs from Figma API | Figma → Settings → Personal access tokens |

### Database/Storage

| Secret | Purpose |
|--------|---------|
| `SUPABASE_URL` | PostgreSQL database URL |
| `SUPABASE_SERVICE_ROLE_KEY` | Admin access to Supabase |

### Cloud Deployment

| Secret | Purpose |
|--------|---------|
| `SALADCLOUD_API_KEY` | Deploy GPU workers |
| `RAILWAY_TOKEN` | Deploy API/web services |

## Setup Commands

### Using GitHub CLI (recommended)

```bash
# Set secrets one by one
gh secret set ANTHROPIC_API_KEY --repo haruki121731-del/Lore-Anchor1
# Paste your key when prompted

gh secret set OPENAI_API_KEY --repo haruki121731-del/Lore-Anchor1
gh secret set GROQ_API_KEY --repo haruki121731-del/Lore-Anchor1
gh secret set FIGMA_TOKEN --repo haruki121731-del/Lore-Anchor1

# Or set from environment variables
export ANTHROPIC_API_KEY="sk-ant-..."
gh secret set ANTHROPIC_API_KEY --repo haruki121731-del/Lore-Anchor1 --body "$ANTHROPIC_API_KEY"
```

### Using Web UI

1. Go to: https://github.com/haruki121731-del/Lore-Anchor1/settings/secrets/actions
2. Click "New repository secret"
3. Add each secret manually

## Verify Setup

```bash
# List all secrets (names only)
gh secret list --repo haruki121731-del/Lore-Anchor1
```

## Local Development

Create `.env` file in project root:

```bash
ANTHROPIC_API_KEY=sk-ant-...
OPENAI_API_KEY=sk-...
GROQ_API_KEY=gsk_...
FIGMA_TOKEN=figd_...
OLLAMA_URL=http://localhost:11434
```
