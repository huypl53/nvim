local status, codecompanion = pcall(require, "codecompanion")
if (not status) then return end

codecompanion.setup({
  opts = {
    log_level = "TRACE", -- or "TRACE"
  },
  strategies = {
    chat = {
      -- adapter = "gemini",
      adapter = "claude_code",
    },
    inline = {
      adapter = "codex",
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
    },
  },
  adapters = {
    acp = {
      gemini_cli = function()
        return require("codecompanion.adapters").extend("gemini_cli", {
          commands = {
            default = {
              "gemini",
              "-m", "gemini-flash-latest",
              "--experimental-acp",
            },
          },
          defaults = {
            auth_method = "gemini-api-key",
            -- mcpServers = {},
            timeout = 20000, -- 20 seconds
          },
          env = {
            GEMINI_API_KEY = 'cmd: gpg --batch --quiet --decrypt /home/shen/.secret/gemini_key.gpg',
          },
        })
      end,
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = 'cmd: gpg --batch --quiet --decrypt /home/shen/.secret/claude_key.gpg',
          },
        })
      end,
      codex = function()
        return require("codecompanion.adapters").extend("codex", {
          defaults = {
            auth_method = "openai-api-key", -- "openai-api-key"|"codex-api-key"|"chatgpt"
          },
        })
      end,
    },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<leader>cs", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
