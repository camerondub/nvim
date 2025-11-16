local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    -- Print statement snippet
    s("pr", fmt("print({})", { i(1, '"Hello, world!"') })),

    -- Function definition
    s(
        "def",
        fmt(
            [[
def {}({}):
    {}
]],
            { i(1, "function_name"), i(2, "args"), i(0, "pass") }
        )
    ),

    -- Class definition
    s(
        "cls",
        fmt(
            [[
class {}({}):
    def __init__(self, {}):
        {}
]],
            { i(1, "ClassName"), i(2, "object"), i(3, "args"), i(0, "pass") }
        )
    ),
}
