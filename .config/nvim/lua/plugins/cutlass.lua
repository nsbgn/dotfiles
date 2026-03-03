return {
  -- add cut command on x; deletion doesn't affect copy buffer anymore
  'https://github.com/gbprod/cutlass.nvim',
  opts = {
    cut_key = 'x',
    override_del = true
  }
}
