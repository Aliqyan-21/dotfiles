#!/usr/bin/env bash
set -euo pipefail

# Script: gh-download
# Description: Download a specific file or folder from a GitHub repository using gh.
# Usage: ./gh-download.sh [OPTIONS] <repo> <path>
#   repo: owner/repo (e.g., octocat/Hello-World)
#   path: path to file or folder within the repo (e.g., src/main.py, docs/)
# Options:
#   -b, --branch BRANCH   Branch, tag, or commit SHA (default: main)
#   -d, --dest DIR        Destination directory (default: current directory)
#   -h, --help            Show this help message
# Example:
#   ./gh-download.sh octocat/Hello-World README.md -b main -d ./downloads

show_help() {
    cat << EOF
Usage: $0 [OPTIONS] <repo> <path>

Download a file or folder from a GitHub repository without cloning the entire repo.

Arguments:
  repo      Repository in the format "owner/repo" (e.g., octocat/Hello-World)
  path      Path to the file or folder within the repository (e.g., src/main.py)

Options:
  -b, --branch BRANCH   Branch, tag, or commit SHA (default: main)
  -d, --dest DIR        Destination directory (default: current directory)
  -h, --help            Show this help message
EOF
    exit 0
}

REPO=""
PATH_IN_REPO=""
BRANCH="main"
DEST="."

while [[ $# -gt 0 ]]; do
    case "$1" in
        -b|--branch)
            BRANCH="$2"
            shift 2
            ;;
        -d|--dest)
            DEST="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            if [[ -z "$REPO" ]]; then
                REPO="$1"
            elif [[ -z "$PATH_IN_REPO" ]]; then
                PATH_IN_REPO="$1"
            else
                echo "Error: Unexpected argument: $1" >&2
                show_help
            fi
            shift
            ;;
    esac
done

if [[ -z "$REPO" || -z "$PATH_IN_REPO" ]]; then
    echo "Error: Missing repository or path." >&2
    show_help
fi

if ! command -v gh &> /dev/null; then
    echo "Error: 'gh' (GitHub CLI) is not installed. Please install it first." >&2
    exit 1
fi

if ! gh auth status &> /dev/null; then
    echo "Error: Not authenticated with GitHub CLI. Run 'gh auth login' first." >&2
    exit 1
fi

# function to download a file from the repo
download_file() {
    local api_url="$1"
    local local_path="$2"

    local response
    response=$(gh api "$api_url" --jq '.download_url, .size')
    local download_url
    download_url=$(echo "$response" | head -n1)
    local size
    size=$(echo "$response" | tail -n1)

    if [[ -z "$download_url" || "$download_url" == "null" ]]; then
        echo "Error: Failed to get download URL for $api_url" >&2
        return 1
    fi

    mkdir -p "$(dirname "$local_path")"

    echo "Downloading $local_path ($size bytes)"
    curl -sL -o "$local_path" "$download_url"
}

# function to download a directory recursively
download_directory() {
    local api_url="$1"
    local local_dir="$2"

    local items
    items=$(gh api "$api_url" --jq '.[] | {type: .type, name: .name, path: .path}')
    if [[ -z "$items" ]]; then
        echo "Error: Failed to list directory: $api_url" >&2
        return 1
    fi

    mkdir -p "$local_dir"

    echo "$items" | while IFS= read -r item; do
        local type
        local name
        local path
        type=$(echo "$item" | jq -r '.type')
        name=$(echo "$item" | jq -r '.name')
        path=$(echo "$item" | jq -r '.path')

        local item_api_url="https://api.github.com/repos/$REPO/contents/$path?ref=$BRANCH"
        local local_path="$local_dir/$name"

        if [[ "$type" == "file" ]]; then
            download_file "$item_api_url" "$local_path"
        elif [[ "$type" == "dir" ]]; then
            download_directory "$item_api_url" "$local_path"
        else
            echo "Warning: Skipping unsupported type '$type' for $name" >&2
        fi
    done
}

API_URL="https://api.github.com/repos/$REPO/contents/$PATH_IN_REPO?ref=$BRANCH"

# path is file or dir?
response_type=$(gh api "$API_URL" --jq 'if type == "array" then "dir" elif type == "object" then "file" else "error" end' 2>/dev/null || echo "error")
if [[ "$response_type" == "error" ]]; then
    echo "Error: Failed to fetch $API_URL. Check repository, path, and branch." >&2
    exit 1
fi

# destination file/folder to save
if [[ "$response_type" == "file" ]]; then
    local_path="$DEST/$(basename "$PATH_IN_REPO")"
    mkdir -p "$(dirname "$local_path")"
    download_file "$API_URL" "$local_path"
else
    local_path="$DEST/$(basename "$PATH_IN_REPO")"
    download_directory "$API_URL" "$local_path"
fi

echo "Download is completed."
