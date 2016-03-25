# Vim Support for [TICKscript](https://docs.influxdata.com/kapacitor/v0.11/tick/)


## Syntax highlighting


This plugin provides basic syntax highlighting for all TICKscript files denoted by the `.tick` extension.

## Formatting

By default this plugin will format TICKscript files on save.

You will need the `tickfmt` command in your PATH in order to format TICKscript files.

```sh
go get github.com/influxdata/kapacitor/tick/cmd/tickfmt
```

These options are available:

```vim
" The command to use to format TICKscripts, should not need to be changed
" g:tick_fmt_command [default="tickfmt"]

" Whether to format on save
" g:tick_fmt_autsave [default=1]

" Whether to enable experimental features that do a better job of preserving cursor, undo history etc.
" g:tick_fmt_experimental [default=0]
```

The command `:TickFmt` will format the current buffer.

## Credits

This plugin is a slightly modified version of https://github.com/fatih/vim-go/.
Many thanks to Fatih for his amazing work!

