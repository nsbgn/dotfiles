return {
  -- Block matching via %
  { 'https://github.com/andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },

  -- Auto comment lines
  { "https://github.com/tpope/vim-commentary",
    init = function()
      vim.api.nvim_create_autocmd({'FileType'}, {
        pattern = {'turtle'},
        callback = function(ev)
          vim.opt_local.commentstring="# %s"
        end
      })
    end
  },
}
