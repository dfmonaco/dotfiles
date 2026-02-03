-- Custom commands

-- Command to open all git-modified files in buffers
vim.api.nvim_create_user_command("OpenGitModified", function()
	-- Get git status output
	local handle = io.popen("git status --porcelain 2>/dev/null")
	if not handle then
		vim.notify("Failed to run git status", vim.log.levels.ERROR)
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

	-- Parse git status output
	-- Format: XY filename
	-- X = staged status, Y = unstaged status
	for line in result:gmatch("[^\r\n]+") do
		-- Extract filename (skip first 3 characters which are status codes and space)
		local filename = line:sub(4)

		-- Handle renamed files (format: "old -> new")
		if filename:match("->") then
			filename = filename:match("-> (.+)$")
		end

		-- Remove quotes if present
		filename = filename:gsub('^"', ""):gsub('"$', "")

		-- Check if file exists (skip deleted files)
		local file_path = vim.fn.fnamemodify(filename, ":p")
		if vim.fn.filereadable(file_path) == 1 then
			table.insert(files, file_path)
			count = count + 1
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
	-- Clear Lua module cache for config files
	for name, _ in pairs(package.loaded) do
		if name:match("^config") or name:match("^plugins") then
			package.loaded[name] = nil
		end
	end

	-- Re-source init.lua
	dofile(vim.fn.stdpath("config") .. "/init.lua")

	-- Reload Lazy plugins
	vim.cmd("Lazy reload")

	vim.notify("Configuration reloaded!", vim.log.levels.INFO)
end, {
	desc = "Reload Neovim configuration and plugins",
})
