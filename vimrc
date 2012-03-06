""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PATHOGEN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible            " Must come first because it changes other options.

filetype plugin off
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

set cpoptions=aABceFsmq
"set autochdir
set nostartofline " don't jump to the first character when paging
set title
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set ttyfast
let mapleader = '\'
let g:mapleader = '\'
let localleader = '\'
let g:localleader = '\'
let leader = '\'
let g:leader = '\'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DISPLAY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler
set showcmd
set laststatus=2
set winminheight=0
set winminwidth=0
set winheight=10
set display+=lastline
set textwidth=0
set wrapmargin=10
set numberwidth=5
set relativenumber

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set noautowrite
set visualbell
set t_vb= " visual bell
set shellcmdflag=-c
set shell=bash\ -l
set modeline
set modelines=10
set tabpagemax=100
set mousemodel=extend
set mouse=a
set ttymouse=xterm2
set noea
set shortmess=aOstTI " shortens messages to avoid 'press a key' prompt
set magic
set viminfo='10,\"100,:20,%,n~/.viminfo
set report=0
set smartcase
set timeoutlen=500
au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" Saving sessions
set sessionoptions=buffers,folds,tabpages

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set imd
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*.o,*~,.lo,*.pyc,*.bak,*.git,*.rbc
set whichwrap=b,s,h,l,<,>,~,[,] "everything wraps
set undolevels=5000
set autoindent
set preserveindent
set nosmartindent
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set wrap
set formatoptions=lcroqwan2vb1
set showmatch
set matchtime=5
set list
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:-
set showbreak=…
set encoding=utf-8 fileencodings=.
set showfulltag
set completeopt=menuone,preview
set complete=.,w,b,u,t,i
set iskeyword+=_,-,.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FOLDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=manual
set foldenable
set foldopen=block,hor,mark,percent,quickfix,tag
set foldminlines=2
set fillchars+=fold:\

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BUFFERS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
set bufhidden=hide
set hidden " you can change buffers without saving
set switchbuf=usetab
set splitbelow
set scrolloff=2
set sidescrolloff=2
set showtabline=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

hi NonText ctermfg=7 guifg=gray
hi SpecialKey ctermfg=8

" Use the below highlight group when displaying bad whitespace is desired.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" full Python syntax highlighting
let python_highlight_all=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BACKUPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowb
set noswapfile
set nobackup
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set history=500
set updatecount=100
set undofile
set undodir=/tmp,~/.vim/tmp/undo

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SPELLING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version >= 700
    setlocal spell spelllang=en_gb
    nmap <Leader>ss :set spell!<CR>
endif
try
    lang en_GB
catch
endtry

" Correct some spelling mistakes
ia teh      the
ia htis     this
ia tihs     this
ia funciton function
ia fucntion function
ia funtion  function
ia retunr   return
ia reutrn   return
ia sefl     self
ia eslf     self

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SEARCH
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch   " do incremental searching
set gdefault
set ignorecase
set smartcase
set infercase
set hlsearch
set showmatch
set diffopt=filler,iwhite
" use regular regex
nnoremap / /\v
vnoremap / /\v

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMAND-LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cno $q <C-\>eDeleteTilSlash()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS PER FILETYPE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" load the plugin and indent settings for the detected filetype
filetype plugin indent on

