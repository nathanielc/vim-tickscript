" Vim syntax file
" Language: TICKscript
" Maintainer: Nathaniel Cook nvcook42@gmail.com

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif


syn case match

" Keywords
syn keyword     tickKeywords          var lambda TRUE FALSE AND OR

hi def link     tickKeywords          Keyword

" Global vars
syn keyword     tickExprGlobalVars    stream batch influxql

hi def link     tickExprGlobalVars    Type

" Comments; their contents
syn keyword     tickTodo              contained TODO FIXME XXX BUG
syn cluster     tickCommentGroup      contains=tickTodo
syn region      tickComment           start="//" end="$" contains=@tickCommentGroup,@Spell

hi def link     tickComment           Comment
hi def link     tickTodo              Todo

" Strings
syn region      tickString            start=/'/ skip=/\\'/ end=/'/
syn region      tickString            start=/'''/ end=/'''/

hi def link     tickString            String

" Identifiers, References and Functions
syn region      tickReference         start=/"/ skip=/\\"/ end=/"/
syn match       tickIdentifier        /\w\+/
syn match       tickFunction          /\w\+(/he=e-1

hi def link     tickReference         Identifier
hi def link     tickIdentifier        Identifier


" Integers
syn match       tickDecimalInt        /\<\d\+\>/

hi def link     tickDecimalInt        Number

" Floating point
syn match       tickFloat             /\<\d\+\.\d+\>/

hi def link     tickFloat             Float

" Duration literals
syn match       tickDuration         /\<\d\+\([uµmshdw]\|ms\)\>/

hi def link     tickDuration         Number

" Dot
syn match       tickDot              /\./

hi def link     tickDot              SpecialChar

let b:current_syntax = "tick"
