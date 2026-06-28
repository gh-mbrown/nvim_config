vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
            if not ev.data.active then vim.cmd.packadd("telescope-fzf-native.nvim") end
            vim.system({ "cmake", "-S.", "-Bbuild", "-DCMAKE_BUILD_TYPE=Release" }, { cwd = ev.data.path }):wait()
            vim.system({ "cmake", "--build", "build", "--config", "Release", "--target", "install" },
            { cwd = ev.data.path }):wait()
        end
    end
})

vim.pack.add({
    { src = GIT_ROOT .. "nvim-lua/plenary.nvim" },
    { src = GIT_ROOT .. "nvim-telescope/telescope-fzf-native.nvim"},
    { src = GIT_ROOT .. "nvim-telescope/telescope.nvim" }
})

local telescope = require("telescope")
local builtin = require("telescope.builtin")
telescope.setup({
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
})
telescope.load_extension("fzf")
vim.keymap.set("n", "<leader>pf", builtin.git_files)
