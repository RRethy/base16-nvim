# Generate Colorschemes with Latest Base16 Schemes

Using [tinted-builder-rust](https://github.com/tinted-theming/tinted-builder-rust), pulls the latest base16 schemes & generate the colorschemes.

## Requirements

* `tinted-builder-rust`
* `git`
* `zsh`
* **GNU** `sed`
* `awk`
* `sort`

## macOS

macOS comes with a version of `sed` that is not compatible with GNU `sed`. There are the steps to run this script with
to get the correct results:

```sh
brew install gnu-sed
SED_COMMAND=gsed tools/build.zsh
```

