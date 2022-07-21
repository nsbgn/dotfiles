" Install vim-plug if not available
" <https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation>
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin(stdpath('data') . '/plugged')

    Plug 'https://github.com/neovim/nvim-lspconfig'

    " Colorschemes without much color
    " Plug 'https://github.com/rktjmp/lush.nvim'
    " Plug 'https://github.com/mcchrish/zenbones.nvim'
    " Plug 'https://github.com/preservim/vim-colors-pencil'
    " Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
    " Plug 'https://github.com/altercation/vim-colors-solarized'
    " Plug 'https://github.com/morhetz/gruvbox'

    " Plug 'https://github.com/liuchengxu/vim-clap'
    " Plug 'https://github.com/liuchengxu/vim-which-key'

    " Email
    " Plug 'https://github.com/soywod/himalaya', {'rtp': 'vim'}

    " Telescope
    Plug 'https://github.com/nvim-lua/plenary.nvim'
    Plug 'https://github.com/nvim-telescope/telescope.nvim'

    " Distraction-free writing
    Plug 'https://github.com/junegunn/goyo.vim'
    " Plug 'https://github.com/folke/zen-mode.nvim'
    " Plug 'https://github.com/Pocco81/TrueZen.nvim'

    " Syntax highlighting
    Plug 'https://github.com/niklasl/vim-rdf'
    Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    Plug 'https://github.com/vito-c/jq.vim'
    Plug 'https://github.com/kovetskiy/sxhkd-vim'
    Plug 'https://github.com/ledger/vim-ledger', { 'tag': 'v1.2.0' }

    " Fuzzy finding
    " Plug 'https://github.com/kien/ctrlp.vim'
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'
    " Plug 'https://github.com/gfanto/fzf-lsp.nvim'
    " Plug 'https://github.com/ojroques/nvim-lspfuzzy'

    " Inertial scrolling
    Plug 'https://github.com/psliwka/vim-smoothie'
    " Plug 'https://github.com/yuttie/comfortable-motion.vim'
    " Plug 'https://github.com/lukelbd/vim-scrollwrapped'

    " Work with GPG-encrypted files
    "Plug 'https://github.com/jamessan/vim-gnupg.git'

    " Sets working directory to project root
    Plug 'https://github.com/airblade/vim-rooter.git'

    " Show git/svn changes
    Plug 'https://github.com/mhinz/vim-signify.git'

    " Visually indicate marks
    Plug 'https://github.com/kshenoy/vim-signature'

    " Automatic alignment
    " Plug 'https://github.com/junegunn/vim-easy-align'

    " Automatically detect indentation
    " Plug 'https://github.com/tpope/vim-sleuth'

    " Auto-edit parentheses
    Plug 'https://github.com/tpope/vim-surround'

    " Use v* to select word, paragraph, whatever is between delimiting pairs.
    " Not perfect since I'd like to select sentences, paragraphs
    Plug 'https://github.com/gorkunov/smartpairs.vim.git'
    " Plug 'https://github.com/terryma/vim-expand-region'
    " Plug 'https://github.com/ZhiyuanLck/smart-pairs'

    " Text exchange
    " Plug 'https://github.com/tommcdo/vim-exchange'

    " Moving text selections around
    " Plug 'https://github.com/zirrostig/vim-schlepp'

    " Auto comment lines
    Plug 'https://github.com/tpope/vim-commentary'

    " More sensible word motions
    Plug 'https://github.com/chaoren/vim-wordmotion'

    " Moving around
    Plug 'https://github.com/phaazon/hop.nvim'
    Plug 'https://github.com/justinmk/vim-sneak'

    " Tabs for every buffer
    Plug 'https://github.com/ap/vim-buftabline'
    " Plug 'https://github.com/akinsho/bufferline.nvim'
    " Plug 'https://github.com/bling/vim-bufferline'

    " View LSP symbols & tags
    " Plug 'https://github.com/liuchengxu/vista.vim'

    " Browse the undo tree
    "Plug 'https://github.com/sjl/gundo.vim'

    " Browse within vim using the `lf` file manager
    Plug 'https://github.com/ptzz/lf.vim'
    Plug 'https://github.com/voldikss/vim-floaterm'

    " Language server protocol
    " Plug 'https://github.com/natebosch/vim-lsc'
    ", { 'tag': 'v0.4.0' }

    " Manage tag files
    " Plug 'https://github.com/ludovicchabant/vim-gutentags'
    "
    "
    "-- Show context while editing
    Plug 'https://github.com/romgrk/nvim-treesitter-context'