if has("autocmd")
  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab nocindent

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml

  " markdown
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

  au BufRead,BufNewFile *.txt call s:setupWrapping()

  " JSON syntax
  autocmd! BufRead,BufNewFile *.json setfiletype json

  " jQuery syntax
  autocmd! BufRead,BufNewFile *.js set ft=javascript syntax=jquery

  " Display tabs at the beginning of a line in Python mode as bad
  autocmd BufRead,BufNewFile *.py,*.pyw match ExtraWhitespace /^\t\+/
  " Make trailing whitespace be flagged as bad
  autocmd BufRead,BufNewFile *.py,*.pyw match ExtraWhitespace /\s\+$/
  autocmd BufRead,BufNewFile *.py,*.pyw let python_space_errors = 1
  autocmd BufRead,BufNewfile *.py,*.pyw call s:HighlightLongLines(79)

  " Drupal
  autocmd BufRead,BufNewFile *.test set ft=php
  autocmd BufRead,BufNewFile *.class set ft=php
  autocmd BufRead,BufNewFile *.module set ft=php
  autocmd BufRead,BufNewFile *.theme set ft=php
  autocmd BufRead,BufNewFile *.profile set ft=php
  autocmd BufRead,BufNewFile *.install set ft=php
  autocmd BufRead,BufNewFile *.tpl.php set ft=xhtml.php syntax=php
  autocmd BufRead,BufNewFile *.inc set ft=php
  autocmd BufRead,BufNewFile *.tpl.inc set ft=xhtml.php syntax=php

  " PHP
  autocmd FileType php set kp=phpdoc

  autocmd BufRead *.py set smartindent cinwords=if,else,elif,for,while,try,except,finally,def,class

  autocmd BufRead *.py set iskeyword+=.

  " mapping to mark HTML5 files
  autocmd BufEnter *html nmap <F7> :setfiletype html5<CR>

  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType css,sass,stylus set omnifunc=csscomplete#CompleteCSS
  autocmd BufRead *.styl set omnifunc=csscomplete#CompleteCSS
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

  " Less CSS
  autocmd BufRead,BufNewFile *.less set ft=css syntax=less
  autocmd BufWritePost master.less :silent !lessc -x % > %:p:r.css

  " CSS, XML, and HTML file shoulds be folded based on indent
  au BufNewFile,BufRead *css,*xml,*htm* set foldmethod=indent

  " CSS and Sass files should see - as part of a keyword
  "autocmd FileType css,stylus,less set iskeyword +=-

  " Git WIP
  augroup git-wip
    autocmd!
    autocmd BufWritePost * :silent !git wip save "WIP from vim" --editor -- "%"
  augroup END


  " SAVE FILES WHEN VIM LOSES FOCUS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  au FocusLost *.htm*,*.js,*.css,*.php,*.styl :wa

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omnicompletion keymappings
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<Down>" : ""<CR>'

" CD to directory of current file
map <Leader>cd :cd %:p:h<CR>

" Grep/QuickFix window bindings
map <Leader>c :botright cw 10<CR>

" Easily move chunks of text
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

" Mac OS X/Safari keybindings for tabs
nmap <D-[> :tabprevious<CR>
nmap <D-]> :tabnext<CR>
map <D-[> :tabprevious<CR>
map <D-]> :tabnext<CR>
imap <D-[> <Esc>:tabprevious<CR>i
imap <D-]> <Esc>:tabnext<CR>i
nmap <D-t> :tabnew<CR>
imap <D-t> <Esc>:tabnew<CR>

" Bind Command-arrow/movement to move between windows
map <D-J> <C-W>j
map <D-S-Down> <C-W>j
map <D-K> <C-W>k
map <D-S-Up> <C-W>k
map <D-H> <C-W>h
map <D-S-Left> <C-W>h
map <D-L> <C-W>l
map <D-S-Right> <C-W>l

map <D-0> <C-W>= " make Command-0 equal windows

nnoremap <leader>w <C-w>v<C-w>l

" Debugging
nmap <silent> <leader>b :Bp<cr>

" Map fullscreen mode
nmap <leader>ff :set invfullscreen<CR>

" Edit .vimrc
nmap <leader>V :vsplit<CR><C-w><C-w>:e $MYVIMRC<CR>

" If I forgot to sudo a file, do that with :w!!
cmap w!! w !sudo tee % > /dev/null

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Don't use Ex mode, use Q for formatting
nmap Q gq

" Turn hidden characters on/off
nmap <silent> <leader>sc :set nolist!<CR>

" Up/down go visually instead of by physical lines
" Interactive ones need to check whether we're in the autocomplete popup
map <up> gk
inoremap <up> <C-R>=pumvisible() ? "\<lt>up>" : "\<lt>C-o>gk"<Enter>
map <down> gj
inoremap <down> <C-R>=pumvisible() ? "\<lt>down>" : "\<lt>C-o>gj"<Enter>

" Map normal mode Enter to add a new line before the current one
"nmap <Enter> O<Esc>

" Makes ; work for :
nnoremap ; :

" Makes W send w when it's a command
command! W w

