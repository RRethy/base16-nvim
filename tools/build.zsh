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
  if (( ! $+commands[tinty] )); then
    2>&1 printf "tinty must be installed. See https://github.com/tinted-theming/tinty#installation\n\n"
  fi
}

function update_schemes() {
  tinty update
}

function process() {
  local name scheme
  printf "Generating colorschemes...\n"
  tinty build "$PLUGIN_DIR"
  wait
  lua_init > "${LUA_DIR}/init.lua"
  echo "Done"
}

function main() {
  ensure_tools
  update_schemes
  process
}

main