call plug#end()

" COLOR SCHEMES

" set termguicolors
set background=light
" let g:zenwritten_diagnostic_underline_text=v:true
" let g:zenwritten_transparent_background=v:true
" colorscheme zenwritten
" colorscheme pencil

" let g:gruvbox_contrast_light="hard"
" let g:gruvbox_sign_column="bg0"
" colorscheme gruvbox

" Turn off background to take on same bg as my terminal
highlight Normal guibg=NONE ctermbg=NONE

" Subtle tildes at the end of the buffer
" highlight EndOfBuffer ctermfg=gray
set fillchars+=eob:\  " turn off tildes

highlight Pmenu ctermfg=white ctermbg=black

" Vertical splits are more subtle
highlight VertSplit cterm=NONE ctermfg=gray
set fillchars+=vert:▏
"┆▕▁│▁▏

" Blinking cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

" Show file in window title
set title
set titlestring=%F\ %m

" Check if a plugin is loaded
function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir,"/$","","")) >= 0)
endfunction

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
nmap <Tab> :set number!<CR>
"set number! relativenumber!


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

" Open in browser with gx
nmap gx <Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>

" Always move by screen lines, not real lines
noremap <silent> k gk
noremap <silent> j gj


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific configuration

if has("autocmd")
    "au TermEnter * setlocal nonumber
    "au TermLeave * setlocal number

    " formatoptions:
    " - a sets our text to automatically wrap when it reaches textwidth
    " - w defines paragraphs as being separated by a blank line
    " - t sets text to be automatically formatted to textwidth
    " - q allows the gq command to automatically reformat text

    augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
        autocmd FileType markdown.pandoc setlocal conceallevel=0 formatoptions+=aw2tq wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
    augroup END

    augroup latex
    "   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
    "   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
        au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
        autocmd FileType tex setlocal conceallevel=0
        autocmd FileType tex setlocal formatoptions+=aw2tq
        autocmd FileType tex setlocal wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
    augroup END

    augroup haskell
        au! BufNewFile,BufFilePre,BufRead *.hs set filetype=haskell
        autocmd FileType haskell setlocal tabstop=2
        autocmd FileType haskell setlocal shiftwidth=2
        autocmd FileType haskell setlocal softtabstop=2
    augroup END

    augroup lua
        au! BufNewFile,BufFilePre,BufRead *.lua set filetype=lua
        autocmd FileType lua setlocal tabstop=2 shiftwidth=2 softtabstop=2
    augroup END


endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration

if PlugLoaded('vim-markdown')
    let g:vim_markdown_folding_disabled=1
    let g:vim_markdown_conceal=0
    let g:tex_conceal = ""
    let g:vim_markdown_math = 1
    let g:vim_markdown_frontmatter = 1
endif

if PlugLoaded('vim-pandoc-syntax')
    highlight pandocAtxHeader cterm=bold ctermfg=DarkMagenta
    highlight pandocSetexHeader cterm=bold ctermfg=DarkMagenta
    let g:pandoc#syntax#conceal#use=0
endif

highlight htmlH1 cterm=bold ctermfg=DarkMagenta

