# Vim Support for [TICKscript](https://docs.influxdata.com/kapacitor/v0.11/tick/)


## Syntax highlighting


This plugin provides basic syntax highlighting for all TICKscript files denoted by the `.tick` extension.

## Install

Plugin managers are preferred. For Pathogen just clone the repo. For other
plugin managers add the appropriate lines and execute the plugin's install
command.

*  [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/nathanielc/vim-tickscript.git ~/.vim/bundle/vim-tickscript`
*  [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'nathanielc/vim-tickscript'`

You will need the `tickfmt` command in your PATH in order to format TICKscript files.
You can easily install them with the included `:TickInstallBinaries` command. If invoked, 
all necessary binaries will be automatically downloaded and installed to your `$GOBIN`
environment (if not set it will use `$GOPATH/bin`). Note that this command requires `git` 
for fetching the individual Go packages. Additionally, use `:TickUpdateBinaries` to update the
installed binaries.

Optionally, you can manually download and install the required binaries using the following command:

```sh
go get github.com/influxdata/kapacitor/tick/cmd/tickfmt
```

## Formatting

By default this plugin will format TICKscript files on save.

These options are available:

```vim
" The command to use to format TICKscripts, should not need to be changed
" g:tick_fmt_command [default="tickfmt"]

" Whether to format on save
" g:tick_fmt_autosave [default=1]

" Whether to enable experimental features that do a better job of preserving cursor, undo history etc.
" g:tick_fmt_experimental [default=0]
```

The command `:TickFmt` will format the current buffer.

## Credits

This plugin is a slightly modified version of https://github.com/fatih/vim-go/.
Many thanks to Fatih for his amazing work!

