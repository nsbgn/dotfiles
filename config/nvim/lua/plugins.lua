-- Automatically install Packer plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone',
        '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
    use 'https://github.com/neovim/nvim-lspconfig'
    use 'https://github.com/nvim-lua/plenary.nvim'
    use 'https://github.com/nvim-telescope/telescope.nvim'
    use 'https://github.com/nvim-treesitter/nvim-treesitter'

    -- Colorschemes without much color
    use 'https://github.com/rktjmp/lush.nvim'
    use 'https://github.com/mcchrish/zenbones.nvim'
    -- Plug 'https://github.com/preservim/vim-colors-pencil'
    -- Plug 'https://gitlab.com/yorickpeterse/vim-paper.git'
    -- Plug 'https://github.com/altercation/vim-colors-solarized'
    -- Plug 'https://github.com/morhetz/gruvbox'

    -- use 'https://github.com/liuchengxu/vim-clap'
    -- use 'https://github.com/liuchengxu/vim-which-key'
    -- use 'https://github.com/soywod/himalaya', {'rtp': 'vim'}

    -- Telescope
    use 'https://github.com/nvim-telescope/telescope.nvim'

    -- Scrolling
    -- Plug 'https://github.com/Xuyuanp/scrollbar.nvim'
    -- Plug 'https://github.com/wfxr/minimap.vim'
    -- Plug 'https://github.com/severin-lemaignan/vim-minimap'

    -- Distraction-free writing
    use 'https://github.com/junegunn/goyo.vim'
    -- Plug 'https://github.com/bilalq/lite-dfm'
    -- Plug 'https://github.com/folke/zen-mode.nvim'
    -- Plug 'https://github.com/Pocco81/TrueZen.nvim'

    -- Syntax highlighting
    use 'https://github.com/niklasl/vim-rdf'
    -- Plug 'https://github.com/plasticboy/vim-markdown'
    -- Plug 'https://github.com/tpope/vim-markdown'
    use 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    use 'https://github.com/vito-c/jq.vim'
    use 'https://github.com/kovetskiy/sxhkd-vim'
    use 'https://github.com/ledger/vim-ledger'

    -- Fuzzy finding
    -- Plug 'https://github.com/kien/ctrlp.vim'
    use 'https://github.com/junegunn/fzf'
    use 'https://github.com/junegunn/fzf.vim'
    -- https://oroques.dev/notes/neovim-init/
    -- use 'https://github.com/gfanto/fzf-lsp.nvim' nvim0.5+
    -- use 'https://github.com/ojroques/nvim-lspfuzzy' nvim0.5+
    -- For bibtex citation search, see 'https://github.com/msprev/fzf-bibtex'

    -- Inertial scrolling
    use 'https://github.com/psliwka/vim-smoothie'
    -- Plug 'https://github.com/yuttie/comfortable-motion.vim'
    -- Plug 'https://github.com/lukelbd/vim-scrollwrapped'

    -- Work with GPG-encrypted files
    --Plug 'https://github.com/jamessan/vim-gnupg.git'

    -- Sets working directory to project root
    use 'https://github.com/airblade/vim-rooter.git'

    -- Show git/svn changes
    use 'https://github.com/mhinz/vim-signify.git'
    -- Plug 'https://github.com/tpope/vim-fugitive.git'

    -- Visually indicate marks
    use 'https://github.com/kshenoy/vim-signature'

    -- Automatic alignment
    --Plug 'https://github.com/junegunn/vim-easy-align'

    -- Automatically detect indentation
    -- Plug 'https://github.com/tpope/vim-sleuth'

    -- Auto-edit parentheses
    use 'https://github.com/tpope/vim-surround'

    -- Use v* to select word, paragraph, whatever is between delimiting pairs.
    -- Not perfect since I'd like to select sentences, paragraphs
    use 'https://github.com/gorkunov/smartpairs.vim.git'
    -- Plug 'https://github.com/terryma/vim-expand-region'
    -- Maybe this one:
    -- Plug 'https://github.com/ZhiyuanLck/smart-pairs'

    -- More sensible word motions
    use 'https://github.com/chaoren/vim-wordmotion'

    -- Text exchange
    -- Plug 'https://github.com/tommcdo/vim-exchange'

    -- Moving text selections around
    -- Plug 'https://github.com/zirrostig/vim-schlepp'

    -- Auto comment lines
    use 'https://github.com/tpope/vim-commentary'

    -- Moving around
    use { 'https://github.com/phaazon/hop.nvim', branch = 'v2',
      config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }

    -- use 'https://github.com/phaazon/hop.nvim' -- includes line jumping, for
    -- neovim 0.5
    use 'https://github.com/justinmk/vim-sneak'
    -- Plug 'https://github.com/t9md/vim-smalls'

    -- Tabs for every buffer
    use 'https://github.com/ap/vim-buftabline'
    -- Plug 'https://github.com/akinsho/bufferline.nvim'
    -- Plug 'https://github.com/bling/vim-bufferline'

    -- View LSP symbols & tags
    -- Plug 'https://github.com/liuchengxu/vista.vim'

    -- Browse the undo tree
    --Plug 'https://github.com/sjl/gundo.vim'

    -- Browse within vim using the `lf` file manager
    use 'https://github.com/ptzz/lf.vim'
    use 'https://github.com/voldikss/vim-floaterm'

    -- Language server protocol
    -- use 'https://github.com/natebosch/vim-lsc'
    --, { 'tag': 'v0.4.0' }
    --Plug 'https://github.com/prabirshrestha/vim-lsp'

    -- Autocompletion (also needs `pip3 install pynvim`)
    -- Plug 'https://github.com/Shougo/deoplete.nvim', 
    --    \ { 'do': ':UpdateRemotePlugins' }

    -- Language server protocol
    --Plug 'https://github.com/autozimu/LanguageClient-neovim.git', 
    --    \ { 'branch': 'next'
    --    \ , 'do': 'bash install.sh' }

    -- Navigate symbols in the document
    --Plug 'https://github.com/liuchengxu/vista.vim'

    -- Manage tag files
    -- Plug 'https://github.com/ludovicchabant/vim-gutentags'

    -- Manage Pandoc markdown files
    --Plug 'https://github.com/vim-pandoc/vim-pandoc.git'

    -- https://github.com/alok/notational-fzf-vim

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
