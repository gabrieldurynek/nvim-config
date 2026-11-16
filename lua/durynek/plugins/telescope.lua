return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
            },
        })

        telescope.load_extension("fzf")

        local keymap = vim.keymap
        local builtin = require("telescope.builtin")

        keymap.set("n", "<leader>pf", builtin.find_files, {})
        keymap.set("n", "<C-p>", builtin.git_files, {})
        keymap.set("n", "<leader>ps", "<cmd>Telescope live_grep<CR>")
    end,
}