" bind command-]/command-[ to act like TextMate
nmap <D-]> >>
nmap <D-[> <<
vmap <D-]> >gv
vmap <D-[> <gv

" Toggle search highlight
nnoremap <silent> \ :noh<CR>

" CommandT browser
nmap <silent> <Leader>o :CommandT<CR>

""" Folds
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
" set <space> to toggle folds in normal & visual modes
nnoremap <space> za
vnoremap <space> zf

" Searching
nmap n nzzzv
nmap * *zzzv
nmap # #zzzv
nmap g* g*zzzv
nmap g# g#zzzv

" Mappings for cope
nmap <leader>cc :botright cope<CR>
nmap <leader>n :cn<CR>
nmap <leader>p :cp<CR>
nmap <leader>ll :ll<CR>

" Mapping for tabs/buffers
nmap gz :bdelete<CR>
nmap gb :bnext<CR>
nmap gB :bprev<CR>
nmap <leader>clear :1,3000bd<CR>

" Sort CSS files alphabetically
nmap sort :g#\({\n\)\@<=#.,/}/sort<CR>

" Rainbows!
nmap <leader>r :RainbowParenthesesToggle<CR>

" Make <leader>ft fold an HTML tag
nnoremap <leader>ft Vatzf

" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Reselect just-pasted text
nnoremap <leader>v V`]

" In addition to <esc>, jj will exit to normal mode.
inoremap jj <ESC>

" Launch Ack quicker
nnoremap <leader>a :Ack

" Use - to open Explore
nnoremap - :Explore<CR>

" Close location list when exiting a file
cabbrev q lcl\|q
cabbrev q! lcl\|q!
cabbrev bd lcl\|bd
cabbrev bd! lcl\|bd!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" GUNDO
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>g :GundoToggle<CR>

" Neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" XPTemplates
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:xptemplate_vars = "SParg="
let g:xptemplate_brace_complete = ''

" MATCHIT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime plugins/matchit.vim
let b:match_ignorecase = 1

" NETRW
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Default to tree view
let g:netrw_lifestyle = 3
" hide common hidden files
let g:netrw_list_hide = '.*\.py[co]$,\.git$,\.swp$'
" Don't use fricken elinks, wtf
let g:netrw_http_cmd = "wget -q -O" " or 'curl -Ls -o'
let g:netrw_winsize = 10
let g:netrw_alto = 1

" LUSTYJUGGLER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:LustyJugglerSuppressRubyWarning = 1

" EASYTAGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=tags;/
let g:easytags_resolve_links = 1
let g:easytags_cmd = '/opt/local/bin/ctags'

" Add RebuildTags function/command
map <Leader>rt :!/opt/local/bin/ctags --langmap=php:.engine.inc.module.theme.php --php-kinds=cdfi --languages=php,javascript --recurse --exclude="\.git" --totals=yes --extra=+qf <CR>

" TAGLIST
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Use_Right_Window = 1
"let Tlist_Auto_Open = 0
"let Tlist_Enable_Fold_Column = 0
"let Tlist_Compact_Format = 1
"let Tlist_WinWidth = 40
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_File_Fold_Auto_Close = 1
"let Tlist_Sort_Type = 'name'
"let Tlist_Ctags_Cmd = '/opt/local/bin/ctags'
"let Tlist_Show_Menu = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Close_On_Select = 1
"let Tlist_Auto_Update = 1
"nnoremap <silent> <Leader>t :TlistToggle<CR>

" RAGTAG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <M-o> <Esc>o
inoremap <C-j> <Down>
let g:ragtag_global_maps = 1

" NERD_COMMENTER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <D-/> ,c<space>
vmap <D-/> ,c<space>
imap <D-/> <C-O>,c<space>

" NERD_TREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>d :NERDTreeFind<CR>
let g:NERDChristmasTree = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinPos = 'right'
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoCenter = 1
let g:NERDTreeIgnore = ['\.git$', '\.svn$', '\.jpg$', '\.gif$', '\.png$', '\.pyc', '\.DS_Store']
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeSortOrder = ['\/$', '*']
let g:NERDTreeShowLineNumbers = 1

" COMMAND-T
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <Leader>t :CommandT<CR>
nmap <silent> <Leader>b :CommandTBuffer<CR>

" YANKRING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <Leader>y :YRShow<CR>
"
" skip all single-letter deletes (x)
let g:yankring_min_element_length = 2
"
" save last 50 items in history, only show last 50 in window
let g:yankring_max_history = 50
let g:yankring_max_display = 50
"
" save yankring entries across vim instances
let g:yankring_persist = 1
let g:yankring_share_between_instances = 1
"
" don't save duplicates
let g:yankring_ignore_duplicate = 1

" use a separate vertical split window that auto-closes and
" is 30 chars wide on the right side
let g:yankring_window_use_separate = 1
let g:yankring_window_use_horiz = 0
let g:yankring_window_auto_close = 1
let g:yankring_window_width = 50
let g:yankring_window_use_right = 1

" pressing <space> will increase the size of the window by 15 columns
let g:yankring_window_increment = 15

" have yankring manage Vim's numbered registers ("0-"9)
let g:yankring_manage_numbered_reg = 1

" keep the history file in the $HOME/.vim folder instead of $HOME
let g:yankring_history_dir = '/tmp'

" yankring keeps an eye on the clipboard
let g:yankring_clipboard_monitor = 1

" if something changes the default register without going through
" yankring, use the default register value rather than the top item in
" yankring's history
let g:yankring_paste_check_default_buffer = 1

" CoffeeScript
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let coffee_compile_on_save = 1
let coffee_make_options = "--lint"
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
" compile to file
au BufWritePost *.coffee silent CoffeeMake! | cwindow | redraw!

" SYNTASTIC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use signs to indicate lines with errors
" only if signs are available
if has('signs')
  let g:syntastic_enable_signs = 1
endif

" automatically open the location list when a buffer has errors
let g:syntastic_auto_loc_list = 1

" always show warnings
let g:syntastic_quiet_warnings = 0

" auto jump to errors upon opening/saving
let g:syntastic_auto_jump=1

" ignore djangohtml
let g:syntastic_disabled_filetypes = ['htmldjango', 'txt', 'text', 'tumblr', 'css', 'html5']

let g:syntastic_jsl_conf = '~/bin/dotfiles/vim/jsl.conf'

" FUGITIVE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gc :Gcommit<CR>

" ZEN CODING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1
let g:user_zen_leader_key = '<c-y>'

let g:user_zen_settings = {
  \  'indentation' : '  '
  \}

" SCRATCH BUFFER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction
nmap <leader><tab> :call <SID>ToggleScratch()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" TOGGLE LINE NUMBER MODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! g:ToggleNuMode()
    if (&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc
nnoremap <leader>l :call g:ToggleNuMode()<CR>

" Custom Fold Method
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MyFoldText()
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces "
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction
set foldtext=MyFoldText()

" HIGHLIGHT LONG LINES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
  let targetWidth = a:width != '' ? a:width : 79
  if targetWidth > 0
    exec 'match Error /\%>' . (targetWidth) . 'v/'
  else
    echomsg "Usage: HighlightLongLines [natural number]"
  endif
endfunction
nmap <leader>h :HighlightLongLines<CR>

" SEARCH FOR VISUAL SELECTION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" STAB: SET TABSTOPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    end
  finally
    echohl None
  endtry
endfunction

" Compile JS with google closure
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Compile_JS()
  if &ft == "javascript"
    let fn = expand('%:p')
    let pn = expand('%:p:h')
    let fnm = expand('%:t:r.js')
    let cpa = "~/bin/closure/compiler.jar"
    execute "! java -jar " . cpa . " --js=" . fn . " --js_output_file=" . pn . "/" . fnm . ".min.js"
  endif
endfunction
au FileType javascript command! -buffer C :call Compile_JS()

" Utility function to perform a command and preserve the history/cursor
" position
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" STRIP TRAILING WHITESPACE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StripTrailingWhitespaces()
  call Preserve('%s/\s\+$//e')
endfunction

augroup LastModified
  au!
  au BufWritePre * :call StripTrailingWhitespaces()
augroup END

" DISPLAY OUTPUT OF SHELL COMMANDS IN SCRATCH BUFFER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  silent execute '$read !'. expanded_cmdline
endfunction

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTilSlash()
  let g:cmd = getcmdline()
  let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")

  if g:cmd == g:cmd_edited
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

func! CurDir()
  let curdir = substitute(getcwd(), '/Users/cw', "~/", "g")
  return curdir
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISCELLANEOUS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="low"    "default value is normal
syntax enable
set background=dark
colorscheme solarized
" ------------------------------------------------------------------

" The following items are available options, but do not need to be
" included in your .vimrc as they are currently set to their defaults.

" let g:solarized_termtrans=1
" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
" let g:solarized_termcolors=16
" let g:solarized_diffmode="normal"
" let g:solarized_hitrail=0
" let g:solarized_menu=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")
  "set guifont=EspressoMono-Regular:h12            " Font family and font
  set guifont=Inconsolata:h14
  "set guifont=menlo:h12
  set fuoptions=maxvert,maxhorz     " fullscreen maximizes vertically AND horizontally
  set antialias                     " MacVim: smooth fonts.
  set encoding=utf-8                " Use UTF-8 everywhere.
  set guioptions-=T                 " Hide toolbar.

  set lines=50 columns=145          " Window dimensions.
  set guioptions+=e
  set guioptions-=r                 " Don't show right scrollbar
  set guioptions-=R                 " Don't show right scrollbar
  set guioptions-=l                 " Don't show left scrollbar
  set guioptions-=L                 " Don't show left scrollbar

  "macmenu &File.New\ Tab key=<nop>
  map <D-d> :CommandT<CR>
  set formatoptions-=tc
  let macvim_hig_shift_movement = 1

  set background=dark
  colorscheme solarized

  " bind command-] to shift right
  nmap <D-]> >>
  vmap <D-]> >>
  imap <D-]> <C-O>>>

  " bind command-[ to shift left
  nmap <D-[> <<
  vmap <D-[> <<
  imap <D-[> <C-O><<
else
  set background=dark
  let g:solarized_termcolors=256
  colorscheme solarized
endif

