lua require('plugins')
lua require('lsp')

set fillchars+=eob:\  " turn off tildes at the end of buffers

highlight Pmenu ctermfg=white ctermbg=black

" Vertical splits are more subtle
highlight VertSplit cterm=NONE ctermfg=gray
set fillchars+=vert:▏

" Blinking cursor
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" Show file in window title
set title
set titlestring=%f\ %m
"%{len(getbufinfo({'buflisted':1}))}

" Stop annoying window from popping up
map q: :q

" cursor makes it obvious what mode I am in anyway
set noshowmode

" Don't show status bar, etc
set laststatus=0
set noshowcmd

" Enable mouse support
set mouse=a

" Width is 79 characters by default
set textwidth=79

" Show column number, line number and relative position in status line
set ruler

" Show line numbers in left margin
set nonumber
nmap <Tab> :set number! relativenumber!<CR>

set signcolumn=yes

" Get rid of fileinfo in command line
"set shortmess=F

" Indentation behaviour
set autoindent " Copy indentation from previous line
set expandtab " Convert tabs to spaces
set tabstop=4
set shiftwidth=4 " Number of characters for indentation (> and <)
set softtabstop=4 " Tab and backspace insert and delete correct number of spaces

" Do not automatically put two spaces after a sentence
set nojoinspaces

" Backspace over indentations
set backspace=indent,eol,start

" Move to previous/next line when pressing left/right at beginning/end
set whichwrap=<,>,h,l,[,]

" Show completion menu and, on tab, complete to the longest common command
set wildmenu
set wildmode=longest,list,full

" Copy to system clipboard by default
set clipboard=unnamedplus

" Show visible indication for tabs & spaces
set list
set listchars=tab:⇌\ ,trail:⸱,nbsp:⎵ "⸱

" Open in browser with gx
nmap gx <Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>

noremap <silent> <space> :b#<CR>

" Always move by screen lines, not real lines
noremap <silent> k gk
noremap <silent> j gj

vmap <silent> ' S"

set formatoptions+=aw2tq

" formatoptions:
" - a sets our text to automatically wrap when it reaches textwidth
" - w defines paragraphs as being separated by a blank line
" - t sets text to be automatically formatted to textwidth
" - q allows the gq command to automatically reformat text

" autocmd VimEnter *.md,*.tex nested :ZenMode
autocmd VimEnter * nested :ZenMode

augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.mail set filetype=markdown.pandoc
    autocmd FileType markdown.pandoc setlocal conceallevel=0 formatoptions+=aw2tq wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
augroup END

augroup latex
"   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
"   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
"   https://stackoverflow.com/questions/7053550/disable-all-auto-indentation-in-vim
    au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
    autocmd FileType tex setlocal conceallevel=0
    autocmd FileType tex setlocal formatoptions+=aw2tq
    autocmd FileType tex setlocal wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=no
augroup END

nnoremap ; :

" https://vi.stackexchange.com/questions/18454/how-to-know-which-highlighting-group-is-used-for-the-background-of-a-word
command SynID  echo synIDattr(synID(line("."), col("."), 1), "name")

func! MScroll()
    let l:done=0
    let l:n = -1
    let l:w0 = line("w0")
    let l:last = line("$")
    while done!=1
        let l:g = getchar()
        if l:g != "\<LeftDrag>"
            let done = 1
        else
            if l:n == -1
                let l:n = v:mouse_lnum
                let l:fln = v:mouse_lnum
            else
                let l:new = l:w0 - v:mouse_lnum + l:n
                if l:new<1
                    let l:new = 1
                endif

                let l:diff = -v:mouse_lnum + l:n
                let l:nd = line("w$")
                if l:nd+l:diff>l:last
                    let l:new = l:last - winheight(0) + 1
                    if l:new<1
                        let l:new = 1
                    endif
                end

                let l:wn = "normal ".string(l:new)."zt"
                if (l:n != v:mouse_lnum)
                    exec(l:wn)
                    redraw
                endif
                let l:w0 = line("w0")
                let l:n = v:mouse_lnum + l:diff
            endif
        endif
    endwhile
    :call cursor(v:mouse_lnum,v:mouse_col)
endfunc
set mouse=a
noremap <silent> <LeftMouse> :call MScroll()<CR>
noremap <LeftRelease> <Nop>
noremap <LeftDrag> <Nop>
