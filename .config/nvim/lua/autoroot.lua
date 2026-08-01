-- I used to use <https://github.com/airblade/vim-rooter.git>
-- cf. <https://old.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/>

local M = {}
local root_names = { '.git', 'Makefile' } -- Array of file names indicating root directory
local root_cache = {} -- Cache to use for speed up (at cost of possibly outdated results)

M.get_root = function(path)
  if vim.startswith(path, 'oil://') then
    path = string.sub(path, 7)
  end

  local dir = vim.fs.dirname(vim.fn.fnamemodify(path, ':p'))

  -- Try cache and resort to searching upward for root directory
  local rootdir = root_cache[dir]
  if rootdir == nil then
    local root_file = vim.fs.find(root_names, { path = dir, upward = true })[1]
    if root_file == nil then
      return dir
    end
    rootdir = vim.fs.dirname(root_file)
    root_cache[dir] = rootdir
  end

  return rootdir or dir
end

local set_buffer_root = function()
  local bufname = vim.api.nvim_buf_get_name(0)
  if vim.startswith(bufname, 'oil:') then
    vim.fn.chdir(require("oil").get_current_dir(0))
  elseif bufname ~= '' then
    vim.fn.chdir(M.get_root(bufname))
  end
end

M.setup = function()
  local root_augroup = vim.api.nvim_create_augroup('MyAutoRoot', {})
  vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_buffer_root })
end

return M
