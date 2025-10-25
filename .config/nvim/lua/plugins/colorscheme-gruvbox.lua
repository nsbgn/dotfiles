return {
  { "https://github.com/ellisonleao/gruvbox.nvim",
    priority = 1000,
    enabled = false,
    config = true,
    init = function()
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
        overrides = {
          -- Normal = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          -- DiffAdd = { fg = "green", bg = "NONE" },
          -- DiffChange = { fg = "gray", bg = "NONE" },
          -- DiffDelete = { fg = "darkred", bg = "NONE" },
          -- markdownH1Delimiter = { standout = true },
          markdownH1 = { underline = true, bold = true },
          -- markdownH2Delimiter = { standout = true },
          markdownH2 = { underline = true, bold = true, italic = true },
          markdownH3 = { underline = true, italic = true },
          markdownItalic = { italic = true },
          markdownItalicDelimiter = { italic = true, fg = "gray" },
          markdownBold = { bold = true },
          markdownBoldDelimiter = { bold = true, fg = "gray" },
          markdownAutomaticLink = { underline = true },
          yamlBlockMappingKey = { bold = true, fg = "black" },
          yamlDocumentStart = { fg = "gray" },
          NeoTreeWinSeparator = { bg = "NONE", fg = "gray" },
          NeoTreeTabActive = { bg = "NONE" },
        },
        dim_inactive = false,
        transparent_mode = true,
      })
      vim.cmd.colorscheme "gruvbox"
    end
  },
}
