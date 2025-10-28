return {
  { 'https://github.com/yorickpeterse/vim-paper',
    enabled = true,
    init = function()
      vim.cmd.colorscheme 'paper'
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "markdownH1", { underline = true, bold = true })
      vim.api.nvim_set_hl(0, "markdownH2", { underline = true, bold = true, italic= true })
      vim.api.nvim_set_hl(0, "markdownH3", { underline = true, italic = true })
      vim.api.nvim_set_hl(0, "LeapMatch", { underline = true, bold = true })
      vim.api.nvim_set_hl(0, "LeapLabel", { bg = "yellow", underline = true, bold = true })
    end
  },
}
