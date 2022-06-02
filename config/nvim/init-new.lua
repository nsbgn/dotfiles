-- Automatically install plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone',
        '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887?gi=32e31ad24afb

return require('packer').startup(function(use)
    -- My plugins here
    use 'https://github.com/neovim/nvim-lspconfig'
    use 'https://github.com/nvim-telescope/telescope.nvim'

    use 'https://github.com/nvim-treesitter/nvim-treesitter'

    -- Automatically set up configuration after cloning packer.nvim
    if packer_bootstrap then
        require('packer').sync()
    end
end)
