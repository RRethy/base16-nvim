# nvim-base16

Neovim plugin for building base16 colorschemes with support for Neovim's
builtin LSP and Treesitter.

```lua
-- All builtin colorschemes can be accessed with |:colorscheme|.
vim.cmd('colorscheme base16-gruvbox-dark-soft')

-- Alternatively, you can provide a table specifying your colors to the setup function.
require('base16-colorscheme').setup({
    base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',
    base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',
    base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',
    base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
})
```

# Builtin Colorschemes

```txt
3024
apathy
ashes
atelier-cave-light
atelier-cave
atelier-dune-light
atelier-dune
atelier-estuary-light
atelier-estuary
atelier-forest-light
atelier-forest
atelier-heath-light
atelier-heath
atelier-lakeside-light
atelier-lakeside
atelier-plateau-light
atelier-plateau
atelier-savanna-light
atelier-savanna
atelier-seaside-light
atelier-seaside
atelier-sulphurpool-light
atelier-sulphurpool
atlas
bespin
black-metal-bathory
black-metal-burzum
black-metal-dark-funeral
black-metal-gorgoroth
black-metal-immortal
black-metal-khold
black-metal-marduk
black-metal-mayhem
black-metal-nile
black-metal-venom
black-metal
brewer
bright
brogrammer
brogrammer2.0
brushtrees-dark
brushtrees
chalk
circus
classic-dark
classic-light
codeschool
cupcake
cupertino
darktooth
default-dark
default-light
darcula
dracula
eighties
embers
flat
fruit-soda
github
google-dark
google-light
grayscale-dark
grayscale-light
greenscreen
gruvbox-dark-hard
gruvbox-dark-medium
gruvbox-dark-pale
gruvbox-dark-soft
gruvbox-light-hard
gruvbox-light-medium
gruvbox-light-soft
harmonic-dark
harmonic-light
heetch-light
heetch
helios
hopscotch
horizon-dark
ia-dark
ia-light
icy
irblack
isotope
macintosh
marrakesh
materia
material-darker
material-lighter
material-palenight
material-vivid
material
mellow-purple
mexico-light
mocha
monokai
nord
ocean
oceanicnext
one-light
onedark
outrun-dark
papercolor-dark
papercolor-light
paraiso
phd
pico
pop
porple
railscasts
rebecca
schemer-dark
schemer-medium
seti
shapeshifter
snazzy
solarflare
solarized-dark
solarized-light
spacemacs
summerfruit-dark
summerfruit-light
synth-midnight-dark
tomorrow-night-eighties
tomorrow-night
tomorrow
tube
twilight
unikitty-dark
unikitty-light
woodland
xcode-dusk
zenburn
```

# Examples

## schemer-dark

<img src="https://user-images.githubusercontent.com/21000943/111041838-4d837e00-8408-11eb-9a8f-9909abb29560.png" width="520" height="342">

## gruvbox-dark-soft

<img src="https://user-images.githubusercontent.com/21000943/111041834-4c525100-8408-11eb-8f5d-b17ef1c139dc.png" width="520" height="342">

## solarized-dark

<img src="https://user-images.githubusercontent.com/21000943/111041839-4e1c1480-8408-11eb-9351-22a4a1d55f2a.png" width="520" height="342">

## onedark

<img src="https://user-images.githubusercontent.com/21000943/111041835-4ceae780-8408-11eb-86e0-3d2857e8ba01.png" width="520" height="342">

## one-light

<img src="https://user-images.githubusercontent.com/21000943/111041836-4ceae780-8408-11eb-8ef1-69eb19768cac.png" width="520" height="342">

## monokai

<img src="https://user-images.githubusercontent.com/21000943/111041934-b965e680-8408-11eb-9b11-e2b97c3514dc.png" width="520" height="342">

## paraiso

<img src="https://user-images.githubusercontent.com/21000943/111041837-4d837e00-8408-11eb-89db-ed9c3884aa61.png" width="520" height="342">
