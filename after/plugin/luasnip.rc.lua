local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

ls.setup({})
ls.add_snippets("javascript", {
  s("rcc", {
    t({ "import React from 'react'" }),
    t({ "", "", "" }),
    f(function(args, _, _)
      return "const " .. args[1][1] .. " = () => { "

      -- return string.format( [[ const
      -- ]] )
    end, { 1 }),
    t({ "", "\treturn ", }),
    f(function(args, _, _)
      return "<div>" .. args[1][1] .. "</div>"
    end, { 1 }),
    t({ "", "}", "", "" }),
    t "export default ", i(1), t '', i(0)
  })
})

ls.add_snippets("javascript", {
  s("clo", {
    t("console.log({"), i(1), t("})"), i(0)
  })
})

ls.add_snippets("javascript", {
  s("clo", {
    t("console.log("), i(1), t(")"), i(0)
  })
})

ls.add_snippets("javascript", {
  s("rcs", {
    t({ "\tconst [" }), i(1),
    f(function(args, _, _)
      return ", set" .. FirstToUpper(args[1][1]) .. "] = React.useState("
    end, { 1 }),
    i(2), t({ ")" }), i(0)
  })
})

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascript" })

function FirstToUpper(str)
  return (str:gsub("^%l", string.upper))
end
