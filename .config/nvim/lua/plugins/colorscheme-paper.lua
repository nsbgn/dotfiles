return {
  { 'https://github.com/yorickpeterse/vim-paper',
    enabled = true,
    init = function()
      vim.cmd.colorscheme 'paper'
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "markdownH1", { underdouble = true, bold = true })
      vim.api.nvim_set_hl(0, "markdownH2", { underline = true, bold = true, italic= true })
      vim.api.nvim_set_hl(0, "markdownH3", { underdotted = true })
      vim.api.nvim_set_hl(0, "markdownH4", { underdotted = true, italic = true })
      vim.api.nvim_set_hl(0, "LeapMatch", { underline = true, bold = true })
      vim.api.nvim_set_hl(0, "LeapLabel", { bg = "yellow", underline = true, bold = true })

      vim.api.nvim_set_hl(0, "FlashMatch", { bg = "#f2de91", undercurl = true })
      vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#f2de91", underline = true })
      vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#f2de91", bold = true })
    end
  },
}
