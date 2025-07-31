local status, vscode = pcall(require, "vscode")
if not status then
  return
end

local keymap = vim.keymap

local function vscode_bind(mode, keys, command, ...)
  keymap.set(mode, keys, function()
    vscode.call(command)
  end)
end

vscode_bind('n', 'zM', 'editor.foldAll')
vscode_bind('n', 'zR', 'editor.unfoldAll')
vscode_bind('n', 'zc', 'editor.fold')
vscode_bind('n', 'zC', 'editor.foldRecursively')
vscode_bind('n', 'zo', 'editor.unfold')
vscode_bind('n', 'zO', 'editor.unfoldRecursively')
vscode_bind('n', 'za', 'editor.toggleFold')

vscode_bind("n", "gd", "editor.action.revealDefinition")
vscode_bind("n", "gD", "editor.action.goToTypeDefinition")
vscode_bind("n", "gp", "editor.action.peekDefinition")
vscode_bind("n", "gP", "editor.action.peekTypeDefinition")
vscode_bind("n", "sj", "workbench.action.navigateDown")
vscode_bind("n", "sk", "workbench.action.navigateUp")
vscode_bind("n", "sh", "workbench.action.navigateLeft")
vscode_bind("n", "sl", "workbench.action.navigateRight")
vscode_bind("n", "sz", "workbench.action.toggleMaximizeEditorGroup")
vscode_bind("n", "sv", "workbench.action.splitEditorRight")
vscode_bind("n", "ss", "workbench.action.splitEditorDown")
vscode_bind("n", "ga", "editor.action.quickFix")
vscode_bind("n", "gr", "editor.action.rename")
vscode_bind("n", "go", "editor.action.openLink")
vscode_bind("n", "gt", "editor.action.goToTypeDefinition")
vscode_bind("n", "<S-l>", "workbench.action.nextEditorInGroup")
vscode_bind("n", "<S-h>", "workbench.action.previousEditorInGroup")


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
