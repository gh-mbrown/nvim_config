vim.pack.add({
    { src = GIT_ROOT .. "nvim-tree/nvim-web-devicons" },
    { src = GIT_ROOT .. "nvim-mini/mini.pick" }
})

local pick = require("mini.pick")
local funcs = require("utils.functions")
local ui_select = vim.ui.select
pick.setup({
    mappings = {
        scroll_down = "<C-d>",
        scroll_up = "<C-u>",
        delete_left = "<C-f>"
    },
    window = {
        config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)
            return {
                anchor = "NW",
                height = height,
                width = width,
                row = math.floor(0.5 * (vim.o.lines - height)),
                col = math.floor(0.5 * (vim.o.columns - width))
            }
        end
    },
})
vim.ui.select = ui_select

local function cli_pick(opts)
    local command = opts.command
    local post_process = opts.post_process
    local name = opts.name or "CLI Pick"
    local choose = opts.choose
    local choose_marked = opts.choose_marked

    pick.builtin.cli({
        command = command,
        postprocess = post_process
    }, {
        source = {
            name = name,
            choose = choose,
            choose_marked = choose_marked,
        }
    })
end

local function start_pick(opts)
    if not opts.items then return end
    local items = opts.items

    local name = opts.name or "Pick"
    local choose = opts.choose
    local choose_marked = opts.choose_marked
    local preview = opts.preview or pick.default_preview

    pick.start({
        source = {
            items = items,
            name = name,
            choose = choose,
            choose_marked = choose_marked,
            preview = preview,
        }
    })
end

local function get_lsp_items(opts)
    local params = vim.lsp.util.make_position_params(0, "utf-8")
    params.context = {
        includeDeclaration = true
    }

    return vim.iter(vim.lsp.buf_request_sync(0, "textDocument/" .. (opts.type or "definition"), params, 3000))
        :filter(function(x) return x.result end)
        :map(function(x)
            return vim.iter(x.result.uri and { x.result } or x.result)
                :map(function(y)
                    local file_path = vim.uri_to_fname(y.uri or y.targetUri)
                    local range = y.range or y.targetSelectionRange
                    local line = range.start.line + 1
                    local col = range.start.character + 1
                    local ok, lines = pcall(vim.fn.readfile, file_path)
                    local line_text = ok and lines[line] and lines[line]:gsub("^%s+", "") or ""
                    return {
                        text = string.format("%s:%d:%d %s", vim.fn.fnamemodify(file_path, ":~:."), line, col, line_text),
                        path = file_path,
                        lnum = line,
                        col = col,
                    }
                end)
                :totable()
        end)
        :flatten()
        :totable()
end

vim.keymap.set("n", "<leader>pf", function()
    pick.builtin.files({
        tool = "git"
    })
end)
vim.keymap.set("n", "<leader>pr", function()
    pick.builtin.files({
        tool = "rg"
    })
end)
vim.keymap.set("n", "<leader>pg", pick.builtin.grep_live)
vim.keymap.set("n", "<leader>ph", pick.builtin.help)
vim.keymap.set("n", "<leader>pb", function()
    pick.builtin.buffers({
        include_current = false,
    }, {
        source = {
            preview = function(buf_id, item)
                (string.match(item.text, "term://") and funcs.preview_terminal or pick.default_preview)(
                        buf_id, item)
            end
        }
    })
end)
vim.keymap.set("n", "<leader>pt", function()
    cli_pick({
        command = { "tldr", "--list" },
        name = "TLDR",
        choose = function(selection)
            funcs.list_to_buffer(vim.fn.systemlist({ "tldr", selection }))
        end
    })
end)
vim.keymap.set("n", "<leader>pd", function()
    start_pick({
        items = function()
            local dirs = funcs.get_cwd_items({})
            table.insert(dirs, ".")
            table.sort(dirs, function(x, y) return x < y end)
            return dirs
        end,
        name = "Directories",
        choose_marked = function(choice)
            local ok, oil = pcall(require, "oil")
            if ok then oil.open(choice) else vim.cmd.edit(choice) end
        end,
        preview = function(buf_id, item)
            local ok, oil = pcall(require, "oil")
            if ok then
                vim.api.nvim_buf_call(buf_id, function()
                    oil.open(item)
                end)
            else
                vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, funcs.get_cwd_items({
                    path = item,
                    depth = 1,
                    types = {
                        "file",
                        "directory",
                        "link"
                    }
                }))
            end
        end
    })
end)

local function goto_def(choice)
    vim.cmd("normal! m'")
    if vim.fn.bufnr(choice.path) ~= vim.api.nvim_get_current_buf() then
        vim.cmd.edit(choice.path)
    end
    vim.api.nvim_win_set_cursor(0, { choice.lnum, choice.col - 1 })
end
local items = function(type)
    type = { type = type } or {}
    local options = {
        [0] = function(_)
            vim.notify("No " .. (type.type and type.type or "definition") .. " found")
        end,
        [1] = goto_def
    }
    local items = get_lsp_items(type)
    if options[#items] then options[#items](items[1]) else return items end
end
vim.keymap.set("n", "gd", function()
    start_pick({
        items = items(nil),
        name = "Definition",
        choose_marked = goto_def
    })
end)
vim.keymap.set("n", "gr", function()
    start_pick({
        items = items("references"),
        name = "References",
        choose_marked = goto_def,
    })
end)
vim.keymap.set("n", "gi", function()
    start_pick({
        items = items("implementation"),
        name = "Implementations",
        choose_marked = goto_def,
    })
end)

vim.keymap.set("n", "<leader>tq", function()
    local tree_query = funcs.get_treesitter_list({})

    start_pick({
        items = vim.tbl_keys(tree_query),
        name = "Treesitter",
        choose = function(choice)
            if not choice then return end
            start_pick({
                items = tree_query[choice],
                name = choice,
                choose_marked = function(choice2)
                    if not choice2 then return end
                    vim.api.nvim_win_set_cursor(0, { choice2.lnum, choice2.col - 1 })
                end
            })
        end,
        preview = function(buf_id, item)
            vim.api.nvim_buf_set_lines(buf_id, 0, -1, false,
                vim.iter(tree_query[item])
                :map(function(x)
                    return x.text
                end)
                :totable())
        end,
    })
end)

vim.keymap.set("n", "<leader>dd", function ()
    start_pick({
        items = funcs.get_diagnostics({}),
        name = "Diagnostics",
        choose_marked = goto_def
    })
end)
vim.keymap.set("n", "<leader>di", function ()
    start_pick({
        items = funcs.get_diagnostics({
            severity = {
                vim.diagnostic.severity.INFO
            }
        }),
        name = "Diagnostics Info",
        choose_marked = goto_def
    })
end)
vim.keymap.set("n", "<leader>dh", function ()
    start_pick({
        items = funcs.get_diagnostics({
            severity = {
                vim.diagnostic.severity.HINT
            }
        }),
        name = "Diagnostics Hint",
        choose_marked = goto_def
    })
end)
