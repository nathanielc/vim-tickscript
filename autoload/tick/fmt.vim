" Copied from https://github.com/fatih/vim-go/blob/master/autoload/go/fmt.vim
" and modified for TICKscript
"
" fmt.vim: Vim command to format TICKscript files with tickfmt.
"
" This filetype plugin add a new commands for tick buffers:
"
"   :Fmt
"
"       Filter the current TICKscript buffer through tickfmt.
"       It tries to preserve cursor position and avoids
"       replacing the buffer with stderr output.
"
" Options:
"
"   g:tick_fmt_command [default="tickfmt"]
"
"       Flag naming the tickfmt executable to use.
"
"   g:tick_fmt_autosave [default=1]
"
"       Flag to auto call :Fmt when saved file
"
"   g:tick_fmt_experimental[default=0]
"
"       Flag to use experimental features for perserving cursor, undo history.

if !exists("g:tick_fmt_command")
    let g:tick_fmt_command = "tickfmt"
endif

if !exists('g:tick_fmt_autsave')
    let g:tick_fmt_autosave = 1
endif

if !exists("g:tick_fmt_experimental")
    let g:tick_fmt_experimental = 0
endif

"  we have those problems : 
"  http://stackoverflow.com/questions/12741977/prevent-vim-from-updating-its-undo-tree
"  http://stackoverflow.com/questions/18532692/golang-formatter-and-vim-how-to-destroy-history-record?rq=1
"
"  The below function is an improved version that aims to fix all problems.
"  it doesn't undo changes and break undo history.  If you are here reading
"  this and have VimL experience, please look at the function for
"  improvements, patches are welcome :)
function! tick#fmt#Format()
    if g:tick_fmt_experimental == 1
        " Using winsaveview to save/restore cursor state has the problem of
        " closing folds on save:
        "   https://github.com/fatih/vim-go/issues/502
        " One fix is to use mkview instead. Unfortunately, this sometimes causes
        " other bad side effects:
        "   https://github.com/fatih/vim-go/issues/728
        " and still closes all folds if foldlevel>0:
        "   https://github.com/fatih/vim-go/issues/732
        let l:curw = {}
        try
            mkview!
        catch
            let l:curw=winsaveview()
        endtry
    else
        " Save cursor position and many other things.
        let l:curw=winsaveview()
    endif

    " Write current unsaved buffer to a temp file
    let l:tmpname = tempname()
    call writefile(getline(1, '$'), l:tmpname)

    if g:tick_fmt_experimental == 1
        " save our undo file to be restored after we are done. This is needed to
        " prevent an additional undo jump due to BufWritePre auto command and also
        " restore 'redo' history because it's getting being destroyed every
        " BufWritePre
        let tmpundofile=tempname()
        exe 'wundo! ' . tmpundofile
    endif

    " get the command first so we can test it
    let fmt_command = g:tick_fmt_command

    " populate the final command
    let command = fmt_command . ' -w '
    echo command . " " . l:tmpname

    " execute our command...
    let out = system(command . " " . l:tmpname)

    let l:listtype = "locationlist"
    "if there is no error on the temp file replace the output with the current
    "file (if this fails, we can always check the outputs first line with:
    "splitted =~ 'package \w\+')
    if v:shell_error == 0
        " remove undo point caused via BufWritePre
        try | silent undojoin | catch | endtry

        " Replace current file with temp file, then reload buffer
        let old_fileformat = &fileformat
        call rename(l:tmpname, expand('%'))
        silent edit!
        let &fileformat = old_fileformat
        let &syntax = &syntax
    else
        echo "Error: " . out
        " clean up
        "call delete(l:tmpname)
    endif

    if g:tick_fmt_experimental == 1
        " restore our undo history
        silent! exe 'rundo ' . tmpundofile
        call delete(tmpundofile)
    endif

    if g:tick_fmt_experimental == 1
        " Restore our cursor/windows positions, folds, etc.
        if empty(l:curw)
            silent! loadview
        else
            call winrestview(l:curw)
        endif
    else
        " Restore our cursor/windows positions.
        call winrestview(l:curw)
    endif
endfunction


" vim:ts=4:sw=4:et
