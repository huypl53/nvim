local status, fo = pcall(require, "lsp-file-operations")
if (not status) then return end

fo.setup()
