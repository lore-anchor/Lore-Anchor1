#!/usr/bin/env bash
# setup-persistence.sh — Setup Ollama + covibe-router auto-start on macOS
# Usage: bash setup-persistence.sh

set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

echo "=== Lore-Anchor Persistence Setup ==="
echo ""

# Create LaunchAgents directory if needed
mkdir -p "$LAUNCH_AGENTS_DIR"

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "❌ Ollama not found in PATH"
    echo "   Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

OLLAMA_PATH=$(command -v ollama)
echo "✅ Ollama found: $OLLAMA_PATH"

# Check if qwen2.5-coder:7b is pulled
if ! ollama list | grep -q "qwen2.5-coder:7b"; then
    echo "📦 Pulling qwen2.5-coder:7b model..."
    ollama pull qwen2.5-coder:7b
else
    echo "✅ Model qwen2.5-coder:7b already available"
fi

# Install Ollama LaunchAgent
echo ""
echo "Installing Ollama LaunchAgent..."
sed "s|/usr/local/bin/ollama|$OLLAMA_PATH|g" "$REPO_DIR/com.loreanchor.ollama.plist" > "$LAUNCH_AGENTS_DIR/com.loreanchor.ollama.plist"
launchctl unload "$LAUNCH_AGENTS_DIR/com.loreanchor.ollama.plist" 2>/dev/null || true
launchctl load -w "$LAUNCH_AGENTS_DIR/com.loreanchor.ollama.plist"
echo "✅ Ollama LaunchAgent installed and started"

# Install covibe-router LaunchAgent
echo ""
echo "Installing covibe-router LaunchAgent..."
sed "s|REPO_DIR|$REPO_DIR|g" "$REPO_DIR/com.loreanchor.covibe.plist" > "$LAUNCH_AGENTS_DIR/com.loreanchor.covibe.plist"
launchctl unload "$LAUNCH_AGENTS_DIR/com.loreanchor.covibe.plist" 2>/dev/null || true
launchctl load -w "$LAUNCH_AGENTS_DIR/com.loreanchor.covibe.plist"
echo "✅ covibe-router LaunchAgent installed and started"

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Services will auto-start on login."
echo ""
echo "Commands:"
echo "  launchctl list | grep loreanchor    # Check status"
echo "  tail -f /tmp/ollama_launchd.log     # View Ollama logs"
echo "  tail -f /tmp/covibe_launchd.log     # View router logs"
echo ""
echo "Status check:"
sleep 2
curl -s http://localhost:8888/health | python3 -m json.tool 2>/dev/null || echo "Router not ready yet, check logs"
