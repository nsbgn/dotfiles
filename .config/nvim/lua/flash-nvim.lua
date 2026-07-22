vim.pack.add({
  { src = "https://github.com/folke/flash.nvim", version = "v2.1.0" },
  -- { 'https://github.com/ggandor/leap.nvim' }
})

local opts = {
  label = {
    uppercase = false
  }
}

vim.keymap.set({'n', 'x', 'o'}, 's', function()
  require("flash").jump(opts)
end)
vim.keymap.set({'n', 'x', 'o'}, 'S', function()
  require("flash").treesitter(opts)
end)
