local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

nvimtree.setup({
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      }
    }
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$" }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  on_attach = function(bufnr)
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    local ok, api = pcall(require, "nvim-tree.api")
    assert(ok, "api module is not found")
    local mappings = {
      -- BEGIN_DEFAULT_ON_ATTACH
      ["<C-]>"] = { api.tree.change_root_to_node, "CD" },
      ["<C-e>"] = { api.node.open.replace_tree_buffer, "Open: In Place" },
      ["<C-k>"] = { api.node.show_info_popup, "Info" },
      ["<C-r>"] = { api.fs.rename_sub, "Rename: Omit Filename" },
      ["<C-t>"] = { api.node.open.tab, "Open: New Tab" },
      ["<C-v>"] = { api.node.open.vertical, "Open: Vertical Split" },
      ["<C-x>"] = { api.node.open.horizontal, "Open: Horizontal Split" },
      ["<BS>"] = { api.node.navigate.parent_close, "Close Directory" },
      ["<CR>"] = { api.node.open.edit, "Open" },
      ["<Tab>"] = { api.node.open.preview, "Open Preview" },
      [">"] = { api.node.navigate.sibling.next, "Next Sibling" },
      ["<"] = { api.node.navigate.sibling.prev, "Previous Sibling" },
      ["."] = { api.node.run.cmd, "Run Command" },
      ["-"] = { api.tree.change_root_to_parent, "Up" },
      ["a"] = { api.fs.create, "Create" },
      ["bmv"] = { api.marks.bulk.move, "Move Bookmarked" },
      ["B"] = { api.tree.toggle_no_buffer_filter, "Toggle No Buffer" },
      ["c"] = { api.fs.copy.node, "Copy" },
      ["C"] = { api.tree.toggle_git_clean_filter, "Toggle Git Clean" },
      ["[c"] = { api.node.navigate.git.prev, "Prev Git" },
      ["]c"] = { api.node.navigate.git.next, "Next Git" },
      ["d"] = { api.fs.remove, "Delete" },
      ["D"] = { api.fs.trash, "Trash" },
      ["E"] = { api.tree.expand_all, "Expand All" },
      ["e"] = { api.fs.rename_basename, "Rename: Basename" },
      ["]e"] = { api.node.navigate.diagnostics.next, "Next Diagnostic" },
      ["[e"] = { api.node.navigate.diagnostics.prev, "Prev Diagnostic" },
      ["F"] = { api.live_filter.clear, "Clean Filter" },
      ["f"] = { api.live_filter.start, "Filter" },
      ["g?"] = { api.tree.toggle_help, "Help" },
      ["gy"] = { api.fs.copy.absolute_path, "Copy Absolute Path" },
      ["H"] = { api.tree.toggle_hidden_filter, "Toggle Dotfiles" },
      ["I"] = { api.tree.toggle_gitignore_filter, "Toggle Git Ignore" },
      ["J"] = { api.node.navigate.sibling.last, "Last Sibling" },
      ["K"] = { api.node.navigate.sibling.first, "First Sibling" },
      ["m"] = { api.marks.toggle, "Toggle Bookmark" },
      ["o"] = { api.node.open.edit, "Open" },
      ["O"] = { api.node.open.no_window_picker, "Open: No Window Picker" },
      ["p"] = { api.fs.paste, "Paste" },
      ["P"] = { api.node.navigate.parent, "Parent Directory" },
      ["q"] = { api.tree.close, "Close" },
      ["r"] = { api.fs.rename, "Rename" },
      ["R"] = { api.tree.reload, "Refresh" },
      -- ["s"] = { api.node.run.system, "Run System" },
      ["S"] = { api.tree.search_node, "Search" },
      ["U"] = { api.tree.toggle_custom_filter, "Toggle Hidden" },
      ["W"] = { api.tree.collapse_all, "Collapse" },
      ["x"] = { api.fs.cut, "Cut" },
      ["y"] = { api.fs.copy.filename, "Copy Name" },
      ["Y"] = { api.fs.copy.relative_path, "Copy Relative Path" },
      ["<2-LeftMouse>"] = { api.node.open.edit, "Open" },
      ["<2-RightMouse>"] = { api.tree.change_root_to_node, "CD" },
      -- END_DEFAULT_ON_ATTACH

      -- Mappings migrated from view.mappings.list
      ["l"] = { api.node.open.edit, "Open" },
      ["<CR>"] = { api.node.open.edit, "Open" },
      ["o"] = { api.node.open.edit, "Open" },
      ["h"] = { api.node.navigate.parent_close, "Close Directory" },
      ["v"] = { api.node.open.vertical, "Open: Vertical Split" },
      ["C"] = { api.tree.change_root_to_node, "CD" },
    }

    for keys, mapping in pairs(mappings) do
      vim.keymap.set("n", keys, mapping[1], opts(mapping[2]))
    end

    vim.cmd [[  hi clear NvimTreeNormal  ]]
  end
})

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>o', '<cmd>NvimTreeToggle<CR>', opts)
vim.keymap.set('n', '<leader>p', '<cmd>NvimTreeFindFile<CR>', opts)
