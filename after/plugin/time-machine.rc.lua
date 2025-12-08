local status, time_machine = pcall(require, "time-machine")
if (not status) then return end

time_machine.setup({
  split_opts = {
    split = "left", -- where to open the tree panel
    width = 25,     -- columns number
  },
  float_opts = {
    width = 0.8,  -- between 0 and 1
    height = 0.8, -- between 0 and 1
    winblend = 1,
  },
  diff_tool = "native", -- default diff engine
  native_diff_opts = {  -- only used when diff_tool is "native"
    result_type = "unified",
    ctxlen = 3,
    algorithm = "histogram",
  },
  external_diff_args = {}, -- set additional arguments for external diff tools
  keymaps = {
    undo = "u",
    redo = "<C-r>",
    restore_undopoint = "<CR>",
    refresh_timeline = "r",
    preview_sequence_diff = "p",
    tag_sequence = "t",
    close = "q",
    help = "g?",
    toggle_current_timeline = "c",
  },
  ignore_filesize = nil, -- e.g. 10 * 1024 * 1024
  ignored_filetypes = {
    "terminal",
    "nofile",
    "time-machine-list",
    "mason",
    "snacks_picker_list",
    "snacks_picker_input",
    "snacks_dashboard",
    "snacks_notif_history",
    "lazy",
  },
  time_format = "relative", -- "pretty"|"relative"|"unix"
  log_level = vim.log.levels.WARN,
  log_file = vim.fn.stdpath("cache") .. "/time-machine.log",
}
)

vim.keymap.set("n", "<leader>ct", "<cmd>TimeMachineToggle<cr>", { desc = "[Time Machine] Toggle Tree" })
vim.keymap.set("n", "<leader>cl", "<cmd>TimeMachineLogShow<cr>", { desc = "[Time Machine] Show log" })
