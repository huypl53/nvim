local status, nvim_comment = pcall(require, "Comment")
if (not status) then return end

nvim_comment.setup { pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(), }
