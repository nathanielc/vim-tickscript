" Plugin to auto format TICKscripts
"
" Much of this plugin was copied from Fatih's wonderful https://github.com/fatih/vim-go/, so send him your thanks!

command! TickFmt call tick#fmt#Format()

augroup vim-tick
    autocmd!
    " Tick code formatting on save
    if get(g:, "tick_fmt_autosave", 1)
        autocmd BufWritePre *.tick call tick#fmt#Format()
    endif
augroup END

" vim:ts=4:sw=4:et
