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
    "cssmodules_ls",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "html",
    "flow",
    "tsserver",
    "pyright",
    "prisma-language-server",
    "gopls"
  }
})

lspconfig.setup {
  automatic_installation = true
}
