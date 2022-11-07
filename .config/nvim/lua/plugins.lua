-- Automatically install Packer plugin manager
local fn = vim.fn
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
    use 'https://github.com/neovim/nvim-lspconfig'
    use 'https://github.com/nvim-lua/plenary.nvim'
    use 'https://github.com/nvim-telescope/telescope.nvim'
    use 'https://github.com/nvim-treesitter/nvim-treesitter'

    -- Distraction-free writing
    use 'https://github.com/folke/zen-mode.nvim'

    -- Syntax highlighting
    use 'https://github.com/niklasl/vim-rdf'
    use 'https://github.com/vim-pandoc/vim-pandoc-syntax.git'
    use 'https://github.com/vito-c/jq.vim'
    use 'https://github.com/kovetskiy/sxhkd-vim'
    use 'https://github.com/ledger/vim-ledger'

    -- Inertial scrolling
    use 'https://github.com/psliwka/vim-smoothie'

    -- Sets working directory to project root
    use 'https://github.com/airblade/vim-rooter.git'

    -- Show git/svn changes
    use 'https://github.com/mhinz/vim-signify.git'

    -- Visually indicate marks
    use 'https://github.com/kshenoy/vim-signature'

    -- Automatically detect indentation
    use 'https://github.com/tpope/vim-sleuth'

    -- More sensible word motions
    use 'https://github.com/chaoren/vim-wordmotion'

    -- Auto comment lines
    use 'https://github.com/tpope/vim-commentary'

    -- Tabs for every buffer
    use 'https://github.com/ap/vim-buftabline'

    -- Browse within vim using the `lf` file manager
    use 'https://github.com/ptzz/lf.vim'
    use 'https://github.com/voldikss/vim-floaterm'

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
