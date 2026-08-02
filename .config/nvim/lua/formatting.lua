-- vim.pack.add{
--   { src = 'https://github.com/andrewferrier/wrapping.nvim', version = 'v2.1.3' },
-- }

local hard = function()
  -- vim.opt_local.textwidth = 72
  vim.opt_local.wrap = false

  -- see also `:h fo-table`
  -- - t sets text (but not comments) to be autowrap when reaching textwidth
  -- - a sets paragraphs to reformat when text is inserted or deleted
  -- - w defines paragraphs as being separated by a blank line
  -- - q allows the gq command to automatically reformat text
  vim.opt_local.formatoptions:append 'awtq'
end

local soft = function()
-- vim.opt_local.textwidth = 0
  vim.opt_local.wrap = false
  vim.opt_local.breakindent = true
  vim.opt_local.linebreak = true
-- as suggested in `:h wrap`
  vim.opt_local.sidescroll = 5
  vim.opt_local.listchars:append 'precedes:<,extends:>'
  vim.opt_local.formatoptions:remove 'at'
end


-- Global settings ---

-- Indentation
vim.o.autoindent = true -- copy indentation from previous line
vim.o.expandtab = true -- convert tabs to spaces
vim.o.tabstop = 8 -- number of spaces for the tab character
vim.o.shiftwidth = 4 -- number of characters for indentation (> and <)
vim.o.softtabstop = -1 -- tab and backspace insert spaces (negative number uses shiftwidth)

-- Wrapping
vim.o.textwidth = 72
vim.o.wrap = false
vim.o.breakindent = true -- wrapped lines will continue indented
vim.opt.breakindentopt:append "list:-1" -- list items get additional indent on wrap
vim.o.linebreak = true -- don't break lines in the middle of words

local group = vim.api.nvim_create_augroup("formatting", { clear = true })

-- augroup markdown
--     au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
--     au! BufNewFile,BufFilePre,BufRead *.mail set filetype=markdown
--     autocmd FileType markdown setlocal conceallevel=0 formatoptions+=aw2tq wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4
-- augroup END

-- vim.api.nvim_create_autocmd({'BufNewFile', 'BufFilePre', 'BufRead'}, {
--   pattern = { '*.md', '*.mail' },
--   group = formatting,
--   callback = function()
--     vim.o.filetype = 'markdown'
--   end,
-- })

-- augroup latex
-- "   https://vim.fandom.com/wiki/Move_cursor_by_display_lines_when_wrapping
-- "   https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
-- "   https://stackoverflow.com/questions/7053550/disable-all-auto-indentation-in-vim
--     au! BufNewFile,BufRead,BufRead *.tex set filetype=tex
--     autocmd FileType tex setlocal conceallevel=0
--     autocmd FileType tex setlocal formatoptions=w2qj
--     autocmd FileType tex setlocal wrap linebreak textwidth=72 wrapmargin=0 tabstop=4 shiftwidth=4 softtabstop=4 indentexpr=no
-- augroup END


vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = { 'markdown' },
  group = formatting,
  callback = soft,
})

vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = { 'markdown' },
  group = formatting,
  callback = soft,
})

vim.keymap.set("n", "<Leader>ws", soft)
vim.keymap.set("n", "<Leader>wh", hard)
