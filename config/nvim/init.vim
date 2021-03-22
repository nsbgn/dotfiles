" Plugins
call plug#begin(stdpath('data') . '/plugged')

    " Color schemes
    "Plug 'https://github.com/chriskempson/base16-vim'

    " Syntax highlighting
    Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    Plug 'https://github.com/vito-c/jq.vim'
    Plug 'https://github.com/kovetskiy/sxhkd-vim'
    Plug 'https://github.com/ledger/vim-ledger', { 'tag': 'v1.2.0' }

    " Work with GPG-encrypted files
    Plug 'https://github.com/jamessan/vim-gnupg.git'

    " Sets working directory to project root
    Plug 'https://github.com/airblade/vim-rooter.git'

    " Show git/svn changes
    Plug 'https://github.com/mhinz/vim-signify.git'
    " Plug 'https://github.com/tpope/vim-fugitive.git'

    " Buffer tabs
    Plug 'https://github.com/ap/vim-buftabline'

    " Browse the undo tree
    Plug 'https://github.com/sjl/gundo.vim'

    " Browse within vim using the `lf` file manager
    Plug 'https://github.com/ptzz/lf.vim'
    Plug 'https://github.com/rbgrouleff/bclose.vim'
    Plug 'voldikss/vim-floaterm'

    " Language server protocol
    Plug 'https://github.com/natebosch/vim-lsc'
    "Plug 'https://github.com/prabirshrestha/vim-lsp'

    " Autocompletion (also needs `pip3 install pynvim`)
    " Plug 'https://github.com/Shougo/deoplete.nvim', 
    "    \ { 'do': ':UpdateRemotePlugins' }

    " Language server protocol
    "Plug 'https://github.com/autozimu/LanguageClient-neovim.git', 
    "    \ { 'branch': 'next'
    "    \ , 'do': 'bash install.sh' }

    " Floating windows for previews in nvim >= 0.4
    "Plug 'https://github.com/ncm2/float-preview.nvim'

    " Navigate symbols in the document
    "Plug 'https://github.com/liuchengxu/vista.vim'

    " Manage Pandoc files
    "Plug 'https://github.com/vim-pandoc/vim-pandoc.git'

    " Distraction-free writing
    "Plug 'https://github.com/junegunn/goyo.vim'

call plug#end()

" Show file in window title
set title
set titlestring=%F\ %m

" Check if a plugin is loaded
function! PlugLoaded(name)
    return (
        \ has_key(g:plugs, a:name) &&
        \ stridx(&rtp, substitute(g:plugs[a:name].dir,"/$","","")) >= 0)
endfunction

" Show the mode in the command bar, don't show status bar, etc
set showmode
set laststatus=0
set noshowcmd

" Enable mouse support
set mouse=a

" Width is 79 characters by default
set textwidth=79

" Show column number, line number and relative position in status line
set ruler

" Show line numbers in left margin
"set number
set nonumber

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

" Show visible indication for tabs
set list

" Turn off background on the sign column (except when there are signs)  
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE

"set background=dark
"let base16colorspace=256
"colorscheme base16-default

let g:netrw_browsex_viewer = "firefox"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific configuration

if has("autocmd")




    autocmd FileType lua setlocal tabstop=2 softtabstop=2 shiftwidth=2

    "au TermEnter * setlocal nonumber
    "au TermLeave * setlocal number

    au BufRead /tmp/mutt-* set tw=72

    augroup pandoc_syntax
        au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
        autocmd FileType markdown.pandoc setlocal conceallevel=0
        autocmd FileType markdown.pandoc setlocal textwidth=78
        autocmd FileType markdown.pandoc setlocal formatoptions+=a formatoptions+=w
    augroup END

    augroup latex
    "   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
    "   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
        au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
        autocmd FileType tex setlocal conceallevel=0
        "autocmd FileType tex setlocal textwidth=78
        "autocmd FileType tex setlocal formatoptions+=a formatoptions+=w
        autocmd FileType tex setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 tabstop=2 shiftwidth=2 softtabstop=2

        autocmd FileType tex noremap <buffer> <silent> k gk
        autocmd FileType tex noremap <buffer> <silent> j gj
        autocmd FileType tex noremap <buffer> <silent> 0 g0
        autocmd FileType tex noremap <buffer> <silent> $ g$
    augroup END

    augroup haskell
        au! BufNewFile,BufFilePre,BufRead *.hs set filetype=haskell
        autocmd FileType haskell setlocal tabstop=2
        autocmd FileType haskell setlocal shiftwidth=2
        autocmd FileType haskell setlocal softtabstop=2
    augroup END

endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration

if PlugLoaded('vim-pandoc')
    let g:pandoc#modules#enabled = ['bibliographies', 'completion', 'toc', 'hypertext']
    call deoplete#custom#var('omni', 'input_patterns', {
        \ 'pandoc': '@'
        \})
endif

if PlugLoaded('vim-buftabline')
    " Show buffers in tabline, but only if there is more than one
    let g:buftabline_show = 1
endif

