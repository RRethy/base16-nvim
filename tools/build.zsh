#!/usr/bin/env zsh

set -o errexit
setopt extendedglob

DIRNAME="${0:A:h}"
PLUGIN_DIR="${DIRNAME:h}"
LUA_DIR="${PLUGIN_DIR}/lua/colors"
VIM_DIR="${PLUGIN_DIR}/colors"
SED_COMMAND=${SED_COMMAND:-sed}

function lua_init() {
  local file name
  printf "local M = {}\n\n"
  sorted_lua_colors | while read name; do
    echo "M['${name}'] = require('colors.${name}')"
  done
  printf "\nreturn M\n"
}

function ensure_tools() {
  if (( ! $+commands[tinted-builder-rust] )); then
    2>&1 printf "tinted-builder-rust must be installed. See https://github.com/tinted-theming/tinted-builder-rust?tab=readme-ov-file#cli\n\n"
    exit 1
  fi
}

function sorted_vim_colors() {
  print -l "${VIM_DIR}"/*.vim(#q:t:r) | sort
}

function sorted_lua_colors() {
  print -l "${LUA_DIR}"/*.lua~*/init.lua(#q:t:r) | sort
}

function update_readme() {
  local readme_path="${PLUGIN_DIR}/README.md"
  local header="# Builtin Colorschemes"
  $SED_COMMAND -i "/^${header}/,$ d" "$readme_path"
  cat <<-EOF >>! "$readme_path"
	$header

	\`\`\`txt
	$(sorted_vim_colors)
	\`\`\`
	EOF
}

function update_vimdoc() {
  local vimdoc_path="${PLUGIN_DIR}/doc/colorscheme.txt"
  # Replace all lines after this line:
  local start_marker="^BUILTIN COLORSCHEMES"
  # ...up until but not including this line:
  local end_marker="^vim:"

  # Build the text content:
  # Header line: 75 "="s
  local content=${(l:75::=:)}
  content="${content}\n\nHere is a list of all builtin colorschemes.\n\n"
  content="${content}>\n"
  # Left-pad the colorschemes with 4 spaces
  content="${content}$(sorted_vim_colors | awk '{ print "    "$1 }')\n"
  echo "$content" | $SED_COMMAND -i \
    "/${start_marker}/,/${end_marker}/ {
    /${start_marker}/!{
      /${end_marker}/!d
    }
    /${start_marker}/r /dev/stdin
}" "$vimdoc_path"
}

function process() {
  if [[ "$1" != "no-generate"  ]]; then
    ensure_tools
    local name scheme
    printf "Generating colorschemes...\n"
    tinted-builder-rust build "$PLUGIN_DIR" --sync
    wait
  else
    printf "Skipping colorscheme update & generation...\n"
  fi

  printf "Updating init.lua...\n"
  lua_init > "${LUA_DIR}/init.lua"
  printf "Updating README.md...\n"
  update_readme
  printf "Updating vimdoc...\n"
  update_vimdoc
  echo "Done"
}

function main() {
  process "$@"
}

main "$@"
