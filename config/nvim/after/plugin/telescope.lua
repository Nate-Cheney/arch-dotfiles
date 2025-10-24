local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find [project] files" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find files tracked by git" })
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

