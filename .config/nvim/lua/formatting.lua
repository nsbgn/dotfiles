-- vim.pack.add{
--   { src = 'https://github.com/andrewferrier/wrapping.nvim', version = 'v2.1.3' },
-- }
-- cf. https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
-- cf. https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
-- cf. https://stackoverflow.com/questions/7053550/disable-all-auto-indentation-in-vim
---------------------
-- Global settings --

-- Indentation
vim.o.autoindent = true -- copy indentation from previous line
vim.o.expandtab = true -- convert tabs to spaces
vim.o.tabstop = 8 -- number of spaces for the tab character
vim.o.shiftwidth = 4 -- number of characters for indentation (> and <)
vim.o.softtabstop = -1 -- tab/bksp insert #spaces ( < 0 → use shiftwidth)

-- Wrapping
vim.o.textwidth = 80
vim.o.wrap = false
vim.o.breakindent = true -- wrapped lines will continue indented
vim.opt.breakindentopt:append "list:-1" -- list items get additional indent on wrap
vim.o.linebreak = true -- don't break lines in the middle of words

-- as suggested in `:h wrap`
vim.o.sidescroll = 5
vim.opt.listchars:append 'precedes:<,extends:>'

------------------
-- Autocommands --

local get_max_columns = function(default)
  local tty = vim.uv.new_tty(1, false)
  -- tty:write("\x1b[18;;t") -- see `man foot-ctlseqs` 
  local ok, cols, rows = pcall(vim.uv.tty_get_winsize, tty)
  tty:close()
  if ok then
    return cols
  else
    return default
  end
end

local soft_wrap = function(tw)
  tw = tw or vim.bo.textwidth or vim.o.textwidth or 80
  vim.b.hard_textwidth = tw
  vim.bo.textwidth = 0
  vim.wo.wrap = true
  vim.opt_local.formatoptions:remove 'at'

  -- When soft wrapping, we just reduce the number of columns so that it
  -- won't span the whole screen. This is a workaround because
  -- <https://github.com/neovim/neovim/issues/4386> is still open. It is
  -- far from ideal as EVERYTHING then has to fit inside here, but it
  -- feels less janky than the various zen-mode plugins like Goyo,
  -- <https://github.com/folke/zen-mode.nvim>
  -- -- never mind, it is very janky
  -- vim.opt.columns = tw + 8
end

local hard_wrap = function(tw)
  tw = tw or vim.b.hard_textwidth or vim.bo.textwidth or vim.o.textwidth or 80
  vim.wo.wrap = false
  vim.bo.textwidth = tw
  vim.b.hard_textwidth = nil

  -- Reset columns to what it was -- presumably the terminal's max
  -- vim.opt.columns = get_max_columns(80)

  -- see also `:h fo-table`
  -- - t sets text (but not comments) to be autowrap when reaching textwidth
  -- - a sets paragraphs to reformat when text is inserted or deleted
  -- - w defines paragraphs as being separated by a blank line
  -- - q allows the gq command to automatically reformat text
  vim.opt_local.formatoptions:append 'awtq'
end


local group = vim.api.nvim_create_augroup("formatting", { clear = true })

vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = { 'markdown', 'mail' },
  group = formatting,
  callback = function() hard_wrap(72) end,
})

vim.keymap.set("n", "<Leader>ws", soft_wrap)
vim.keymap.set("n", "<Leader>wh", hard_wrap)
