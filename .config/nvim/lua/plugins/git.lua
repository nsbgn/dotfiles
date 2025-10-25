return {
  -- Git integration
  { 'https://github.com/tpope/vim-fugitive',
    enabled = true,
  },

  -- Git merge/diff viewer
  { 'https://github.com/sindrets/diffview.nvim' },

  -- View git branches
  { 'https://github.com/junegunn/gv.vim',
    enabled = true,
  },

  { 'https://github.com/lewis6991/gitsigns.nvim',
    init = function()
      require('gitsigns').setup {
        signs = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '▶' },
          topdelete    = { text = '▲' },
          changedelete = { text = '━' },
          untracked    = { text = '┆' },
        },
        signs_staged = {
          add          = { text = '┋' },
          change       = { text = '┋' },
          delete       = { text = '▷' },
          topdelete    = { text = '△' },
          changedelete = { text = '┅' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable = true,
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        _on_attach_pre = function(bufnr, callback)
            require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
        end,
      }
    end
  },
  { 'https://github.com/purarue/gitsigns-yadm.nvim' },

  -- Git signs, works for both git and svn
  { 'https://github.com/mhinz/vim-signify.git',
    enabled = false,
    init = function()
      vim.cmd([[
        set signcolumn=auto
        let g:signify_sign_add = '✚'
        let g:signify_sign_delete = '✖'
        let g:signify_sign_delete_first_line = '●'
        let g:signify_sign_change = '✱'
      ]])
    end
  },
}
