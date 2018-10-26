" Vim syntax file
" Language: NC 
" Maintainer: Dave Eno <daveeno@gmail.com>
" Last Change: 2014 April 03

" Quit when a (custom syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn case ignore

syn  match ncComment /(.*)/ contains=ncTodo
syn  match generalCmment /\;.*/
syn  keyword ncGCodes g0 g01 g02 g03 g04 g1 g2 g3 g4 g10 g17 g18 g19 g20 g21 g28 g30 g33 g33.1 g38.2 g38.x g40 g41 g41.1 g42 g42.1 g43 g43.1 g49 g53 g54 g55 g56 g57 g58 g59 g59.1 g59.2 g59.3 g61 g61.1 g64 g76 g80 g81 g82 g83 g84 g85 g86 g87 g88 g89 g90 g91 g92 g92.1 g92.2 g92.3 g93 g94 g95 g96 g97 g98 g99
syn  keyword ncMCodes M00 M01 M02 M03 M04 M05 M06 M07 M08 M09 M0 M1 M2 M3 M4 M5 M6 M7 M8 M9 M30 M48 M49 M50 M51 M52 M53 M60 M62 M63 M64 M65 M66

syntax match ncXAxis "\<[XY]-\?\d\+\>"
syntax match ncXAxis "\<[XY]-\?\.\d\+\>"
syntax match ncXAxis "\<[XY]-\?\d\+\."
syntax match ncXAxis "\<[XY]-\?\d\+\.\d\+\>"

syntax match ncZAxis "\<Z-\?\d\+\>"
syntax match ncZAxis "\<Z-\?\.\d\+\>"
syntax match ncZAxis "\<Z-\?\d\+\."
syntax match ncZAxis "\<Z-\?\d\+\.\d\+\>"

syntax match ncAAxis "\<[ABC]-\?\d\+\>"
syntax match ncAAxis "\<[ABC]-\?\.\d\+\>"
syntax match ncAAxis "\<[ABC]-\?\d\+\."
syntax match ncAAxis "\<[ABC]-\?\d\+\.\d\+\>"

syntax match ncIAxis "\<[IJKR]-\?\d\+\>"
syntax match ncIAxis "\<[IJKR]-\?\.\d\+\>"
syntax match ncIAxis "\<[IJKR]-\?\d\+\."
syntax match ncIAxis "\<[IJKR]-\?\d\+\.\d\+\>"

syntax match ncTool "\<[ET]-\?\d\+\>"
syntax match ncTool "\<[ET]-\?\.\d\+\>"
syntax match ncTool "\<[ET]-\?\d\+\."
syntax match ncTool "\<[ET]-\?\d\+\.\d\+\>"

syntax match ncRapid "\<G\(\d\+\)\>"

syntax match ncCustom "\<M\(\d\+\)\>"

syntax match ncParam "\<S-\?\d\+\>"
syntax match ncParam "\<S-\?\.\d\+\>"
syntax match ncParam "\<S-\?\d\+\."
syntax match ncParam "\<S-\?\d\+\.\d\+\>"

syntax match ncFeed "\<F-\?\d\+\>"
syntax match ncFeed "\<F-\?\.\d\+\>"
syntax match ncFeed "\<F-\?\d\+\."
syntax match ncFeed "\<F-\?\d\+\.\d\+\>"

syntax match ncTool "\<T\d\+\>"

hi def link ncComment Comment
hi def link generalComment Comment
hi def link ncGCodes MoreMsg
hi def link ncMCodes MoreMsg
hi def link ncXAxis Keyword
hi def link ncYAxis Statement
hi def link ncTool Constant
hi def link ncCustom Type
hi def link ncZAxis WarningMsg
hi def link ncAAxis VimString

hi def link ncRapid WarningMsg
hi def link ncIAxis Identifier
hi def link ncSpecials SpecialChar
hi def link ncFeed SpecialChar
hi def link ncParam ErrorMsg
hi def link ncTool Define

let b:current_syntax = "nc"
