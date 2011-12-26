
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

