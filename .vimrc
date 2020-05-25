syntax on
set nocindent
set noautoindent
set cinoptions=
set nosmartindent
set indentexpr=
filetype indent off
filetype plugin indent off 
filetype plugin on
" set background=dark
"set path=.,/usr/include,,/webserver/drupalteste

" by Patola: a statusline for fugitive (git add-on)
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" by Patola: to enable taglist,
" helptags .
" then
" TListToggle
" by Patola, taken from http://drupal.org/node/29325
if has("autocmd")
" Drupal *.module files.
  augroup module
  autocmd BufRead *.module set filetype=php expandtab tabstop=2 shiftwidth=2 autoindent smartindent
  autocmd BufRead *.install set filetype=php expandtab tabstop=2 shiftwidth=2 autoindent smartindent
  augroup END
endif

" My perl settings
"if has("autocmd")
"  autocmd BufRead *.pl set filetype=php expandtab tabstop=2 shiftwidth=2 autoindent smartindent
"endif

if has("gui_running")
  se background=light
  se guifont=Ubuntu\ Mono\ 9
  se guicursor=a:blinkon0
"  se guioptions=bgmprT
  if exists(":winpos") == 2
    winpos 0 0
  endif 
else
  se background=dark
endif

" If you like SQL syntax highlighting inside Strings: >
let php_sql_query = 1
" For highlighting the Baselib methods: >
let php_baselib = 1
" Enable HTML syntax highlighting inside strings: >
let php_htmlInStrings = 1
" Using the old colorstyle: >
let php_oldStyle = 1
" Enable highlighting ASP-style short tags: >
let php_asp_tags = 1
" Disable short tags: >
let php_noShortTags = 1
" For highlighting parent error ] or ): >
let php_parent_error_close = 1
" " For skipping an php end tag, if there exists an open ( or [ without a closing
"  one: >
let php_parent_error_open = 1
" Enable folding for classes and functions: >
let php_folding = 1

" by Patola, for perl
au Filetype perl source ~/.vim/perl.vim

" by Patola, for Makefiles
autocmd FileType make setlocal noexpandtab

au FileType python source ~/.vim/patola-python.vim

" by Patola, for g-code files:
au BufRead,BufNewFile *.gco set filetype=nc
au BufRead,BufNewFile *.gcode set filetype=nc

"
" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path
"
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile>

" seems to enable use of regular clipboard in vim or gvim:
se clipboard=unnamed

autocmd FileType perl setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent
autocmd FileType sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent smartindent

filetype off
call pathogen#runtime_append_all_bundles()
" by Patola: next line might be unnecessary to run every time. Just call
" Helptags within vim (yes, with an uppercase H)
" call pathogen#helptags()
filetype on

set clipboard=exclude:.*
