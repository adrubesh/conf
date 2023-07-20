-- Options
vim.g.mapleader = ';'

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
end)

-- Telescope
local setup_telescope = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end
setup_telescope()

-- COQ
local setup_coq = function()
	vim.g.coq_settings = { auto_start = 'shut-up' }
	return require('coq')
end
setup_coq()
