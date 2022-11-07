-- https://github.com/nanotee/nvim-lua-guide/
-- https://toroid.org/modern-neovim
-- https://joehallenbeck.com/the-glories-of-text-files-on-using-vim-for-code-and-prose/
-- https://www.opensourceagenda.com/projects/vim-no-color-collections
-- https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887?gi=32e31ad24afb
-- https://github.com/mthnglac/dotfiles

require('plugins')
for key, value in pairs {
  -- Interface elements
  background = "light",
  title = true,
  titlestring = "%F %m",
  laststatus = 0,
  ruler = true,
  number = false,
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
} do
    vim["o"][key] = value
end

vim.api.nvim_set_hl(0, "PandocAtxHeader", {
    cterm = "bold", ctermfg = "DarkMagenta" })
vim.api.nvim_set_hl(0, "PandocSetexHeader", {
    cterm = "bold", ctermfg = "DarkMagenta" })
vim.go["pandoc#syntax#conceal#use"] = 0


    -- highlight pandocAtxHeader cterm=bold ctermfg=DarkMagenta
    -- highlight pandocSetexHeader cterm=bold ctermfg=DarkMagenta
    -- let g:pandoc#syntax#conceal#use=0
