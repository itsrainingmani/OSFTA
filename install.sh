#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/itsrainingmani/OSFTA.git"
SKILL_NAME="discover-plugins"

usage() {
  cat <<EOF
Usage: $0 [OPTIONS]

Install the discover-plugins skill for OpenCode.

Options:
  -g, --global    Install globally (~/.config/opencode/)
  -l, --local     Install locally (.opencode/) [default]
  -h, --help      Show this help message

Examples:
  curl -fsSL https://raw.githubusercontent.com/itsrainingmani/OSFTA/main/install.sh | bash
  curl -fsSL https://raw.githubusercontent.com/itsrainingmani/OSFTA/main/install.sh | bash -s -- --global
EOF
}

main() {
  local install_type="local"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -g|--global) install_type="global"; shift ;;
      -l|--local) install_type="local"; shift ;;
      -h|--help) usage; exit 0 ;;
      *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
  done

  local target_dir
  if [[ "$install_type" == "global" ]]; then
    target_dir="${HOME}/.config/opencode/skills"
  else
    target_dir=".opencode/skills"
  fi

  local skill_path="${target_dir}/${SKILL_NAME}"

  local command_dir
  if [[ "$install_type" == "global" ]]; then
    command_dir="${HOME}/.config/opencode/commands"
  else
    command_dir=".opencode/commands"
  fi

  echo "Installing ${SKILL_NAME} skill (${install_type})..."

  local tmp_dir
  tmp_dir=$(mktemp -d)
  trap "rm -rf '$tmp_dir'" EXIT

  echo "Fetching skill..."
  git clone --depth 1 --quiet "$REPO_URL" "$tmp_dir"

  mkdir -p "$target_dir"

  if [[ -d "$skill_path" ]]; then
    echo "Updating existing installation..."
    rm -rf "$skill_path"
  fi

  cp -r "${tmp_dir}/skill/${SKILL_NAME}" "$skill_path"

  mkdir -p "$command_dir"
  local command_path="${command_dir}/${SKILL_NAME}.md"
  if [[ -d "$command_path" ]] || [[ -f "$command_path" ]]; then
    rm -rf "$command_path"
  fi
  cp "${tmp_dir}/command/${SKILL_NAME}.md" "$command_path"

  echo "Installed skill to: ${skill_path}"
  echo "Installed command to: ${command_path}"
  echo ""
  echo "Usage: /discover-plugins <query>"
  echo "Example: /discover-plugins notifications"
  echo ""
  echo "Done."
}

main "$@"
