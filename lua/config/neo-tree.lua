local neoTree = require('neo-tree')

neoTree.setup({
    window = {
        position = "left",
        width = 30,

    },
    default_component_configs = {
        indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
    },
})
