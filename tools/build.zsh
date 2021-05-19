#!/usr/bin/env zsh

setopt extendedglob

DIRNAME=${0:A:h}
SCHEMES_SOURCE=https://github.com/chriskempson/base16-schemes-source/raw/master/list.yaml
SCHEMES_LIST=${DIRNAME}/schemes.yaml
SCHEMES_DIR=${DIRNAME}/schemes
LUA_DIR=${DIRNAME:h}/lua/colors
VIM_DIR=${DIRNAME:h}/colors

function get_schemes_list() {
  printf "Getting schemes list..."
  curl -fsLS --create-dirs -o ${SCHEMES_LIST} ${SCHEMES_SOURCE}
  echo "Done"
}

function get_schemes() {
  grep -E "^[0-9a-zA-Z-]+: " ${SCHEMES_LIST} | while read line
  do
    name=$(echo ${line} | sed -ne 's/\([^:]*\): .*/\1/p')
    repo=$(echo ${line} | sed -ne 's/.*: \(.*\)/\1/p')
    if [ ! -d ${DIRNAME}/schemes/${name}/.git ]
    then
      git clone -q --depth=1 ${repo} ${SCHEMES_DIR}/${name} &
    else
      git \
        --git-dir=${SCHEMES_DIR}/${name}/.git \
        --work-tree=${SCHEMES_DIR}/${name} \
        pull -q &
    fi
  done

  printf "Cloning schemas..."
  wait
  echo "Done"
}


function process_vim() {
  local color
  local scheme=${1}
  local i=1
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

function process() {
  local name scheme
  printf "Processing scheme files..."
  rm -rf ${LUA_DIR}
  mkdir -p ${LUA_DIR} ${VIM_DIR}
  for scheme in ${SCHEMES_DIR}/*/*.yaml
  do
    name=${scheme:t:r}
    process_lua ${scheme} > ${LUA_DIR}/${name}.lua &
    process_vim ${scheme} > ${VIM_DIR}/base16-${name}.vim &
  done
  wait
  lua_init > ${LUA_DIR}/init.lua
  echo "Done"
}

function main() {
  get_schemes_list
  get_schemes
  process
}

main
