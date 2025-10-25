return {
  -- File manager
  { 'https://github.com/stevearc/oil.nvim',
    init = function()
      local oil = require("oil")
      oil.setup({
        default_file_explorer = false,
        columns = {
          "icon", -- "permissions", "size", "mtime",
        },
        buf_options = {
          buflisted = true,
          bufhidden = "hide",
        },
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "n",
        },
        restore_win_options = true,
        skip_confirm_for_simple_edits = false,
        delete_to_trash = false,
        -- trash_command = "trash-put",
        prompt_save_on_select_new_entry = true,
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["q"] = { callback = oil.parent, desc = "", nowait = true },
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["g."] = "actions.toggle_hidden",
        },
        use_default_keymaps = true,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function(name, bufnr)
            return false
          end,
        },
      })
      -- vim.keymap.set('n', 'q', "<CMD>Oil<CR>", {})
    end
  },
}
