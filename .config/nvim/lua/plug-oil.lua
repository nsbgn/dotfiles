-- File manager
vim.pack.add{
  { src = 'https://github.com/stevearc/oil.nvim', version = 'v2.16.0' },
  { src = "https://github.com/nvim-mini/mini.icons", version = 'v0.18.0' },
  { src = "https://github.com/malewicz1337/oil-git.nvim", version = 'v1.0.1' }
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
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "n",
    winbar = "%!v:lua.get_oil_winbar()",
  },
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
}

require("oil-git").setup{
  debounce_ms = 50,
  show_file_highlights = true,
  show_directory_highlights = true,
  show_file_symbols = true,
  show_directory_symbols = true,
  show_ignored_files = false,       -- Show ignored file status
  show_ignored_directories = false, -- Show ignored directory status
  show_branch = true,              -- Show current Git branch in oil buffers
  branch_format = " %s",           -- Format string for branch display
  symbol_position = "signcolumn",  -- "eol", "signcolumn", or "none"
  can_use_signcolumn = true,  -- Optional callback(bufnr): nil|bool|string
  ignore_gitsigns_update = false,   -- Ignore GitSignsUpdate events (fallback for flickering)
  debug = false,            -- false, "minimal", or "verbose"

  symbols = {
    file = { added = "✚", modified = "✱", renamed = "", deleted = "✖",
             copied = "✚", conflict = "", untracked = "", ignored = "" },
    directory = { added = "", modified = "", renamed = "", deleted = "",
                  copied = "", conflict = "", untracked = "", ignored = "" },
  },

  -- Colors (only applied if highlight groups don't exist)
  highlights = {
    OilGitAdded = { fg = "#a6e3a1" },
    OilGitModifiedStaged = { fg = "#f9e2af" },
    OilGitModifiedUnstaged = { fg = "#e5c890" },
    OilGitBranch = { fg = "#89b4fa" },
    OilGitRenamed = { fg = "#cba6f7" },
    OilGitDeleted = { fg = "#f38ba8" },
    OilGitCopied = { fg = "#cba6f7" },
    OilGitConflict = { fg = "#fab387" },
    OilGitUntracked = { fg = "#89b4fa" },
    OilGitIgnored = { fg = "#6c7086" },
  },
}

vim.keymap.set('n', '<space>e', function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname:find("oil://", 1, true) == 1 then
    require("oil").close()
  else
    require("oil").open()
  end
end, {})
