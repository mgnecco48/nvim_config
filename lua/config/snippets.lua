local ls = require("luasnip")

-- Active helpers used by the snippets below.
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Reference helpers kept nearby for future snippet work.
local sn = ls.snippet_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

for _, ft in ipairs({ "sql", "mysql", "postgres", "postgresql", "psql", "plsql", "sqlite" }) do
  ls.add_snippets(ft, {
    s("S", fmt("SELECT {} FROM {}\nWHERE {} = {};", { i(1, "*"), i(2, "<table>"), i(3, "<field>"), i(4, "<value>") })),
  })
end

ls.add_snippets("lua", {
  s("key", fmt('vim.keymap.set("{}", "{}", "<cmd>{}<CR>")', { i(1, "n"), i(2), i(3) })),
  s("ret", fmt("return {{\n  {}\n}}", { i(1) })),
})

ls.add_snippets("java", {
  s(
    "jam",
    fmt(
      "public class <> {\n  public static void main(String[] args) {\n    <>\n  }\n}",
      { i(1, "ClassName"), i(2) },
      { delimiters = "<>" }
    )
  ),
})
