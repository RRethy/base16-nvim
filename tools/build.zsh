#!/usr/bin/env zsh

setopt extendedglob

DIRNAME=${0:a:h}
PROJECT_DIR=${DIRNAME:h}
SCHEMES_SOURCE=https://github.com/base16-project/base16-schemes
SCHEMES_DIR=${DIRNAME}/schemes
LUA_DIR=${PROJECT_DIR}/lua/colors
VIM_DIR=${PROJECT_DIR}/colors
DOC_DIR=${PROJECT_DIR}/doc
THEMES_FILE=${PROJECT_DIR}/themes.txt

function get_schemes() {
  if [ ! -d ${SCHEMES_DIR}/base16-schemes/.git ]
  then
    git clone -q --depth=1 ${SCHEMES_SOURCE} ${SCHEMES_DIR}/base16-schemes &
  else
    git \
      --git-dir=${SCHEMES_DIR}/base16-schemes/.git \
      --work-tree=${SCHEMES_DIR}/base16-schemes \
      pull -q &
  fi

  printf "Cloning base16-schemes..."
  wait
  echo "Done"
}


function process_vim() {
  local color
  local scheme=${1}
  local i=1
  echo "hi clear"
  echo "let g:colors_name = 'base16-${scheme:t:r}'"
  echo "lua require('base16-colorscheme').setup({"
  for color in base0{0..9} base0{A..F}
  do
    [[ ${i} -eq 1 ]] && printf "    \ " || printf " "
    local value=$(sed -ne 's/'"${color}"': "\(.*\)".*/\1/p' ${scheme})
    printf "${color} = '#${value:l}'"
    [[ ${color} != "base0F" ]] && printf ','
    [[ ${i} -eq 4 ]] && echo && i=1 || ((i++))
  done
  echo "    \})"
}

function process_lua() {
  local color
  local scheme=${1}
  local i=1
  echo "return {"
  for color in base0{0..9} base0{A..F}
  do
    [[ ${i} -eq 1 ]] && printf "    " || printf " "
    local value=$(sed -ne 's/'"${color}"': "\(.*\)".*/\1/p' ${scheme})
    printf "${color} = '#${value:l}'"
    [[ ${color} != "base0F" ]] && printf ','
    [[ ${i} -eq 4 ]] && echo && i=1 || ((i++))
  done
  echo "}"
}

function lua_init() {
  local file name
  printf "local M = {}\n\n"
  for file in ${LUA_DIR}/*.lua~*/init.lua
  do
    name=${file:t:r}
    echo "M['${name}'] = require('colors.${name}')"
  done
  printf "\nreturn M\n"
}

function readme() {
  # Print README, until after the "generated" tag
  sed '/^<!-- generated docs: -->$/q' ${PROJECT_DIR}/README.md
  echo
  echo '```txt'
  # Print the themes with the base16 prefix
  # TODO consider dropping the prefix here to be consistent with the docs and lua API
  sed  's/^/base16-/' ${THEMES_FILE}
  echo '```'
}

function docs() {
  # Print docs, until after the preamble line "Here is a list of all builtin colorschemes."
  sed '/^Here is a list of all builtin colorschemes\.$/q' ${DOC_DIR}/colorscheme.txt
  echo
  echo '>'
  # Print THEMES_FILE with indentation
  sed  's/^/    /' ${THEMES_FILE}
  echo
  echo 'vim:tw=78:ts=8:ft=help:norl:'
}

function process() {
  local name scheme
  printf "Processing scheme files..."
  # Delete all color files except catppuccin, its not present in base16-schemes
  find ${LUA_DIR} ! -name 'catppuccin.lua' -type f -exec rm -f {} +
  rm -f ${THEMES_FILE}
  mkdir -p ${LUA_DIR} ${VIM_DIR}
  for scheme in ${SCHEMES_DIR}/*/*.yaml
  do
    name=${scheme:t:r}
    echo ${name} >> ${THEMES_FILE}
    process_lua ${scheme} > ${LUA_DIR}/${name}.lua &
    process_vim ${scheme} > ${VIM_DIR}/base16-${name}.vim &
  done
  wait
  lua_init > ${LUA_DIR}/init.lua
  echo "Done"
}

function write_docs() {
  local buffer
  echo -n "Processing docs..."
  buffer=$(readme)
  echo ${buffer} > ${PROJECT_DIR}/README.md
  buffer=$(docs)
  echo ${buffer} > ${DOC_DIR}/colorscheme.txt
  echo "Done"
}

function main() {
  get_schemes
  process
  write_docs
}

main
