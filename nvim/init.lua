-- Options
vim.g.mapleader = ';'
vim.cmd("colorscheme torte")

-- Packages
require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim' }
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
	use { 'nvim-tree/nvim-web-devicons' }
	use { 'neovim/nvim-lspconfig' }
	use { 
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({with_sync=true})
			ts_update()
		end
	}
	use { 'ms-jpq/coq_nvim', branch = 'coq' }
	use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }
	use { 'ms-jpq/coq.thirdparty', branch = '3p' }
	use { 'jose-elias-alvarez/null-ls.nvim' }
	use { 'ray-x/go.nvim' }
	use { 'ray-x/guihua.lua' } -- recommended if need floating window support
end)

-- Telescope
local setup_telescope = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
end
setup_telescope()

-- COQ
local setup_coq = function()
	vim.g.coq_settings = { auto_start = 'shut-up' }
	return require('coq')
end
local coq = setup_coq()

--- go
require('go').setup()

--- LSPs
local lsp = require('lspconfig')
local util = require('lspconfig/util')
local null_ls = require('null-ls')

if vim.fn.executable('clangd') == 1 then
	lsp.clangd.setup(coq.lsp_ensure_capabilities({cmd = { "clangd", "--background-index", "--clang-tidy" }}))
end
if vim.fn.executable('gopls') == 1 then
	lsp.gopls.setup(coq.lsp_ensure_capabilities({
		cmd = {"gopls", "serve"}, 
		filetypes = {"go", "gomod"}, 
		root_dir = util.root_pattern("go.work", "go.mod", ".git"),
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
			},
		}}))
end

null_ls.setup({sources = { 
	null_ls.builtins.formatting.clang_format,
	null_ls.builtins.code_actions.gomodifytags,
	null_ls.builtins.formatting.gofmt
}})
