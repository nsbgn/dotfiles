vim.pack.add{
  { src = 'https://github.com/ibhagwan/fzf-lua', version = "511651f198068ef5841ee1635ade58daa2486ef7" }
}

require("fzf-lua").setup {
  winopts = { fullscreen = true, border = 'single'  },
  fzf_opts = { ["--exact"] = true },
}


local fzf = require("fzf-lua")

-- cf. https://github.com/ibhagwan/fzf-lua/wiki/Advanced
-- cf. https://github.com/ibhagwan/fzf-lua/discussions/2289
_G.projects = function(opts)
  fzf.fzf_exec(
    "fd '\\.git$' -H -t d ~/*/ --format '{//}' --relative-path", 
    {
      actions = {
        ['default'] = function(selected)
          require'oil'.open(selected[1])
        end
      },
      sort_members = true,
      fn_transform = function(x)
        -- local fzf = require("fzf-lua")
        -- return FzfLua.make_entry.file(x, { file_icons = true, color_icons = true })
        return x
      end
    }
  )
end
fzf.register_extension("projects", _G.projects, {})

vim.keymap.set('n', '<Tab>', function() fzf.combine({pickers = 'buffers;projects' }) end)
vim.keymap.set('n', '<Leader><Space>', fzf.builtin)
vim.keymap.set('n', '<Leader>a', fzf.buffers)
vim.keymap.set('n', '<Leader>f', fzf.files)
vim.keymap.set('n', '<Leader>g', fzf.live_grep)
vim.keymap.set('n', '<Leader>s', fzf.lsp_document_symbols)
vim.keymap.set('n', '<Leader>c', fzf.git_commits)
