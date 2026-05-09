return {
  -- cf. <https://vi.stackexchange.com/questions/45129/is-neovim-able-to-use-terminal-profile-colors>
  -- cf. <https://jeffkreeftmeijer.com/vim-16-color/>
  -- cf. <https://terminalcolors.com/themes/gruvbox/light/>
  { 'https://github.com/jeffkreeftmeijer/vim-dim',
    enabled = true,
    init = function()
      vim.o.termguicolors = false
      vim.cmd.colorscheme 'dim'
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "markdownH1", { underdouble = true, bold = true })
      vim.api.nvim_set_hl(0, "markdownH2", { underline = true, bold = true, italic = true })
      vim.api.nvim_set_hl(0, "markdownH3", { underdotted = true, italic = true })
      vim.api.nvim_set_hl(0, "markdownH4", { underdotted = true })
      vim.api.nvim_set_hl(0, "LeapMatch", { underline = true, bold = true })
      vim.api.nvim_set_hl(0, "LeapLabel", { bg = "yellow", underline = true, bold = true })

      vim.api.nvim_set_hl(0, "FlashMatch", { bg = "#f2de91", undercurl = true })
      vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#f2de91", underline = true })
      vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#f2de91", bold = true })
    end
  },
}
