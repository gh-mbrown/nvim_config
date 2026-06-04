return {
    lua = vim.treesitter.query.parse("lua", [[
        (variable_declaration
            (assignment_statement
              (variable_list
                name: (identifier) @name)))
    ]])
}
