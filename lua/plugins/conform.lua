return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_fit = {
            ocaml = {
                "ocamlformat"
            },
        },
        formatters = {
            ocamlformat = {
                prepend_args = {
                    "profile=conventional",
                    "indent-after-in=0",
                    "break-infix=fit-or-vertical",
                    "break-separators=before",
                    "break-sequences=true",
                    "break-cases=all",
                    "space-around-variants=false",
                    "space-around-records=false",
                    "let-binding-spacing=compact",
                    "function-indent=4",
                    "function-indent-nested=never",
                    "cases-matching-exp-indent=normal",
                    "cases-exp-indent=4",
                    "type-decl=sparse",
                    "if-then-else=keyword-first",
                    "indicate-nested-or-patterns=unsafe-no",
                    "wrap-comments=false",
                    "parse-docstrings=false",
                    "leading-nested-match-parens=false",
                    "nested-match=wrap",
                    "sequence-style=separator",
                    "disable=false",
                    "wrap-fun-args=false",
                }
            }
        }
    }
}
