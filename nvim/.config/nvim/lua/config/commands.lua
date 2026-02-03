-- Custom commands

-- Command to open all git-modified files in buffers
vim.api.nvim_create_user_command("OpenGitModified", function()
	-- Get git root directory
	local git_root_handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
	if not git_root_handle then
		vim.notify("Failed to get git root directory", vim.log.levels.ERROR)
		return
	end

	local git_root = git_root_handle:read("*l")
	git_root_handle:close()

	if not git_root or git_root == "" then
		vim.notify("Not in a git repository", vim.log.levels.ERROR)
		return
	end

	-- Get all modified and untracked files
	-- Using git ls-files to properly handle untracked files in directories
	local handle = io.popen("git ls-files --modified --others --exclude-standard 2>/dev/null")
	if not handle then
		vim.notify("Failed to run git ls-files", vim.log.levels.ERROR)
		return
	end

	local result = handle:read("*a")
	handle:close()

	if result == "" then
		vim.notify("No modified files found", vim.log.levels.INFO)
		return
	end

	local files = {}
	local count = 0

	-- Parse output (one file per line)
	for line in result:gmatch("[^\r\n]+") do
		-- Trim whitespace
		local filename = line:match("^%s*(.-)%s*$")

		if filename ~= "" then
			-- Build absolute path from git root
			local file_path = git_root .. "/" .. filename

			-- Check if file exists and is readable
			if vim.fn.filereadable(file_path) == 1 then
				table.insert(files, file_path)
				count = count + 1
			end
		end
	end

	if count == 0 then
		vim.notify("No readable modified files found", vim.log.levels.INFO)
		return
	end

	-- Open files in buffers
	for _, file in ipairs(files) do
		vim.cmd("badd " .. vim.fn.fnameescape(file))
	end

	vim.notify(string.format("Opened %d modified file(s)", count), vim.log.levels.INFO)
end, {
	desc = "Open all git-modified files (staged, unstaged, untracked) in buffers",
})

-- Reload Neovim configuration
vim.api.nvim_create_user_command("Reload", function()
	-- Clear Lua module cache for config files (but not lazy itself)
	for name, _ in pairs(package.loaded) do
		if name:match("^config%.") or name:match("^plugins%.") then
			package.loaded[name] = nil
		end
	end

	-- Reload individual config modules (avoid re-sourcing init.lua which re-initializes lazy)
	require("config.options")
	require("config.keymaps")
	require("config.commands")

	-- Reload Lazy plugins using the command (safer than direct API call)
	vim.cmd("Lazy reload")

	vim.notify("Configuration reloaded!", vim.log.levels.INFO)
end, {
	desc = "Reload Neovim configuration and plugins",
})
