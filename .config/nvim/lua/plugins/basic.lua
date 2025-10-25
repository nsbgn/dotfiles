return {
  -- Configurations for LSP
  { "https://github.com/neovim/nvim-lspconfig" },

  -- Visually indicate marks
  { 'https://github.com/kshenoy/vim-signature' },

  -- Automatically detect indentation
  { 'https://github.com/tpope/vim-sleuth' },

  -- More sensible word motions
  { 'https://github.com/chaoren/vim-wordmotion' },

  -- Return to last position when editing files
  { 'https://github.com/farmergreg/vim-lastplace' },

  -- Block matching via %
  { 'https://github.com/andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },

  -- Auto comment lines
  { "https://github.com/tpope/vim-commentary",
    init = function()
      vim.cmd[[
        autocmd FileType turtle setlocal commentstring=#\ %s
      ]]
    end
  },

  -- Integrate direnv; see <https://direnv.net/>
  { 'https://github.com/direnv/direnv.vim' },

  -- Set working directory to project root
  { 'https://github.com/airblade/vim-rooter.git',
    init = function()
      vim.cmd([[
        let g:rooter_silent_chdir = 1
        let g:rooter_change_directory_for_non_project_files = 'current'
        let g:rooter_resolve_links = 1
        let g:rooter_patterns = ['.git', 'Makefile']
        let g:rooter_buftypes = ['']
      ]])
    end
  },
}
