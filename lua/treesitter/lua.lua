return [[
    (variable_declaration
        (assignment_statement
          (variable_list
            name: (identifier) @var)))

    (function_declaration
        name: (identifier) @func)

    (assignment_statement
        (variable_list
            name: (dot_index_expression
                table: (identifier)
                field: (identifier))) @method
        (expression_list
            value: (function_definition)))
]]
