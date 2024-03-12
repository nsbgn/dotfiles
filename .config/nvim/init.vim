lua require('plugins')
lua require('lsp')
lua require('splits')

set termguicolors
set background=light
colorscheme peachpuff

hi Normal guifg=black ctermbg=NONE guibg=NONE ctermbg=NONE guibg=NONE
hi Visual guifg=#cccccc guibg=#333333

hi Comment gui=italic guifg=gray
hi Special gui=NONE guifg=gray
hi Statement gui=bold guifg=black
hi Constant gui=italic guifg=darkgreen
hi Identifier gui=NONE guifg=darkred
hi Type gui=italic guifg=black
hi PreProc gui=bold guifg=black
hi Todo gui=underline,bold
hi MatchParen gui=bold guifg=black guibg=lightgray

hi DiffAdd guifg=darkgreen guibg=NONE
hi DiffChange guifg=gray guibg=NONE
hi DiffDelete guifg=darkred guibg=NONE

hi NonText guifg=#888888

hi LeapBackdrop guifg=gray
hi LeapLabelPrimary gui=bold,italic guibg=white
hi LeapMatch guifg=black guibg=white
hi ScrollView guifg=red guibg=black

hi markdownH1 gui=underline,bold
hi markdownH2 gui=underline,bold,italic
hi markdownH3 gui=underline,italic
hi markdownItalic gui=italic
hi markdownItalicDelimiter gui=italic guifg=gray
hi markdownBold gui=bold
hi markdownBoldDelimiter gui=bold guifg=gray
hi markdownCode guibg=#eeeeee
hi markdownAutomaticLink gui=underline
hi yamlBlockMappingKey gui=bold guifg=black
hi yamlDocumentStart gui=none guifg=gray
hi pythonBuiltin gui=none guifg=black
hi pythonFunction gui=bold guifg=darkred
" set fillchars+=vert:*
" set fillchars+=eob:\  " turn off tildes at the end of buffers

" Show file in window title
set title
set titlestring=🗒️\ %f\ %m
" 
"%{len(getbufinfo({'buflisted':1}))}

" Stop annoying window from popping up
map q: :q
nnoremap ; :

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
nmap <Tab> :set number!<CR>

" Once available in stable
" cf. https://github.com/neovim/neovim/pull/23320
set smoothscroll

set scrolloff=5
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

"" Show visible indication for tabs & spaces
set list
set listchars=tab:⇥\ ,trail:⸱,nbsp:⎵ "⸱

" Disable swapfile
set noswapfile

" Open in browser with gx
nmap gx <Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>

" noremap <silent> <space> :b#<CR>

" Always move by screen lines, not real lines. Wait, this makes things go slwo
" for some reason
"noremap <silent> k gk
"noremap <silent> j gj
"noremap <silent> down gk
"noremap <silent> up gj

" vmap <silent> ' S"

 set formatoptions+=aw2tq

" formatoptions:
" - a sets our text to automatically wrap when it reaches textwidth
" - w defines paragraphs as being separated by a blank line
" - t sets text to be automatically formatted to textwidth
" - q allows the gq command to automatically reformat text


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
    autocmd FileType tex setlocal formatoptions=w2qj
    autocmd FileType tex setlocal wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=no
augroup END

" func! MScroll()
"     let l:done=0
"     let l:n = -1
"     let l:w0 = line("w0")
"     let l:last = line("$")
"     while done!=1
"         let l:g = getchar()
"         if l:g != "\<LeftDrag>"
"             let done = 1
"         else
"             if l:n == -1
"                 let l:n = v:mouse_lnum
"                 let l:fln = v:mouse_lnum
"             else
"                 let l:new = l:w0 - v:mouse_lnum + l:n
"                 if l:new<1
"                     let l:new = 1
"                 endif

"                 let l:diff = -v:mouse_lnum + l:n
"                 let l:nd = line("w$")
"                 if l:nd+l:diff>l:last
"                     let l:new = l:last - winheight(0) + 1
"                     if l:new<1
"                         let l:new = 1
"                     endif
"                 end

"                 let l:wn = "normal ".string(l:new)."zt"
"                 if (l:n != v:mouse_lnum)
"                     exec(l:wn)
"                     redraw
"                 endif
"                 let l:w0 = line("w0")
"                 let l:n = v:mouse_lnum + l:diff
"             endif
"         endif
"     endwhile
"     :call cursor(v:mouse_lnum,v:mouse_col)
" endfunc
" set mouse=a
" noremap <silent> <LeftMouse> :call MScroll()<CR>
" noremap <LeftRelease> <Nop>
" noremap <LeftDrag> <Nop>
