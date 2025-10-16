local status, codecompanion = pcall(require, "codecompanion")
if (not status) then return end

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "gemini",
    },
    inline = {
      adapter = "copilot",
    },
    cmd = {
      adapter = "gemini",
    }
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        make_slash_commands = true,
        show_result_in_chat = true
      }
    }
  },
  adapters = {
    acp = {
      gemini_cli = function()
        return require("codecompanion.adapters").extend("gemini_cli", {
          commands = {
            default = {
              "gemini",
              "--experimental-acp",
            },
          },
          -- defaults = {
          --   auth_method = "gemini-api-key",
          --   mcpServers = {},
          --   timeout = 20000, -- 20 seconds
          -- },
          -- env = {
          --   GEMINI_API_KEY = "GEMINI_API_KEY",
          -- },
        })
      end,
    },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
