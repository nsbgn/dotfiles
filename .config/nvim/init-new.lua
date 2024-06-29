-- https://github.com/nanotee/nvim-lua-guide/
-- https://toroid.org/modern-neovim
-- https://joehallenbeck.com/the-glories-of-text-files-on-using-vim-for-code-and-prose/
-- https://www.opensourceagenda.com/projects/vim-no-color-collections
-- https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887?gi=32e31ad24afb

require("lazy_config")

for key, value in pairs {
  -- Interface elements
  termguicolors = true,
  background = "light",
  title = true,
  titlestring = "%F %m",
  laststatus = 0,
  ruler = true,
  number = true,
  showcmd = false,
  showmode = false,

  -- Text handling
  textwidth = 79,
  whichwrap = "<,>,h,l,[,]", -- wrap navigation across lines
  backspace = "indent,eol,start", -- wrap backspace across lines
  autoindent = true, -- copy indentation from previous line
  expandtab = true, -- convert tabs to spaces
  tabstop = 4,
  shiftwidth = 4, -- number of characters for indentation (> and <)
  softtabstop = 4, -- tab and backspace insert and delete spaces
  joinspaces = false, -- do not put two spaces after sentence

  -- Behaviour
  clipboard = "unnamedplus",
  wildmode = "longest,list,full", -- show menu, tabcomplete to common prefix
  list = true -- visible indication for tabs & spaces
} do vim["o"][key] = value end

vim.cmd[[set formatoptions+=aw2tq]] 
