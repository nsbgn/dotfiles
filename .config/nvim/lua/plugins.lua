-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
    { "https://github.com/neovim/nvim-lspconfig" },

    { 'https://github.com/yorickpeterse/vim-paper',
      enabled = true,
      init = function()
        vim.cmd.colorscheme 'paper'
        vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "markdownH1", { underline = true, bold = true })
        vim.api.nvim_set_hl(0, "markdownH2", { underline = true, bold = true, italic= true })
        vim.api.nvim_set_hl(0, "markdownH3", { underline = true, italic = true })
      end
    },

    { "https://github.com/ellisonleao/gruvbox.nvim",
      priority = 1000,
      enabled = false,
      config = true,
      init = function()
        require("gruvbox").setup({
          terminal_colors = true, -- add neovim terminal colors
          undercurl = true,
          underline = true,
          bold = true,
          italic = {
            strings = true,
            emphasis = true,
            comments = true,
            operators = false,
            folds = true,
          },
          strikethrough = true,
          invert_selection = false,
          invert_signs = false,
          invert_tabline = false,
          invert_intend_guides = false,
          inverse = true, -- invert background for search, diffs, statuslines and errors
          contrast = "hard",
          palette_overrides = {},
          overrides = {
            -- Normal = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            -- DiffAdd = { fg = "green", bg = "NONE" },
            -- DiffChange = { fg = "gray", bg = "NONE" },
            -- DiffDelete = { fg = "darkred", bg = "NONE" },
            -- markdownH1Delimiter = { standout = true },
            markdownH1 = { underline = true, bold = true },
            -- markdownH2Delimiter = { standout = true },
            markdownH2 = { underline = true, bold = true, italic = true },
            markdownH3 = { underline = true, italic = true },
            markdownItalic = { italic = true },
            markdownItalicDelimiter = { italic = true, fg = "gray" },
            markdownBold = { bold = true },
            markdownBoldDelimiter = { bold = true, fg = "gray" },
            markdownAutomaticLink = { underline = true },
            yamlBlockMappingKey = { bold = true, fg = "black" },
            yamlDocumentStart = { fg = "gray" },
            NeoTreeWinSeparator = { bg = "NONE", fg = "gray" },
            NeoTreeTabActive = { bg = "NONE" },
          },
          dim_inactive = false,
          transparent_mode = true,
        })
        vim.cmd.colorscheme "gruvbox"
      end
    },

    -- Integrate direnv; see <https://direnv.net/>
    { 'https://github.com/direnv/direnv.vim' },

    -- Visually indicate marks
    { 'https://github.com/kshenoy/vim-signature' },

    -- Automatically detect indentation
    { 'https://github.com/tpope/vim-sleuth' },

    -- More sensible word motions
    { 'https://github.com/chaoren/vim-wordmotion' },

    -- Auto comment lines
    { "https://github.com/tpope/vim-commentary",
      init = function()
        vim.cmd[[
          autocmd FileType turtle setlocal commentstring=#\ %s
        ]]
      end
    },

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

    { 'https://github.com/folke/which-key.nvim',
      event = "VeryLazy",
      opts = {
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },

    -- Return to last position when editing files
    { 'https://github.com/farmergreg/vim-lastplace' },

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

    { 'https://github.com/smoka7/hop.nvim',
      version = "*",
      opts = {
        keys = 'etovxqpdygfblzhckisuran'
      }
    },

    -- Comfortable middle ground between hop and sneak
    { 'https://github.com/ggandor/leap.nvim',
      init = function()
        require('leap').add_default_mappings()
        require('leap').opts.highlight_unlabeled_phase_one_targets = true

        -- So that the first match in leap.nvim is shown, see 
        -- https://github.com/ggandor/leap.nvim/issues/27
        vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
        vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bg = 'black' })
        vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'white', bg = 'blue' })
        vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = 'white', bg = 'red' })
      end
    },

    { 'https://github.com/ggandor/flit.nvim',
      init = function()
        require('flit').setup()
      end
    },

    -- Block matching via %
    { 'https://github.com/andymass/vim-matchup',
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end
    },

    -- Syntax highlighting
    { 'https://github.com/niklasl/vim-rdf' },
    { 'https://github.com/vim-scripts/sparql.vim' },
    { 'https://github.com/ledger/vim-ledger' },

    { 'https://github.com/stevearc/oil.nvim',
      init = function()
        local oil = require("oil")
        oil.setup({
          default_file_explorer = false,
          columns = {
            "icon", -- "permissions", "size", "mtime",
          },
          buf_options = {
            buflisted = true,
            bufhidden = "hide",
          },
          win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "n",
          },
          restore_win_options = true,
          skip_confirm_for_simple_edits = false,
          delete_to_trash = false,
          -- trash_command = "trash-put",
          prompt_save_on_select_new_entry = true,
          -- See :help oil-actions for a list of all available actions
          keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["q"] = { callback = oil.parent, desc = "", nowait = true },
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["g."] = "actions.toggle_hidden",
          },
          use_default_keymaps = true,
          view_options = {
            show_hidden = false,
            is_hidden_file = function(name, bufnr)
              return vim.startswith(name, ".")
            end,
            is_always_hidden = function(name, bufnr)
              return false
            end,
          },
        })
        -- vim.keymap.set('n', 'q', "<CMD>Oil<CR>", {})
      end
    },

    {
      "https://github.com/nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      lazy = false, -- neo-tree will lazily load itself
      ---@module "neo-tree"
      ---@type neotree.Config?
      opts = {
        -- fill any relevant options here
      },
      init = function()
        vim.keymap.set('n', '<space>f', ':Neotree source=filesystem reveal=true position=left toggle<CR>')
        require("neo-tree").setup({
          source_selector = {
            winbar = true,
          }
        })
      end
    },

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

    -- -- Folds
    { 'https://github.com/kevinhwang91/nvim-ufo',
      enabled = true,
      dependencies = {'https://github.com/kevinhwang91/promise-async' },
      init = function()
        if vim.version().minor >= 12 or vim.version().major > 0 then
          vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'
        end
        vim.o.foldcolumn = '0'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
          end,
        })
      end
    },
  },
  install = { },
  checker = { enabled = false },
})
