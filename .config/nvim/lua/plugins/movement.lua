return {
  -- Comfortable middle ground between hop and sneak
  { 'https://github.com/ggandor/leap.nvim',
    enabled = false,
    init = function()
      require('leap').opts.highlight_unlabeled_phase_one_targets = true

      vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
      vim.keymap.set('n', 'S', '<Plug>(leap-backward)')

      -- Highly recommended: define a preview filter to reduce visual noise
      -- and the blinking effect after the first keypress
      -- (`:h leap.opts.preview`). You can still target any visible
      -- positions if needed, but you can define what is considered an
      -- exceptional case.
      -- Exclude whitespace and the middle of alphabetic words from preview:
      --   foobar[baaz] = quux
      --   ^----^^^--^^-^-^--^
      require('leap').opts.preview = function (ch0, ch1, ch2)
        return not (
          ch1:match('%s')
          or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
        )
      end

      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group:
      require('leap').opts.equivalence_classes = {
        ' \t\r\n', '([{', ')]}', '\'"`'
      }

      -- Use the traversal keys to repeat the previous motion without
      -- explicitly invoking Leap:
      require('leap.user').set_repeat_keys('<enter>', '<backspace>')

      -- So that the first match in leap.nvim is shown, see 
      -- https://github.com/ggandor/leap.nvim/issues/27
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
      vim.api.nvim_set_hl(0, 'LeapMatch', { fg = 'white', bg = 'black' })
      vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'white', bg = 'blue' })
      vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = 'white', bg = 'red' })

      -- Also set leap-ft, to go with https://github.com/ggandor/flit.nvim
    end
  },
}
