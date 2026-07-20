vim.pack.add{
-- Quickstart configs for Nvim LSP 
  { src = "https://github.com/neovim/nvim-lspconfig", version = "v2.10.0" },
-- Toggle, display and navigate marks 
  { src = 'https://github.com/kshenoy/vim-signature', version = '6bc3dd1294a22e897f0dcf8dd72b85f350e306bc' },
-- More sensible word motions
  { src = 'https://github.com/chaoren/vim-wordmotion', version = '81d9bd298376ab0dc465c85d55afa4cb8d5f47a1' },
-- Return to last position when editing files
  { src = 'https://github.com/farmergreg/vim-lastplace', version = 'e58cb0df716d3c88605ae49db5c4741db8b48aa9' },
-- Integrate direnv; see <https://direnv.net/>
  { src = 'https://github.com/direnv/direnv.vim', version = 'ab2a7e08dd630060cd81d7946739ac7442a4f269' },
-- Automatically detect indentation
  { src = 'https://github.com/tpope/vim-sleuth', version = 'v2.0' },
}
