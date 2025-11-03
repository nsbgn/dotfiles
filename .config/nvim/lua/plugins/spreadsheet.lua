return {
  'https://github.com/hat0uma/csvview.nvim',
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    view = {
      display_mode = "border",
      sticky_header = {
        separator = "─",
      },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
}



