# Moving to Lua

https://github.com/nanotee/nvim-lua-guide/
https://toroid.org/modern-neovim
https://joehallenbeck.com/the-glories-of-text-files-on-using-vim-for-code-and-prose/
https://www.opensourceagenda.com/projects/vim-no-color-collections
https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887?gi=32e31ad24afb


# Notes

In this file, I collect plugins that I have yet to incorporate in my 
workflow, or that have been superseded by other plugins.


https://github.com/wbthomason/packer.nvim
https://github.com/neovim/nvim-lspconfig
https://github.com/nvim-treesitter/nvim-treesitter
https://github.com/numToStr/FTerm.nvim
https://github.com/yochem/autosplit.nvim
https://github.com/nvim-telescope/telescope.nvim
https://github.com/natecraddock/telescope-zf-native.nvim
https://github.com/cljoly/telescope-repo.nvim
https://github.com/nvim-telescope/telescope-file-browser.nvim
https://github.com/morhetz/gruvbox
https://github.com/cbochs/portal.nvim
https://github.com/folke/which-key.nvim
https://github.com/sindrets/diffview.nvim
https://github.com/TimUntersberger/neogit
https://github.com/tpope/vim-fugitive
https://github.com/lewis6991/gitsigns.nvim
https://github.com/tanvirtin/vgit.nvim
https://github.com/klen/nvim-test
https://github.com/vim-test/vim-test
https://github.com/rcarriga/vim-ultest
https://github.com/nvim-neotest/neotest

https://github.com/mfussenegger/nvim-dap

" Statusline
" See also https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
https://github.com/beauwilliams/statusline.lua 
https://github.com/folke/noice.nvim
https://github.com/gorbit99/codewindow.nvim
https://github.com/wfxr/minimap.vim
https://github.com/severin-lemaignan/vim-minimap
https://github.com/kien/ctrlp.vim
https://github.com/gfanto/fzf-lsp.nvim
https://github.com/ojroques/nvim-lspfuzzy

https://github.com/ap/vim-buftabline
https://github.com/akinsho/bufferline.nvim
https://github.com/bling/vim-bufferline
https://github.com/liuchengxu/vista.vim # View LSP symbols & tags
https://github.com/sjl/gundo.vim # Browse the undo tree
https://github.com/elihunter173/dirbuf.nvim
https://github.com/rbong/vim-flog
https://github.com/folke/trouble.nvim

https://github.com/liuchengxu/vim-clap
https://github.com/liuchengxu/vim-which-key

Email:
https://git.sr.ht/~soywod/himalaya-vim

Work with GPG-encrypted files:
https://github.com/jamessan/vim-gnupg.git

Manage tag files:
https://github.com/ludovicchabant/vim-gutentags

Show context while editing:
https://github.com/romgrk/nvim-treesitter-context

https://github.com/phaazon/hop.nvim
https://github.com/justinmk/vim-sneak

Automatic alignment
https://github.com/junegunn/vim-easy-align

Automatically detect indentation
https://github.com/tpope/vim-sleuth

Auto-edit parentheses
https://github.com/tpope/vim-surround

Edit parentheses
https://github.com/machakann/vim-sandwich

Use v* to select word, paragraph, whatever is between delimiting pairs. 
Not perfect since I'd like to select sentences, paragraphs...
https://github.com/gorkunov/smartpairs.vim.git
https://github.com/ZhiyuanLck/smart-pairs
https://github.com/terryma/vim-expand-region

Text exchange:
https://github.com/tommcdo/vim-exchange

Moving text selections around:
https://github.com/zirrostig/vim-schlepp

Superseded by vim-smoothie:
https://github.com/yuttie/comfortable-motion.vim
https://github.com/lukelbd/vim-scrollwrapped

Language server protocol is now builtin:
https://github.com/natebosch/vim-lsc


Leap to line with leap.nvim:

    lua << EOF
    local function get_line_starts(winid)
      local wininfo =  vim.fn.getwininfo(winid)[1]
      local cur_line = vim.fn.line('.')

      -- Get targets.
      local targets = {}
      local lnum = wininfo.topline
      while lnum <= wininfo.botline do
        local fold_end = vim.fn.foldclosedend(lnum)
        -- Skip folded ranges.
        if fold_end ~= -1 then
          lnum = fold_end + 1
        else
          if lnum ~= cur_line then table.insert(targets, { pos = { lnum, 1 } }) end
          lnum = lnum + 1
        end
      end
      -- Sort them by vertical screen distance from cursor.
      local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)['row']
      local function screen_rows_from_cur(t)
        local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])['row']
        return math.abs(cur_screen_row - t_screen_row)
      end
      table.sort(targets, function (t1, t2)
        return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
      end)

      if #targets >= 1 then
        return targets
      end
    end

    -- Usage:
    local function leap_to_line()
      winid = vim.api.nvim_get_current_win()
      require('leap').leap {
        target_windows = { winid },
        targets = get_line_starts(winid),
      }
    end
    EOF
