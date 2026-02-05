local status, telescope = pcall(require, "telescope")

if not status then
  return
end

local Layout = require("nui.layout")
local Popup = require("nui.popup")
local TSLayout = require("telescope.pickers.layout")

local function make_popup(options)
  local popup = Popup(options)
  function popup.border:change_title(title)
    popup.border.set_text(popup.border, "top", title)
  end

  return TSLayout.Window(popup)
end

local actions = require("telescope.actions")
local action_state = require('telescope.actions.state')
local builtin = require("telescope.builtin")
local lga_actions = require("telescope-live-grep-args.actions")

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ["<C-i>"] = actions.file_split,
        ["<C-v>"] = actions.file_vsplit,
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-h>"] = actions.preview_scrolling_right,
        ["<C-l>"] = actions.preview_scrolling_left,
        ["<C-t>"] = actions.file_tab,
        ["<M-k>"] = actions.results_scrolling_up,
        ["<M-j>"] = actions.results_scrolling_down,
        ["<M-l>"] = actions.results_scrolling_right,
        ["<M-h>"] = actions.results_scrolling_left,
      },
      i = {
        ["<C-i>"] = actions.file_split,
        ["<C-v>"] = actions.file_vsplit,
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-h>"] = actions.preview_scrolling_right,
        ["<C-l>"] = actions.preview_scrolling_left,
        ["<C-t>"] = actions.file_tab,
        ["<M-k>"] = actions.results_scrolling_up,
        ["<M-j>"] = actions.results_scrolling_down,
        ["<M-l>"] = actions.results_scrolling_right,
        ["<M-h>"] = actions.results_scrolling_left,
      },
    },
    file_ignore_patterns = { "node_modules", "yarn.lock", "package-lock.json", "build", "dist", ".git/", ".venv" },
    layout_strategy = "flex",
    layout_config = {
      horizontal = {
        size = {
          width = "90%",
          height = "60%",
        },
      },
      vertical = {
        size = {
          width = "90%",
          height = "90%",
        },
      },
    },
    create_layout = function(picker)
      local border = {
        results = {
          top_left = "┌",
          top = "─",
          top_right = "┬",
          right = "│",
          bottom_right = "",
          bottom = "",
          bottom_left = "",
          left = "│",
        },
        results_patch = {
          minimal = {
            top_left = "┌",
            top_right = "┐",
          },
          horizontal = {
            top_left = "┌",
            top_right = "┬",
          },
          vertical = {
            top_left = "├",
            top_right = "┤",
          },
        },
        prompt = {
          top_left = "├",
          top = "─",
          top_right = "┤",
          right = "│",
          bottom_right = "┘",
          bottom = "─",
          bottom_left = "└",
          left = "│",
        },
        prompt_patch = {
          minimal = {
            bottom_right = "┘",
          },
          horizontal = {
            bottom_right = "┴",
          },
          vertical = {
            bottom_right = "┘",
          },
        },
        preview = {
          top_left = "┌",
          top = "─",
          top_right = "┐",
          right = "│",
          bottom_right = "┘",
          bottom = "─",
          bottom_left = "└",
          left = "│",
        },
        preview_patch = {
          minimal = {},
          horizontal = {
            bottom = "─",
            bottom_left = "",
            bottom_right = "┘",
            left = "",
            top_left = "",
          },
          vertical = {
            bottom = "",
            bottom_left = "",
            bottom_right = "",
            left = "│",
            top_left = "┌",
          },
        },
      }

      local results = make_popup({
        focusable = false,
        border = {
          style = border.results,
          text = {
            top = picker.results_title,
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      })

      local prompt = make_popup({
        enter = true,
        border = {
          style = border.prompt,
          text = {
            top = picker.prompt_title,
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal",
        },
      })

      local preview = make_popup({
        focusable = false,
        border = {
          style = border.preview,
          text = {
            top = picker.preview_title,
            top_align = "center",
          },
        },
      })

      local box_by_kind = {
        vertical = Layout.Box({
          Layout.Box(preview, { grow = 1 }),
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col" }),
        horizontal = Layout.Box({
          Layout.Box({
            Layout.Box(results, { grow = 1 }),
            Layout.Box(prompt, { size = 3 }),
          }, { dir = "col", size = "30%" }),
          Layout.Box(preview, { size = "70%" }),
        }, { dir = "row" }),
        minimal = Layout.Box({
          Layout.Box(results, { grow = 1 }),
          Layout.Box(prompt, { size = 3 }),
        }, { dir = "col" }),
      }

      local function get_box()
        local strategy = picker.layout_strategy
        if strategy == "vertical" or strategy == "horizontal" then
          return box_by_kind[strategy], strategy
        end

        local height, width = vim.o.lines, vim.o.columns
        local box_kind = "horizontal"
        if width < 200 then
          box_kind = "vertical"
          if height < 40 then
            box_kind = "minimal"
          end
        end
        return box_by_kind[box_kind], box_kind
      end

      local function prepare_layout_parts(layout, box_type)
        layout.results = results
        results.border:set_style(border.results_patch[box_type])

        layout.prompt = prompt
        prompt.border:set_style(border.prompt_patch[box_type])

        if box_type == "minimal" then
          layout.preview = nil
        else
          layout.preview = preview
          preview.border:set_style(border.preview_patch[box_type])
        end
      end

      local function get_layout_size(box_kind)
        return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
      end

      local box, box_kind = get_box()
      local layout = Layout({
        relative = "editor",
        position = "50%",
        size = get_layout_size(box_kind),
      }, box)

      layout.picker = picker
      prepare_layout_parts(layout, box_kind)

      local layout_update = layout.update
      function layout:update()
        local box, box_kind = get_box()
        prepare_layout_parts(layout, box_kind)
        layout_update(self, { size = get_layout_size(box_kind) }, box)
      end

      return TSLayout(layout)
    end,
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      select_buffer = true,
      respect_gitignore = false,
      path = "%:p:h",
      cwd = telescope_buffer_dir(),
      hidden = { file_browser = false, folder_browser = false },
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd("normal vbd")
          end,
          ["<A-c>"] = fb_actions.create,
          ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<A-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
          ["<bs>"] = fb_actions.backspace,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["g"] = fb_actions.goto_parent_dir,
          ["e"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
        },
      },
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = {
        -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
  },
})

telescope.load_extension("file_browser")
telescope.load_extension("live_grep_args")

-- Copy file paths to clipboard (relative or absolute)
local function copy_paths_and_close(prompt_bufnr, mode)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local selections = picker:get_multi_selection()

  -- if no multi-selection, use the currently selected entry
  if not selections or #selections == 0 then
    local entry = action_state.get_selected_entry()
    if not entry then
      vim.notify("No entry selected", vim.log.levels.WARN)
      return
    end
    selections = { entry }
  end

  local paths = {}
  for _, entry in ipairs(selections) do
    local raw_path = entry.path or entry.filename or entry.value or ""
    local path

    if mode == "absolute" then
      -- Ensure absolute path
      path = vim.fn.fnamemodify(raw_path, ':p')
    elseif mode == "relative" then
      -- Convert to relative path from cwd
      path = vim.fn.fnamemodify(raw_path, ':.')
    else
      path = raw_path
    end

    table.insert(paths, path)
  end

  vim.fn.setreg('+', table.concat(paths, '\n'))

  local msg = #paths == 1
      and string.format("Copied %s: %s", mode, paths[1])
      or string.format("Copied %d %s path(s)", #paths, mode)
  vim.notify(msg, vim.log.levels.INFO)
end

vim.keymap.set("n", ";f", function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
  })
end)
vim.keymap.set("n", ";r", function()
  builtin.live_grep()
end)
vim.keymap.set("n", "\\\\", function()
  builtin.buffers()
end)
-- vim.keymap.set("n", ";t", function()
--   builtin.help_tags()
-- end)
vim.keymap.set("n", ";;", function()
  builtin.resume()
end)
vim.keymap.set("n", ";e", function()
  builtin.diagnostics({ bufnr = 0 })
end)
vim.keymap.set("n", ";E", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
    layout_config = { height = 40 },
    attach_mappings = function(prompt_bufnr, map)
      -- <C-y> for relative paths
      map('i', '<C-y>', function() copy_paths_and_close(prompt_bufnr, "relative") end)
      map('n', '<C-y>', function() copy_paths_and_close(prompt_bufnr, "relative") end)

      -- <C-a> for absolute paths
      map('i', '<C-a>', function() copy_paths_and_close(prompt_bufnr, "absolute") end)
      map('n', '<C-a>', function() copy_paths_and_close(prompt_bufnr, "absolute") end)

      return true
    end,
  })
end, { desc = 'Telescope File browser' })

vim.keymap.set("n", "<leader>/", function()
  builtin.keymaps()
end)

vim.keymap.set("n", ";R", function()
  telescope.extensions.live_grep_args.live_grep_args()
end)
local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'gf', '<Cmd>Telescope lsp_references<CR>', opts)
