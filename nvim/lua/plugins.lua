return require("packer").startup(function(use)
	-- Packer can manage itself
	use { "wbthomason/packer.nvim" }
    
	-- Theme
	use { "catppuccin/nvim", as = "catppuccin" }
    
	-- Telescope
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.8",
		requires = { {"nvim-lua/plenary.nvim"} }
	}
    
	-- Treesitter
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

	-- Undotree
	use { "mbbill/undotree" }
end)