if PlugLoaded('lf.vim')
    " Unmap default lf key
    let g:lf_map_keys = 0

    " Unmap e, i and w in lf within vim to make sure we only use it to open a file
    " and not to start other programs within the lf session
    let g:lf_command_override = 'lf -command "map e; map i; map w"'
endif

"if PlugLoaded('float-preview.nvim')
"    set completeopt-=preview " extra info will now be shown in floating window
"    let g:float_preview#docked = 1
"    let g:float_preview#max_height = 50
"    "let g:float_preview#max_width = 80
"endif

" if PlugLoaded('vim-lsc')
"     set shortmess-=F " avoid suppressing errors
"     let g:lsc_server_commands = {
"         \ 'python': 'pyls',
"         \ 'markdown': ['unified-language-server', '--parser=remark-parse', '--stdio'],
"         \}
"     let g:lsc_enable_autocomplete = v:false
"     let g:lsc_auto_map = {
"         \ 'GoToDefinition': '<C-]>',
"         \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
"         \ 'FindReferences': 'gr',
"         \ 'NextReference': '<C-n>',
"         \ 'PreviousReference': '<C-p>',
"         \ 'FindImplementations': 'gI',
"         \ 'FindCodeActions': 'ga',
"         \ 'Rename': 'gR',
"         \ 'ShowHover': v:true,
"         \ 'DocumentSymbol': 'go',
"         \ 'WorkspaceSymbol': 'gS',
"         \ 'SignatureHelp': 'gm',
"         \ 'Completion': 'completefunc',
"         \}
"     highlight lscDiagnosticError ctermfg=black ctermbg=DarkRed
" endif

" Language servers
lua require('lsp')


if PlugLoaded('vim-rooter')
    let g:rooter_silent_chdir = 1
    " this xcwd work for non project files but not for project files...
    let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_resolve_links = 1
    let g:rooter_patterns = ['.git', 'Makefile']
endif

if PlugLoaded('vim-signify')
    set signcolumn=auto
    highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE
    highlight SignifySignAdd ctermfg=Green cterm=NONE
    highlight SignifySignDelete ctermfg=DarkRed cterm=NONE
    highlight SignifySignChange ctermfg=Magenta cterm=NONE
    " See also https://www.fileformat.info/info/unicode/block/dingbats/utf8test.htm
    let g:signify_sign_add               = '✚' " '●' " nf:  / unifont: ⊞⊕
    let g:signify_sign_delete            = '✖' " '●' " nf:  / unifont: ⊟⊖
    let g:signify_sign_delete_first_line = '●' " '●' " nf:  / unifont: ⊠⊡⊗⊚⊘⊙⊜⊝
    let g:signify_sign_change            = '✱' " '●' " nf: פֿ / unifont: ⊛⊙
endif

if PlugLoaded('vim-sneak')
    set ignorecase
    let g:sneak#use_ic_scs = 1
    let g:sneak#absolute_dir = 1
    let g:sneak#s_next = 1
    let g:sneak#target_labels = "asdfhjklqwertyuiopzxcvbnm"
    map f <Plug>Sneak_f
    map F <Plug>Sneak_F
endif

if PlugLoaded('smartpairs.vim')
    let g:smartpairs_start_from_word = 1
endif

if PlugLoaded('vim-expand-region')
    vmap v <Plug>(expand_region_expand)
    vmap <C-v> <Plug>(expand_region_shrink)
endif

if PlugLoaded('goyo.vim')
    let g:goyo_width = 80
    let g:goyo_height = "100%"
    let g:goyo_linenr = 0

    " Auto set Goyo for Markdown files
    " <https://github.com/junegunn/goyo.vim/issues/36>
    " {
    function! s:auto_goyo()
      if &ft == 'pandoc.markdown'
        Goyo 80
      elseif exists('#goyo')
        let bufnr = bufnr('%')
        Goyo!
        execute 'b '.bufnr
      endif
    endfunction

    augroup goyo_markdown
      autocmd!
      autocmd BufEnter,BufNewFile,BufRead * call s:auto_goyo()
    augroup END
    " }

    " Use :q to quit
    " <https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active>
    " {
    function! s:goyo_enter()
      let b:quitting = 0
      let b:quitting_bang = 0
      autocmd QuitPre <buffer> let b:quitting = 1
      cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    endfunction
    function! s:goyo_leave()
      " Quit Vim if this is the only remaining buffer
      if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
          qa!
        else
          qa
        endif
      endif
    endfunction
    autocmd! User GoyoEnter call <SID>goyo_enter()
    autocmd! User GoyoLeave call <SID>goyo_leave()
    " }
