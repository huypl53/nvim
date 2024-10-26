local status, vscode = pcall(require, "vscode")
if not status then
	return
end

local keymap = vim.keymap

keymap.set("n", "gd", function()
	vscode.call("editor.action.revealDefinition")
end)

keymap.set("n", "gp", function()
	vscode.call("editor.action.peekDefinition")
end)

keymap.set("n", "sj", function()
	vscode.call("workbench.action.navigateDown")
end)

keymap.set("n", "sk", function()
	vscode.call("workbench.action.navigateUp")
end)

keymap.set("n", "sh", function()
	vscode.call("workbench.action.navigateLeft")
end)

keymap.set("n", "sl", function()
	vscode.call("workbench.action.navigateRight")
end)

keymap.set("n", "sz", function()
	vscode.call("workbench.action.toggleMaximizeEditorGroup")
end)

keymap.set("n", "sv", function()
	vscode.call("workbench.action.splitEditorRight")
end)

keymap.set("n", "ss", function()
	vscode.call("workbench.action.splitEditorDown")
end)

keymap.set("n", "gr", function()
	vscode.call("editor.action.rename")
end)

keymap.set("n", "m;", function()
	vscode.call("bookmarks.toggle")
end)

keymap.set("n", "m]", function()
	vscode.call("bookmarks.jumpToNext")
end)

keymap.set("n", "m[", function()
	vscode.call("bookmarks.jumpToPrevious")
end)

return {
	-- by LazyNvim
	-- "dial.nvim",
	-- "flit.nvim",
	-- "lazy.nvim",
	-- "leap.nvim",
	-- "mini.ai",
	-- "mini.comment",
	-- "mini.move",
	-- "mini.pairs",
	-- "nvim-treesitter",
	-- "nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",
	-- "vim-repeat",
	-- "yanky.nvim",

	-- Extra
	"unblevable/quick-scope",
	"easymotion/vim-easymotion",
	-- "machakann/vim-sandwich",
	-- "tpope/vim-commentary",
}
