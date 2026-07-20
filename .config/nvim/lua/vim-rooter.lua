-- Set working directory to project root
vim.pack.add({
  { src = "https://github.com/airblade/vim-rooter.git", version = "51402fb77c4d6ae94994e37dc7ca13bec8f4afcc" },
})

vim.g.rooter_silent_chdir = 1
vim.g.rooter_silent_chdir = 1
vim.g.rooter_change_directory_for_non_project_files = 'current'
vim.g.rooter_resolve_links = 1
vim.g.rooter_patterns = {'.git', 'Makefile'}
vim.g.rooter_buftypes = {''}

