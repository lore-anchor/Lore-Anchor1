#!/usr/bin/env bash
# setup-github-secrets.sh — Interactive GitHub secrets setup
# Usage: bash scripts/setup-github-secrets.sh

set -e

REPO="haruki121731-del/Lore-Anchor1"

echo "=== GitHub Secrets Setup for Lore-Anchor ==="
echo ""
echo "Repository: $REPO"
echo ""

# Check gh CLI
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI not found"
    echo "   Install: https://cli.github.com/"
    exit 1
fi

# Check auth
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub CLI"
    echo "   Run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI authenticated"
echo ""

# Required secrets
SECRETS=(
    "ANTHROPIC_API_KEY:Claude API (https://console.anthropic.com/)"
    "OPENAI_API_KEY:OpenAI API (https://platform.openai.com/)"
    "GROQ_API_KEY:Groq API (https://console.groq.com/)"
    "FIGMA_TOKEN:Figma API (Settings → Personal access tokens)"
)

echo "Setting up secrets..."
echo "(Press Ctrl+C to skip any secret)"
echo ""

for secret_info in "${SECRETS[@]}"; do
    IFS=':' read -r secret_name secret_desc <<< "$secret_info"
    
    # Check if already set
    if gh secret list --repo "$REPO" | grep -q "^$secret_name\s"; then
        echo "✅ $secret_name already set"
        continue
    fi
    
    echo ""
    echo "--- $secret_name ---"
    echo "Source: $secret_desc"
    read -rsp "Paste value (or Enter to skip): " secret_value
    echo ""
    
    if [ -n "$secret_value" ]; then
        echo "$secret_value" | gh secret set "$secret_name" --repo "$REPO"
        echo "✅ $secret_name set"
    else
        echo "⏭️  Skipped"
    fi
done

echo ""
echo "=== Setup Complete ==="
echo ""
gh secret list --repo "$REPO"
