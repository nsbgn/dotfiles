vim.pack.add({
  { src = 'https://github.com/ellisonleao/gruvbox.nvim', version = '2.0.0' },
  -- { src = 'https://github.com/sainnhe/gruvbox-material', version = 'v1.2.5' },
})

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard",
  palette_overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd.colorscheme("gruvbox")

-- vim.g.gruvbox_material_foreground = 'original'
-- vim.g.gruvbox_material_background = 'soft'
-- vim.g.gruvbox_material_better_performance = 1
-- vim.g.gruvbox_material_enable_bold = 1
-- vim.g.gruvbox_material_transparent_background = 1
-- vim.g.gruvbox_material_ui_contrast = 'high'
-- vim.cmd.colorscheme "gruvbox-material"

vim.api.nvim_set_hl(0, "@markup.heading.1", { underdouble = true, bold = true })
vim.api.nvim_set_hl(0, "@markup.heading.2", { underline = true, bold = true, italic = true })
vim.api.nvim_set_hl(0, "@markup.heading.3", { underdotted = true, italic = true })
vim.api.nvim_set_hl(0, "@markup.heading.4", { underdotted = true })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
