vim.pack.add{
  { src = 'https://github.com/ibhagwan/fzf-lua', version = "511651f198068ef5841ee1635ade58daa2486ef7" },
-- https://github.com/mateconpizza/projects.nvim
-- https://github.com/DrKJeff16/project.nvim
  { src = 'https://github.com/gennaro-tedesco/nvim-possession', version = 'v0.3.2' },
}

require("fzf-lua").setup {
  winopts = { fullscreen = true, border = 'single'  },
  fzf_opts = { ["--exact"] = true },
}


local fzf = require("fzf-lua")

-- cf. https://github.com/ibhagwan/fzf-lua/wiki/Advanced
-- cf. https://github.com/ibhagwan/fzf-lua/discussions/2289
-- idea: assign different colors to different projects
-- add recency
_G.projects = function(opts)
  fzf.fzf_exec(
    "fd '\\.git$' -H -t d ~/*/ --format '{//}' | cut -d/ -f4- | grep -v '[^/].\\?archive'; yadm ls-files --full-name ~ | sed -n 's/\\(\\.config\\/[^\\/]\\+\\)\\/[^\\/]\\+$/\\1/p' | uniq",
    --  -X stat --format=\"%Y %y %n\" | sort | cut -d/ -f4-
    {
      actions = {
        ['default'] = function(selected)
          require'oil'.open('~/' .. selected[1])
        end
      },
    }
  )
end
fzf.register_extension("projects", _G.projects, {})

-- Open projects when bufferlist is empty?
vim.keymap.set('n', '<Tab>', fzf.buffers)
vim.keymap.set({'n', 'x', 't'}, '<C-Tab>', fzf.buffers)
vim.keymap.set('n', '<Leader><Space>', fzf.builtin)
vim.keymap.set('n', '<Leader>p', _G.projects)
vim.keymap.set('n', '<Leader>b', fzf.buffers)
vim.keymap.set('n', '<Leader>f', fzf.files)
vim.keymap.set('n', '<Leader>g', fzf.live_grep)
vim.keymap.set('n', '<Leader>d', fzf.lsp_document_symbols)
vim.keymap.set('n', '<Leader>c', fzf.git_commits)
vim.keymap.set('n', '<Leader>u', fzf.undotree)

local possession = require("nvim-possession")

possession.setup{
  autosave = true,
  sort = require("nvim-possession.sorting").time_sort
}
vim.keymap.set('n', "<Leader>s", possession.list, {desc = "list sessions"})
vim.keymap.set('n', "<Leader>S", possession.new, {desc = "new session"})