if PlugLoaded('lf.vim')
    " Unmap default lf key
    let g:lf_map_keys = 0

    " Unmap e, i and w in lf within vim to make sure we only use it to open a file
    " and not to start other programs within the lf session
    let g:lf_command_override = 'lf -command "map e; map i; map w"'
endif

if PlugLoaded('float-preview.nvim')
    set completeopt-=preview " extra info will now be shown in floating window
    let g:float_preview#docked = 1
    let g:float_preview#max_height = 50
    "let g:float_preview#max_width = 80
endif

if PlugLoaded('deoplete.nvim')

    "let g:deoplete#enable_at_startup = 1
    nmap <F7> :call deoplete#toggle()<CR>

    set completeopt+=menuone " show completions even if there is only one option
    set completeopt+=noinsert " don't auto-insert until selection
    set completeopt+=noselect " don't autoselect a match
    set shortmess+=c " hide 'match x of y' message

    " Set sources for autocompletion
    " Default available sources: around, buffer, file, member, omni
    call deoplete#custom#option('sources', 
        \ { '_': ['file']
        \ ,'haskell': ['file','LanguageClient','ale','lsp','ghc']
        \ , 'python': ['file','LanguageClient','ale','lsp']
        \ , 'rust': ['file','LanguageClient','ale','lsp']
        \ , 'pandoc.markdown': ['file','omni']
        \ , 'markdown': ['file','omni'] })

    " Close preview when completion is done
    " autocmd CompleteDone * pclose
    " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    " Somehow I want to get documentation as I select autocompletions.
    " See issue at https://github.com/autozimu/LanguageClient-neovim/issues/875
    " Also - https://github.com/wincent/wincent/issues/78
endif


if PlugLoaded('LanguageClient-neovim')
    " Required for operations modifying multiple buffers like rename.
    set hidden

    " Language server protocol servers
    let g:LanguageClient_serverCommands = {
        \ 'haskell': ['hie-wrapper'],
        \ 'python': ['pyls'], 
        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'], 
        \ }
endif

if PlugLoaded('vim-lsc')
    set shortmess-=F " avoid suppressing errors
    let g:lsc_server_commands = {'python': 'pyls'}
    let g:lsc_enable_autocomplete = v:false
    let g:lsc_auto_map = {
        \ 'GoToDefinition': '<C-]>',
        \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
        \ 'FindReferences': 'gr',
        \ 'NextReference': '<C-n>',
        \ 'PreviousReference': '<C-p>',
        \ 'FindImplementations': 'gI',
        \ 'FindCodeActions': 'ga',
        \ 'Rename': 'gR',
        \ 'ShowHover': v:true,
        \ 'DocumentSymbol': 'go',
        \ 'WorkspaceSymbol': 'gS',
        \ 'SignatureHelp': 'gm',
        \ 'Completion': 'completefunc',
        \}
endif

if PlugLoaded('vim-lsp')
    if executable('pyls')
        " pip install python-language-server
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'allowlist': ['python'],
            \ })
    endif

    function! s:on_lsp_buffer_enabled() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes
        if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> <leader>rn <plug>(lsp-rename)
        nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
        nmap <buffer> K <plug>(lsp-hover)

        let g:lsp_format_sync_timeout = 1000
        autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
        
        " refer to doc to add more commands
    endfunction

    augroup lsp_install
        au!
        " call s:on_lsp_buffer_enabled only for languages that has the server registered.
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END
endif

if PlugLoaded('vim-rooter')
    let g:rooter_silent_chdir = 1
    " this xcwd work for non project files but not for project files...
    let g:rooter_change_directory_for_non_project_files = 'current'
    let g:rooter_resolve_links = 1
    let g:rooter_patterns = ['.git', 'Makefile']
endif

if PlugLoaded('LanguageClient-neovim')
    " Language
    nnoremap <F6> :call LanguageClient_contextMenu()<CR>
    " rename current symbol:
    nmap zr :call LanguageClient#textDocument_rename()<CR>
    " show hover information (documentation etc):
    nmap zi :call LanguageClient#textDocument_hover()<CR>
    " go to definition of current symbol:
    nmap zd :call LanguageClient#textDocument_definition()<CR>
    " list where current symbol is referenced:
    nmap zk :call LanguageClient#textDocument_references()<CR>
    " list symbols in the document:
    nmap zs :call LanguageClient#textDocument_documentSymbol()<CR>
    " suggestions for actions to take:
    nmap za :call LanguageClient#textDocument_codeAction()<CR>
endif

if PlugLoaded('gundo.vim')
    " View undo tree
    nnoremap <F5> :GundoToggle<CR>
endif


nmap ; :

" Navigating buffers
" close buffer:
nmap td :bd<CR>
" force close buffer:
nmap tD :bd!<CR>
" open new file:
map tt :Lf<CR>
" next buffer:
nmap . :bnext<CR>
" previous buffer:
nmap , :bprevious<CR>

" Insert lines
nmap = o<Esc>79a=<Esc>0
nmap - o<Esc>79a-<Esc>0
nmap ~ o<Esc>79a~<Esc>0
