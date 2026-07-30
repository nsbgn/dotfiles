-- -- Set working directory to project root
-- vim.pack.add({
--   { src = "https://github.com/airblade/vim-rooter.git", version = "51402fb77c4d6ae94994e37dc7ca13bec8f4afcc" },
-- })
--
-- vim.g.rooter_silent_chdir = 1
-- vim.g.rooter_silent_chdir = 1
-- vim.g.rooter_change_directory_for_non_project_files = 'current'
-- vim.g.rooter_resolve_links = 1
-- vim.g.rooter_patterns = {'.git', 'Makefile'}
-- vim.g.rooter_buftypes = {''}

-- cf. <https://old.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/>
local root_names = { '.git', 'Makefile' } -- Array of file names indicating root directory
local root_cache = {} -- Cache to use for speed up (at cost of possibly outdated results)

local set_root = function()
  local root

  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == '' then
    return
  -- Addition: when in oil.nvim, just use its current directory
  elseif vim.startswith(path, 'oil:') then
    root = require("oil").get_current_dir(0)
  else
    path = vim.fs.dirname(path)

    -- Try cache and resort to searching upward for root directory
    root = root_cache[path]
    if root == nil then
      local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
      if root_file == nil then return end
      root = vim.fs.dirname(root_file)
      root_cache[path] = root
    end
  end

  -- Set current directory
  vim.fn.chdir(root)
end

local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })

