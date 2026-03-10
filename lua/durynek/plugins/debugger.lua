return {
    {
        "mfussenegger/nvim-dap",
        -- Load immediately for Go files to rule out lazy-loading issues
        ft = "go",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local dapgo = require("dap-go")
            local mason_dap = require("mason-nvim-dap")
            local dap_virtual_text = require("nvim-dap-virtual-text")

            dap_virtual_text.setup({})
            dapui.setup({})
            dapgo.setup()

            -- Automatically open and close dap-ui when debugging starts/ends
            dap.listeners.before.attach.dapui_config = function()
                dapui.open({})
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close({})
            end

            -- Configure mason-nvim-dap
            -- This will automatically install debuggers for languages you specify.
            mason_dap.setup({
                ensure_installed = {
                    "delve",
                },
                automatic_installation = true,
                handlers = {
                    delve = function() end,
                    -- This default handler sets up configurations for most debuggers
                    function(config)
                        require("mason-nvim-dap").default_setup(config)
                    end,
                },
            })

            local function load_env_file(filepath)
                local env_vars = {}
                local file = io.open(filepath, "r")
                if file then
                    for line in file:lines() do
                        local key, value = line:match("^(.-)=(.*)$")
                        if key and value then
                            env_vars[key] = value
                        end
                    end
                    file:close()
                end
                return env_vars
            end

            table.insert(dap.configurations.go,
                {
                    name = "Launch Beacon Server Debug 1",
                    type = "go",
                    request = "launch",
                    mode = "debug",
                    program = "${workspaceFolder}/cmd/server",
                    args = {
                        "--metrics-addr=:8080",
                        "--health-probe-addr=:8081",
                        "-zap-devel",
                    },
                    cwd = "${workspaceFolder}",
                    env = load_env_file("/tmp/beacon-server.env"),
                    outputMode = "remote",
                })

            -- Set breakpoint signs
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })


            -- debugger keymaps
            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step Over" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
            vim.keymap.set("n", "<leader>dL", dap.run_last, { desc = "Run Last" })
            vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
                { desc = "Breakpoint Condition" })
            vim.keymap.set("n", "<leader>ds", dap.session, { desc = "Session" })
            vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "Terminate" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Dap UI" })
            vim.keymap.set({ "n", "v" }, "<leader>de", dapui.eval, { desc = "Eval" })
            vim.keymap.set('n', '<leader>dw', function()
                require('dap').run_with(require('dap.ui.widgets').pick_configuration())
            end, { desc = 'DAP: Pick Configuration' })
        end,
    },
}
