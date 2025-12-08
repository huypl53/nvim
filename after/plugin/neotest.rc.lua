local status, neotest = pcall(require, "neotest")
if (not status) then return end

neotest.setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = { justMyCode = false },
      -- Command line arguments for runner
      -- Can also be a function to return dynamic values
      args = { "--capture", "no", "--log-level", "DEBUG" },
      -- Runner to use. Will use pytest if available by default.
      -- Can be a function to return dynamic value.
      runner = "pytest",
      -- Custom python path for the runner.
      -- Can be a string or a list of strings.
      -- Can also be a function to return dynamic value.
      -- If not provided, the path will be inferred by checking for
      -- virtual envs in the local directory and for Pipenev/Poetry configs
      python = ".venv/bin/python",
      -- Returns if a given file path is a test file.
      -- NB: This function is called a lot so don't perform any heavy tasks within it.
      -- is_test_file = function(file_path)
      --   ...
      -- end,
      -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
      -- instances for files containing a parametrize mark (default: false)
      pytest_discover_instances = true,
    })
  }
})

vim.keymap.set("n", "<leader>nw", function()
  neotest.watch.toggle()
end, { desc = "Neotest toggle watch" })


vim.keymap.set("n", "<leader>nr", function()
  neotest.run.run()
end, { desc = "Neotest run nearest test" })

vim.keymap.set("n", "<leader>nd", function()
  neotest.run.run({ strategy = "dap" })
end, { desc = "Neotest run dap" })

vim.keymap.set("n", "<leader>nf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Neotest run current file" })

vim.keymap.set("n", "<leader>np", function()
  neotest.output_panel.toggle()
end, { desc = "Neotest output panel toggle" })

vim.keymap.set("n", "<leader>nx", function()
  neotest.output_panel.clear()
end, { desc = "Neotest output panel clear" })

vim.keymap.set("n", "<leader>ns", function()
  neotest.summary.toggle()
end, { desc = "Neotest summary" })

vim.keymap.set("n", "<leader>nm", function()
  neotest.summary.run_marked()
end, { desc = "Neotest run marked" })
