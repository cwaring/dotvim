""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PATHOGEN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin off
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

set nocompatible            " Must come first because it changes other options.
set cpoptions=aABceFsmq
set autochdir
set nostartofline " don't jump to the first character when paging
set title
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set ttyfast
let mapleader = ','
let g:mapleader = ','
let localleader = ','
let g:localleader = ','
let leader = ','
let g:leader = ','

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
set modelines=5
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
au CursorMovedI * if pumvisible() == 0|pclose|endif
au InsertLeave * if pumvisible() == 0|pclose|endif

" Saving sessions
set sessionoptions=buffers,folds,tabpages

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEXT EDITING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set imd
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*~,.lo,*.pyc,*.bak,*.jpg,*.png,*.gif
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
set completeopt=longest,menuone,preview
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
colorscheme ir_black
set background=dark
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
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2

set statusline=%-.50F " Full path to file, 50 characters max
set statusline+=\ %{fugitive#statusline()} " Fugitive status line
set statusline+=\ (%n) " buffer number
set statusline+=\ %([%M%R%H%W]\ %) " Modified, Read-only, Help, and Preview flags
set statusline+=\ %y " Filetype
set statusline+=\ %#error# " switch to error color
set statusline+=%{StatuslineTabWarning()} " show warning about mixed tabs or bad &et
set statusline+=%{StatuslineTrailingSpaceWarning()} " show warning about trailing whitespace
set statusline+=%{StatuslineLongLineWarning()} " show warning about long lines
set statusline+=%* " back to normal color
set statusline+=\ %#warningmsg# " switch to warningmsg color
set statusline+=%{SyntasticStatuslineFlag()} " show Syntastic flag
set statusline+=%* " back to normal color
set statusline+=\ %=%< " Right-align and start truncation
" set statusline+=%{TagInStatusLine()} " Show current class/function in Python
set statusline+=\ [%04l/%04L\ %03c] " Show current line number, total lines, current column
set statusline+=\ %p%% " Percentage through file in lines

" recalculate the warning flags when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

" return '[mixed]' if spaces and tabs are used to indent
" return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning = '[mixed]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

" return '[\s]' if trailing white space is detected
" return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        let tabs = search('\t\+$', 'nw') != 0
        let spaces = search('\s\+$', 'nw') != 0
        if tabs || spaces
            let b:statusline_trailing_spaces_warning = '[\s]'
        else
            let b:statusline_trailing_spaces_warning = ''
        endif
    endif
    return b:statusline_trailing_spaces_warning
endfunction

" return a warning for 'long lines' where 'long' is either &textwidth
" or 80 (if no &textwidth is set)
"
" return '' if no long lines
" return '[#x, my, $z]' if long lines are found, where 'x' is the number
" of long lines, 'y' is the median length of the long lines, and 'z' is
" the length of the longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                \ '#' . len(long_line_lens) . ", " .
                \ 'm' . s:Median(long_line_lens) . ", " .
                \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ''
        endif
    endif
    return b:statusline_long_line_warning
endfunction

" return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

" find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

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
filetype plugin on
filetype indent on

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
  augroup mkd
    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
  augroup END

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
  autocmd BufRead,BufNewFile *tpl.inc set ft=xhtml.php syntax=php

  " PHP
  autocmd FileType php set kp=phpdoc

  " only UNIX line endings.
  autocmd BufNewFile *.* set fileformat=unix

  autocmd BufEnter * :syntax sync fromstart

  autocmd BufRead *.py set smartindent cinwords=if,else,elif,for,while,try,except,finally,def,class

  autocmd BufRead *.py set iskeyword+=.

  " mapping to mark HTML5 files
  autocmd BufEnter *html nmap <F7> :setfiletype html5<CR>

  if version >= 700
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType css,sass set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
  endif

  " CSS, XML, and HTML file shoulds be folded based on indent
  au BufNewFile,BufRead *css,*xml,*htm* set foldmethod=indent

  " CSS and Sass files should see - as part of a keyword
  autocmd FileType css,sass set iskeyword +=-
  au! BufRead,BufNewFile *.sass,*.scss setfiletype sass

  " Git WIP
  augroup git-wip
    autocmd!
    autocmd BufWritePost * :silent !git wip save "WIP from vim" --editor -- "%"
  augroup END

  " USE GOOGLE'S JAVASCRIPT LINTER
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  au BufNewFile,BufRead *.js set makeprg=gjslint\ %
  au BufNewFile,BufRead *.js set errorformat=%-P-----\ FILE\ \ :\ \ %f\ -----,Line\ %l\\,\ E:%n:\ %m,%-Q,%-GFound\ %s,%-GSome\ %s,%-Gfixjsstyles%s,%-Gscript\ can\ %s,%-G

  " SAVE FILES WHEN VIM LOSES FOCUS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  au FocusLost *.htm*,*.js,*.css,*.php :wa

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
"inoremap <up> <C-R>=pumvisible() ? "\<lt>up>" : "\<lt>C-o>gk"<Enter>
map <down> gj
"inoremap <down> <C-R>=pumvisible() ? "\<lt>down>" : "\<lt>C-o>gj"<Enter>

" Map normal mode Enter to add a new line before the current one
nmap <Enter> O<Esc>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" GUNDO
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F4> :GundoToggle<CR>

" Supertab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType='<c-x><c-o>'
let g:SuperTabMappingTabLiteral='<a-tab>'

" Neocomplcache
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_manual_completion_start_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" snippets expand key
imap  <silent><expr><TAB>  neocomplcache#plugin#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : (pumvisible() ? "\<C-e>" : "\<TAB>")
"imap  <silent><expr><TAB>  neocomplcache#plugin#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-e>"
smap  <TAB>  <RIGHT><Plug>(neocomplcache_snippets_jump)
inoremap <expr><C-e>     neocomplcache#complete_common_string(

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
set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

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
let g:easytags_resolve_links = 1
let g:easytags_cmd = '/usr/local/bin/ctags'
set tags=tags;/

" Add RebuildTags function/command
function! s:RebuildTagsFile()
  !/usr/local/bin/ctags --langmap=php:.engine.inc.module.theme.php --php-kinds=cdfi --languages=php --recurse --exclude="\.git" --totals=yes --extra=+q
endfunction
command! -nargs=0 RebuildTags call s:RebuildTagsFile()

" TAGLIST
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Compact_Format = 1
let Tlist_WinWidth = 40
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Sort_Type = 'name'
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Show_Menu = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
let Tlist_Auto_Update = 1
nnoremap <silent> <Leader>t :TlistToggle<CR>

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

" SYNTASTIC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use signs to indicate lines with errors
" only if signs are available
if has('signs')
  let g:syntastic_enable_signs = 1
endif
"let g:syntastic_enable_signs = 1

" automatically open the location list when a buffer has errors
let g:syntastic_auto_loc_list = 1

" always show warnings
let g:syntastic_quiet_warnings = 0

" ignore djangohtml
let g:syntastic_disabled_filetypes = ['htmldjango', 'txt', 'text', 'tumblr', 'css', 'html5']

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

" BUFEXPLORER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerSortBy = 'mru'
let g:bufExplorerSplitBelow = 1
let g:bufExplorerSplitRight = 1
let g:bufExplorerDefaultHelp = 0
let g:bufExplorerShowRelativePath = 1

" MINIBUFEXPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

map <Leader>m :MiniBufExplorer<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" STRIP TRAILING WHITESPACE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
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
  1
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")
  "set guifont=EspressoMono-Regular:h12            " Font family and font size.
  set guifont=Inconsolata:h14
  "set guifont=menlo:h12
  set fuoptions=maxvert,maxhorz     " fullscreen maximizes vertically AND horizontally
  set antialias                     " MacVim: smooth fonts.
  set encoding=utf-8                " Use UTF-8 everywhere.
  set guioptions-=T                 " Hide toolbar.

  "set lines=45 columns=145          " Window dimensions.
  set guioptions+=e
  set guioptions-=r                 " Don't show right scrollbar
  set guioptions-=R                 " Don't show right scrollbar
  set guioptions-=l                 " Don't show left scrollbar
  set guioptions-=L                 " Don't show left scrollbar

  "macmenu &File.New\ Tab key=<nop>
  map <D-d> :CommandT<CR>
  set transparency=5
  set formatoptions-=tc
  let macvim_hig_shift_movement = 1
  colorscheme darkspectrum

  " bind command-] to shift right
  nmap <D-]> >>
  vmap <D-]> >>
  imap <D-]> <C-O>>>

  " bind command-[ to shift left
  nmap <D-[> <<
  vmap <D-[> <<
  imap <D-[> <C-O><<
endif

