#!/usr/bin/env bash
# setup-ngrok.sh — Start ngrok for Make.com integration
# Usage: bash .make/setup-ngrok.sh

set -e

echo "=== Make.com ngrok Setup ==="
echo ""

# Check if ngrok is installed
if ! command -v ngrok &> /dev/null; then
    echo "❌ ngrok not found"
    echo ""
    echo "Install ngrok:"
    echo "  brew install ngrok    # macOS"
    echo "  or visit: https://ngrok.com/download"
    echo ""
    echo "Then set up your authtoken:"
    echo "  ngrok config add-authtoken YOUR_TOKEN"
    exit 1
fi

echo "✅ ngrok found"

# Check if router is running
if ! curl -s http://localhost:8888/health > /dev/null 2>&1; then
    echo "⚠️  covibe-router not running on port 8888"
    echo "   Start it first: bash start-covibe.sh"
    exit 1
fi

echo "✅ covibe-router is running"
echo ""
echo "Starting ngrok tunnel..."
echo "(Press Ctrl+C to stop)"
echo ""
echo "Copy the https:// URL below and set it as COVIBE_ROUTER_URL in Make.com"
echo ""
ngrok http 8888
