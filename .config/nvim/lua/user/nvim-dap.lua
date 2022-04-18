local opts = { noremap = false, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", opts)
keymap("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>", opts)
keymap("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>", opts)
keymap("n", "<F12>", "<cmd>lua require('dap').step_out()<CR>", opts)
keymap("n", "<F8>", "<cmd>lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap(
	"n",
	"<leader>lp",
	"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
	opts
)
keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", opts)
keymap("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", opts)

--local status_ok, dap = pcall(require, "dap")
--if not dap then
--	return
--end
--
--dap.adapters.go = function(callback, config)
--	local stdout = vim.loop.new_pipe(false)
--	local handle
--	local pid_or_err
--	local port = 38697
--	local opts = {
--		stdio = { nil, stdout },
--		args = { "dap", "-l", "127.0.0.1:" .. port },
--		detached = true,
--	}
--	handle, pid_or_err = vim.loop.spawn("delv", opts, function(code)
--		stdout:close()
--		handle:close()
--		if code ~= 0 then
--			print("delv exited with code", code)
--		end
--	end)
--	assert(handle, "Error running delv: " .. tostring(pid_or_err))
--	stdout:read_start(function(err, chunk)
--		assert(not err, err)
--		if chunk then
--			vim.schedule(function()
--				require("dap.repl").append(chunk)
--			end)
--		end
--	end)
--	-- Wait for delve to start
--	vim.defer_fn(function()
--		callback({ type = "server", host = "127.0.0.1", port = port })
--	end, 100)
--end
--
---- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
--dap.configurations.go = {
--	{
--		type = "go",
--		name = "Debug",
--		request = "launch",
--		program = "${file}",
--	},
--	{
--		type = "go",
--		name = "Debug test", -- configuration for debugging test files
--		request = "launch",
--		mode = "test",
--		program = "${file}",
--	},
--	-- works with go.mod packages and sub packages
--	{
--		type = "go",
--		name = "Debug test (go.mod)",
--		request = "launch",
--		mode = "test",
--		program = "./${relativeFileDirname}",
--	},
--	{
--		type = "go",
--		name = "Debug Package",
--		request = "launch",
--		program = "${fileDirname}",
--	},
--	{
--		type = "go",
--		name = "Attach",
--		mode = "local",
--		request = "attach",
--		processId = require("dap.utils").pick_process,
--	},
--}

--require("dap-go").setup()
