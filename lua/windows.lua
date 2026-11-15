-- Sync system clipboards
vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })

-- REMOVE OR CONDITIONALIZE THIS: Only use "cmd" if you are actually on Windows
-- vim.opt.shell = "cmd"

-- Tmux integration when running inside tmux
if vim.env.TMUX then
	vim.g.clipboard = {
		name = "tmux",
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
