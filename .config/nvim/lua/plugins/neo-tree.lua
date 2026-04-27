return {
  {
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    lazy = true, -- neo-tree will lazily load itself

    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        uv_libuv_file_watcher = true,
      -- fill any relevant options here
    },
    init = function()

      vim.keymap.set('n', '<space>', function()
        require('neo-tree.command').execute({
          action = "focus",
          source = "filesystem",
          position = "float",
          reveal_file = reveal_file,
        })
      end)

      require("neo-tree").setup({
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        source_selector = {
          winbar = true,
        },
        window = {
          mappings = {
            ["<space>"] = {
              "cancel",
            },
            ["P"] = {
              "toggle_preview",
              config = {
                use_float = true,
                use_snacks_image = false,
                use_image_nvim = false
              }
            },
            ["l"] = "focus_preview",
            ["<C-b>"] = { "scroll_preview", config = {direction = 10} },
            ["<C-f>"] = { "scroll_preview", config = {direction = -10} },
          }
        }
      })
    end
  },
}
