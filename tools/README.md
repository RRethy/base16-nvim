# Import Latest Base16 Schemes

A simple script to import the latest Base16 Schemes. Requirements were made as
light as possible.

## Requirements

* sed
* curl
* git
* zsh

### Nix

You can run the script directly, but if you prefer you can run it using `nix`. Doing so will ensure all dependencies are available.

```shell
nix-build && ./result
```

## How Does it Work

The script pulls the latest _schemas.yaml_ for Base16 and then pulls down each
specified git repo. Using the scheme values for **base00** -> **base0F**, it
generates the colorscheme lua or vimls wrapper files.
