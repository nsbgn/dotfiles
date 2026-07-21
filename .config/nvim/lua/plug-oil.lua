-- File manager
vim.pack.add{
  { src = 'https://github.com/stevearc/oil.nvim', version = 'v2.16.0' },
  { src = "https://github.com/nvim-mini/mini.icons", version = 'v0.18.0' },
  -- { src = "https://github.com/malewicz1337/oil-git.nvim", version = 'v1.0.1' },
  { src = "https://github.com/refractalize/oil-git-status.nvim", version = 'a3e2ccb00cb8822115e28a9a1791eda051d940c9' }
}

-- cf. <https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar>
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

require("mini.icons").setup()

require("oil").setup{
  default_file_explorer = true,
  columns = {
    "icon", "permissions", "size", "mtime",
  },
  buf_options = {
    buflisted = true,
    bufhidden = "hide",
  },
  win_options = {
    wrap = false,
    signcolumn = "auto:2",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "n",
    winbar = "%!v:lua.get_oil_winbar()",
  },
  constrain_cursor = "name",
  restore_win_options = true,
  skip_confirm_for_simple_edits = false,
  delete_to_trash = true,
  trash_command = "gio trash",
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
    ["<Backspace>"] = { "actions.parent", mode = "n" },
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["t"] = "actions.open_terminal",
    ["f"] = {
      function()
          --find files?
      end,
      mode = "n",
      nowait = true,
      desc = "Find files in the current directory"
    },
    ["g."] = "actions.toggle_hidden",
  },
  use_default_keymaps = true,
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
  },
  -- Configuration for the file preview window
  preview_win = {
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
    -- How to open the preview window "load"|"scratch"|"fast_scratch"
    preview_method = "fast_scratch",
    -- A function that returns true to disable preview on a file e.g. to avoid lag
    disable_preview = function(filename)
      return false
    end,
    -- Window-local options to use for preview window buffers
    win_options = {},
  },
}

require('oil-git-status').setup({
  show_ignored = true,
  symbols = {
    index = {
      ["!"] = "", -- ignored
      ["?"] = "", -- untracked
      ["A"] = "✚", -- added
      ["C"] = "", -- copied
      ["D"] = "✖", -- deleted
      ["M"] = "✱", -- modified
      ["R"] = "", -- renamed
      ["T"] = "", -- type changed
      ["U"] = "", -- unmerged
      [" "] = " ", -- unmodified
    },
    working_tree = {
      ["!"] = "", -- ignored
      ["?"] = "", -- untracked
      ["A"] = "✚", -- added
      ["C"] = "", -- copied
      ["D"] = "✖", -- deleted
      ["M"] = "✱", -- modified
      ["R"] = "", -- renamed
      ["T"] = "", -- type changed
      ["U"] = "", -- unmerged
      [" "] = " ", -- unmodified
    },
  },
})

vim.keymap.set('n', '<space>e', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:find("oil://", 1, true) == 1 then
    require("oil").close()
  else
    require("oil").open()
  end
end, {})
