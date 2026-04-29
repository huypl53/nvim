vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
vim.opt.shell = "cmd"

if vim.env.TMUX then
	vim.g.clipboard = {
		name = "tmux",
		copy = {
			["+"] = "tmux load-buffer -w -",
			["*"] = "tmux load-buffer -w -",
		},
		paste = {
			["+"] = "tmux save-buffer -",
			["*"] = "tmux save-buffer -",
		},
		cache_enabled = false,
	}
end
