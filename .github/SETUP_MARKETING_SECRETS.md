# Marketing Secrets Setup Guide

For the marketing automation repo: `haruki121731-del/marketing`

## Required Secrets

### Twitter/X API

| Secret | Purpose | Get From |
|--------|---------|----------|
| `TWITTER_API_KEY` | API Key v2 | https://developer.twitter.com/ |
| `TWITTER_API_SECRET` | API Secret v2 | " |
| `TWITTER_ACCESS_TOKEN` | Access Token | " |
| `TWITTER_ACCESS_TOKEN_SECRET` | Access Secret | " |
| `TWITTER_BEARER_TOKEN` | Bearer Token | " |

### Supabase (for content database)

| Secret | Purpose |
|--------|---------|
| `SUPABASE_URL` | Database URL |
| `SUPABASE_KEY` | Service role key |

### Note.com (optional)

| Secret | Purpose |
|--------|---------|
| `NOTE_EMAIL` | Login email |
| `NOTE_PASSWORD` | Login password |

## Setup Commands

```bash
# Navigate to marketing repo
cd ../marketing

# Set secrets
gh secret set TWITTER_API_KEY --repo haruki121731-del/marketing
gh secret set TWITTER_API_SECRET --repo haruki121731-del/marketing
gh secret set TWITTER_ACCESS_TOKEN --repo haruki121731-del/marketing
gh secret set TWITTER_ACCESS_TOKEN_SECRET --repo haruki121731-del/marketing
gh secret set TWITTER_BEARER_TOKEN --repo haruki121731-del/marketing
gh secret set SUPABASE_URL --repo haruki121731-del/marketing
gh secret set SUPABASE_KEY --repo haruki121731-del/marketing
```

## Verification

```bash
gh secret list --repo haruki121731-del/marketing
```
