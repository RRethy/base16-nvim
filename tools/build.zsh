#!/usr/bin/env zsh

setopt extendedglob

DIRNAME="${0:A:h}"
PLUGIN_DIR="${DIRNAME:h}"
LUA_DIR="${PLUGIN_DIR}/lua/colors"
VIM_DIR="${PLUGIN_DIR}/colors"

function lua_init() {
  local file name
  printf "local M = {}\n\n"
  for file in "${LUA_DIR}"/*.lua~*/init.lua
  do
    name="${file:t:r}"
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

function update_readme() {
  sed -i '' '/# Builtin Colorschemes/,$ d' "${PLUGIN_DIR}/README.md"
  schemes=''
  for file in "${VIM_DIR}"/*.vim
  do
    name="${file:t:r}"
    schemes="${schemes}${name}\n"
  done
  schemes="$(echo $schemes | sed '/^$/d' | sort)"
  content="# Builtin Colorschemes\n\n"'```'"txt\n$schemes\n"'```'
  echo $content >>! README.md
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
  echo "Done"
}

function main() {
  process "$@"
}

main "$@"