endif

if PlugLoaded('hop.nvim')
    lua require'hop'.setup()
    nmap <C-space> :HopVertical<CR>
    nmap <space> :HopWord<CR>
endif

if PlugLoaded('fzf.vim')
    nmap gj :Files<CR>
    nmap gb :Buffers<CR>
    nmap gl :Lines<CR>
    nmap gm :Marks<CR>
endif

if PlugLoaded('vim-buftabline')
    " Show buffers in tabline, but only if there is more than one
    let g:buftabline_show = 1

    " Reduce conflict with goyo
    " See https://github.com/ap/vim-buftabline/issues/64
    if PlugLoaded('goyo.vim')
        autocmd! User GoyoEnter nested call <SID>GoyoEnter()
        autocmd! User GoyoLeave nested call <SID>GoyoLeave()
        function! s:GoyoEnter() "
            set showtabline=0
        endfunction "
        function! s:GoyoLeave() "
            set showtabline=1
            :call buftabline#update(0)
        endfunction "
    endif
endif

nnoremap ; :

" Navigating buffers
" close buffer, see:
" - https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
" - https://github.com/qpkorr/vim-bufkill
nmap td :bp<bar>sp<bar>bn<bar>bd<CR>
" force close buffer:
nmap tD :bd!<CR>
" open new file:
nmap tt :Lf<CR>
" next buffer:
nmap . :bnext<CR>
" previous buffer:
nmap , :bprevious<CR>

" Turn hard wrapped text into soft wrapped.
" This command will join all lines within a range that are not separated
" by empty lines. Automatic word wrap must be off (set fo-=a).
" Useful if you need to copy and paste into a word processor.
" source: https://gist.github.com/alols/1420072
command! -range=% SoftWrap
            \ <line2>put _ |
            \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

set shortmess+=F  " to get rid of the file name displayed in the command line bar

" Use a gui instead?
" https://www.vim.org/scripts/script.php?script_id=3141
" func! MScroll()
"   let l:done=0
"   let l:n = -1
"   let l:w0 = line("w0")
"   let l:last = line("$")
"   while done!=1
"     let l:g = getchar()
"     if l:g != "\<LeftDrag>"
"       let done = 1
"     else
"       if l:n == -1
"         let l:n = v:mouse_lnum
"         let l:fln = v:mouse_lnum
"       else
"         let l:new = l:w0 - v:mouse_lnum + l:n
"         if l:new<1
"           let l:new = 1
"         endif

"         let l:diff = -v:mouse_lnum + l:n
"         let l:nd = line("w$")
"         if l:nd+l:diff>l:last
"           let l:new = l:last - winheight(0) + 1
"           if l:new<1
"             let l:new = 1
"           endif
"         end

"         let l:wn = "normal ".string(l:new)."zt"
"         if (l:n != v:mouse_lnum)
"           exec(l:wn)
"           redraw
"         endif
"         let l:w0 = line("w0")
"         let l:n = v:mouse_lnum + l:diff
"       endif
"     endif
"   endwhile
"   :call cursor(v:mouse_lnum,v:mouse_col)
" endfunc
" :set mouse=a
" :noremap <silent> <LeftMouse> :call MScroll()<CR>
" :noremap <LeftRelease> <Nop>
" :noremap <LeftDrag> <Nop>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
    \ endif
