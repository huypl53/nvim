local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({
  ensure_installed = {
    "clangd",
    "dockerls",
    "yamlls",
    "astro",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "html",
    "flow",
    "tsserver",
    "tailwindcss",
    "pyright"

  }
})

lspconfig.setup {
  automatic_installation = true
}
