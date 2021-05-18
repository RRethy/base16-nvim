# Import Latest Base16 Schemes

A simple script to import the latest Base16 Schemes. Requirements were made as
light as possible.

## Requirements

* curl
* git
* zsh

## How Does it Work

The script pulls the latest _schemas.yaml_ for Base16 and then pulls down each
specified git repo. Using the scheme values for **base00** -> **base0F**, it
generates the colorscheme lua or vimls wrapper files.
