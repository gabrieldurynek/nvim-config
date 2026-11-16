return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- Treesitter handles lazy loading parsers internally now
    build = ":TSUpdate",
    config = function()
        -- 1. Manage parsers via the new API
        local ts = require("nvim-treesitter")

        ts.setup({
            ensure_installed = { "go", "vim", "vimdoc", "query", "lua", "yaml", "diff" },
            auto_install = true,
            sync_install = false,
        })

        -- 2. Enable Native Tree-sitter Highlighting & Indentation
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
            end,
        })

        -- Enable native Tree-sitter expr indent
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- 3. Modern Keymaps for Incremental Selection
        -- (Uses native Neovim 0.12 treesitter node selection API)
        vim.keymap.set({ "n", "x" }, "<C-space>", function()
            vim.treesitter.incremental_selection.select_node()
        end, { desc = "Increment Treesitter selection" })

        vim.keymap.set("x", "<bs>", function()
            vim.treesitter.incremental_selection.decrement_node()
        end, { desc = "Decrement Treesitter selection" })
    end,
}
