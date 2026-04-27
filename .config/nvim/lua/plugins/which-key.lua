return {
  { 'https://github.com/folke/which-key.nvim',
    event = "VeryLazy",
    enabled = true,
    opts = {
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },


}
