-- Sync system clipboards
vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })

-- REMOVE OR CONDITIONALIZE THIS: Only use "cmd" if you are actually on Windows
-- vim.opt.shell = "cmd"

-- Force Tmux integration directly if tmux is installed,
-- ignoring whether the environment variable survived the agent spawn.
if vim.fn.executable("tmux") == 1 then
	vim.g.clipboard = {
		name = "tmux-fallback",
		copy = {
			["+"] = { "tmux", "load-buffer", "-w", "-" },
			["*"] = { "tmux", "load-buffer", "-w", "-" },
		},
		paste = {
			["+"] = { "tmux", "save-buffer", "-" },
			["*"] = { "tmux", "save-buffer", "-" },
		},
		cache_enabled = false,
	}
end
