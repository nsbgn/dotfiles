-- https://github.com/mrjones2014/smart-splits.nvim
-- https://github.com/numToStr/Navigator.nvim
-- https://github.com/yochem/autosplit.nvim

local function split_or_goto_split()
  -- If there's not yet a split anywhere, make it
  if vim.fn.winnr('$') == 1 then
    vim.cmd(':Split')
  end
  -- Go to other split
  vim.cmd(':wincmd w')
end

vim.keymap.set('n', '<C-n>', split_or_goto_split)
