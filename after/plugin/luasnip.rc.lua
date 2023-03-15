local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

ls.setup({})
ls.add_snippets('all', {
  s("cra", {
    t({ "import React from 'react';" }),
    t({ "", "", "" }),
    f(function(args, _, _)
      return "const " .. args[1][1] .. " = props => { "

      -- return string.format( [[ const
      -- ]] )

    end, { 1 }),
    t({ "", "\treturn ", }),
    f(function(args, _, _)
      return "<div>" .. args[1][1] .. "</div>;"
    end, { 1 }),
    t({ "", "}", "", "" }),
    t "export default ", i(1), t ';', i(0)
  })
})
