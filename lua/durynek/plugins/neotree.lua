return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    init = function()
        vim.g.neotree = {
            auto_open = false,
        }
    end,
    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = {
                    enabled = true, -- This will find and focus the file in the active buffer every time
                },
                filtered_items = {
                    hide_dotfiles = false,
                },
            },
            buffers = {
                follow_current_file = {
                    visible = true,
                    enabled = true, -- This will find and focus the file in the active buffer every time
                    hide_gitignored = false,
                },
            },
            window = {
                -- width = 30,
                position = "float",
            },
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        -- auto close
                        -- vimc.cmd("Neotree close")
                        -- OR
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },
        })
    end
}
