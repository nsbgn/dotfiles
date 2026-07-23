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

local oil = require("oil")
oil.setup{
  default_file_explorer = true,
  columns = {
    'icon',
    {'permissions', highlight = 'Comment'},
    {'mtime', highlight = 'Comment'},
    {'size', highlight = 'Comment'},
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
    -- TODO also allow arrow key navigation?
    ["g?"] = "actions.show_help",
    ["<Esc>"] = { function()
      local oil = require("oil")

      -- TODO more robust
      local is_modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
      if is_modified then
        return
      end

      local cwd = oil.get_current_dir(0)
      oil.close()
      local is_empty_buf = vim.api.nvim_buf_get_name(0) == "" 
      if is_empty_buf then
        vim.cmd.cd(cwd)
      end
    end, mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    -- ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-l>"] = "actions.refresh",
    ["<Backspace>"] = { "actions.parent", mode = "n" },
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    -- ["t"] = "actions.open_terminal",
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
  use_default_keymaps = false,
  view_options = {
    show_hidden = false,
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Highlight files that are already open in some buffer
    -- TODO get inspiration from <https://github.com/malewicz1337/oil-git.nvim>
    -- to do this more properly: use virtual texts to add buffer number(s), also
    -- highlight directories, also add option to close buffers, etc
    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
      local cur = vim.api.nvim_get_current_buf()
      local cwd = oil.get_current_dir(cur)
      for buf in pairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_is_valid(buf) then
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname == cwd .. entry.name then
            return 'Special'
          end
        end
      end
      return nil
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

vim.keymap.set('', 'q', '<Nop>', { nowait = true })

vim.keymap.set({'n', 'x'}, '<Backspace>', function()
  require("oil").open()
end, { nowait = true })

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open Oil.nvim when launching Neovim with no arguments",
  group = vim.api.nvim_create_augroup("oil-start-on-empty", { clear = true }),
  callback = function(data)
    local no_args = #vim.fn.argv() == 0
    local is_empty_buf = vim.api.nvim_buf_get_name(0) == "" 
    if no_args and is_empty_buf then
      vim.defer_fn(function()
        require("oil").open()
      end, 0)
    end
  end,
})
