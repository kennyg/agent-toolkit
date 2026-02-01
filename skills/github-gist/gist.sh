#!/usr/bin/env bash
# GitHub Gist Creation Script
# Creates gists from files or stdin with configurable options

set -e

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "Error: GitHub CLI (gh) is not installed"
    echo "Install it from: https://cli.github.com/"
    exit 1
fi

# Check if authenticated
if ! gh auth status &> /dev/null; then
    echo "Error: Not authenticated with GitHub"
    echo "Run: gh auth login"
    exit 1
fi

# Initialize variables
PUBLIC_FLAG=""
DESCRIPTION=""
FILENAME=""
NO_BROWSER=""
GH_HOST="${GH_HOST:-}"
FILES=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --public)
            PUBLIC_FLAG="--public"
            shift
            ;;
        --desc)
            DESCRIPTION="$2"
            shift 2
            ;;
        --filename)
            FILENAME="$2"
            shift 2
            ;;
        --no-browser)
            NO_BROWSER="1"
            shift
            ;;
        --host)
            GH_HOST="$2"
            shift 2
            ;;
        -*)
            echo "Unknown option: $1"
            echo "Usage: gist.sh [--public] [--desc \"description\"] [--filename \"name\"] [--no-browser] [--host \"github.example.com\"] [file...]"
            exit 1
            ;;
        *)
            FILES+=("$1")
            shift
            ;;
    esac
done

# Export GH_HOST if set (for GitHub Enterprise)
if [ -n "$GH_HOST" ]; then
    export GH_HOST
fi

# Build the gh gist create command
CMD="gh gist create"

# Add public flag if specified
if [ -n "$PUBLIC_FLAG" ]; then
    CMD="$CMD $PUBLIC_FLAG"
fi

# Add description if specified
if [ -n "$DESCRIPTION" ]; then
    CMD="$CMD --desc \"$DESCRIPTION\""
fi

# Add filename if specified (for stdin)
if [ -n "$FILENAME" ]; then
    CMD="$CMD --filename \"$FILENAME\""
fi

# Add web flag unless no-browser is specified
if [ -z "$NO_BROWSER" ]; then
    CMD="$CMD --web"
fi

# Add files if specified
if [ ${#FILES[@]} -gt 0 ]; then
    for file in "${FILES[@]}"; do
        if [ ! -f "$file" ]; then
            echo "Error: File not found: $file"
            exit 1
        fi
        CMD="$CMD \"$file\""
    done
else
    # No files specified, read from stdin
    CMD="$CMD -"
fi

# Display what we're doing
echo "Creating gist..."
if [ -n "$GH_HOST" ]; then
    echo "→ Host: $GH_HOST"
fi
if [ -n "$PUBLIC_FLAG" ]; then
    echo "→ Visibility: PUBLIC"
else
    echo "→ Visibility: PRIVATE (secret)"
fi

if [ -n "$DESCRIPTION" ]; then
    echo "→ Description: $DESCRIPTION"
fi

if [ ${#FILES[@]} -gt 0 ]; then
    echo "→ Files: ${FILES[*]}"
else
    echo "→ Source: stdin"
fi

echo ""

# Execute the command
eval "$CMD"

echo ""
echo "✅ Gist created successfully!"
