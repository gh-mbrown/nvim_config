return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		delay = 0,
	},
	keys = {
		{ "<leader>", group = "Commands" },
		{
			"<leader>/",
			function()
				vim.cmd.Telescope("live_grep")
			end,
			desc = "Grep Files",
			mode = "n",
		},
		{
			"<leader>?",
			function()
				vim.cmd.Telescope("keymaps")
			end,
			desc = "Search All Commands",
			mode = "n",
		},
		{
			"<leader>y",
			'"+y',
			desc = "Yank To Clipboard",
			mode = "n",
		},
		{
			"<leader>y",
			'"+y',
			desc = "Yank To Clipboard",
			mode = "v",
		},
		{
			"<leader>m",
			function()
				vim.cmd.Telescope("man_pages")
			end,
			desc = "Search Linux Man Pages",
			mode = "n",
		},
		{
			"<leader>a",
			function()
				vim.cmd.Telescope("autocommands")
			end,
			desc = "Search Autocommands",
			mode = "n",
		},

		-- Buffer Keys
		{ "<leader>b", group = "Buffer" },
		{
			"<leader>bb",
			function()
				vim.cmd.Telescope("buffers")
			end,
			desc = "Show All Buffers",
			mode = "n",
		},
		{
			"<leader>bd",
			vim.cmd.CloseBuffer,
			desc = "Delete Current Buffer",
			mode = "n",
		},

		-- Code/Compile
		{ "<leader>c", group = "Code/Compile" },
		{
			"<leader>ca",
			vim.lsp.buf.code_action,
			desc = "Code Actions",
			mode = "n",
		},
		{
			"<leader>cs",
			function()
				vim.cmd.Telescope("treesitter")
			end,
			desc = "Query Treesitter",
			mode = "n",
		},
		{
			"<leader>cr",
			vim.lsp.buf.rename,
			desc = "Symbol Edit",
			mode = "n",
		},
		{
			"<leader>ch",
			function()
				vim.cmd.Telescope("command_history")
			end,
			desc = "Command History",
			mode = "n",
		},
		{
			"<leader>cb",
			vim.cmd.CMakeBuild,
			desc = "CMake Build",
			mode = "n",
		},
		{
			"<leader>cR",
			vim.cmd.CMakeRun,
			desc = "CMake Run",
			mode = "n",
		},
		{
			"<leader>cg",
			vim.cmd.CMakeGenerate,
			desc = "CMake Generate",
			mode = "n",
		},

		-- Git keys
		{ "<leader>g", group = "Git Commands" },
		{
			"<leader>gb",
			function()
				vim.cmd.Telescope("git_branches")
			end,
			desc = "Find Git Branch",
			mode = "n",
		},
		{
			"<leader>gg",
			vim.cmd.Git,
			desc = "Opens Git Buffer",
			mode = "n",
		},
		{
			"<leader>gD",
			vim.cmd.Gdiffsplit,
			desc = "Opens File Diff",
			mode = "n",
		},
		{
			"<leader>gC",
			function()
				local branch = vim.fn.input("Branch name: ")
				if branch ~= "" then
					vim.cmd.Git("checkout -b " .. branch)
					vim.cmd.Git("push -u origin " .. branch)
				end
			end,
			desc = "Create And Change Branch",
			mode = "n",
		},
		{
			"<leader>gA",
			function()
				vim.cmd.Git("add --all")
			end,
			desc = "Stages All Files",
			mode = "n",
		},
		{
			"<leader>ga",
			function()
				vim.cmd.Git("add " .. vim.fn.expand("%"))
			end,
			desc = "Stage Current File",
			mode = "n",
		},
		{
			"<leader>gc",
			function()
				vim.cmd.Git("commit")
			end,
			desc = "Commit Staged Files",
			mode = "n",
		},
		{
			"<leader>gp",
			function()
				vim.cmd.Git("push")
			end,
			desc = "Push Commited Files",
			mode = "n",
		},
		{
			"<leader>gP",
			function()
				vim.cmd.Git("pull --rebase")
			end,
			desc = "Pull Current Branch",
			mode = "n",
		},
		{
			"<leader>gB",
			function()
				vim.cmd.Git("blame")
			end,
			desc = "Open Blame Buffer",
			mode = "n",
		},
		{
			"<leader>gm",
			function()
				vim.cmd.Git("mergetool")
			end,
			desc = "Opens Merge Tool",
			mode = "n",
		},
		{
			"<leader>gd",
			function()
				vim.cmd.Git("diff")
			end,
			desc = "Opens File Diff",
			mode = "n",
		},
		{
			"<leader>gl",
			function()
				vim.cmd.Git("log")
			end,
			desc = "Opens Commit Log",
			mode = "n",
		},
		{
			"<leader>gu",
			function()
				vim.cmd.Git("restore --staged " .. vim.fn.expand("%"))
			end,
			desc = "Unstages Current File",
			mode = "n",
		},
		{
			"<leader>gU",
			function()
				vim.cmd.Git("restore --staged :/")
			end,
			desc = "Unstages All Files",
			mode = "n",
		},
		{
			"<leader>gr",
			function()
				local file = vim.fn.expand("%")
				local confirm = vim.fn.input("Do you want to restore this file(yes/no): ")
				if confirm == "yes" then
					vim.cmd.Git("restore " .. file)
				end
			end,
			desc = "Restore The Current File",
			mode = "n",
		},
		{
			"<leader>gR",
			function()
				local confirm = vim.fn.input("Do you want to restore ALL files(yes/no): ")
				if confirm == "yes" then
					vim.cmd.Git("restore :/")
				end
			end,
			desc = "Restore All Files",
			mode = "n",
		},
		{
			"<leader>ge",
			function()
				local branch = vim.fn.input("Branch to rebase on: ")
				if branch ~= "" then
					vim.cmd.Git("rebase " .. branch)
				end
			end,
			desc = "Rebase Branch",
		},
		{
			"<leader>gF",
			function()
				vim.cmd.Git("fetch")
			end,
			desc = "Fetch Current Branch",
			mode = "n",
		},
		{
			"<leader>gj",
			":diffget //3<CR>",
			desc = "Git Diff Down 3",
			mode = "n",
		},
		{
			"<leader>gf",
			":diffget //2<CR>",
			desc = "Git Diff Up 2",
			mode = "n",
		},
		{
			"<leader>go",
			function()
				local conflict_pattern = "^<<<<<<< "
				local conflicts = vim.fn.search(conflict_pattern, "n")
				print("Remaining Conflicts: " .. conflicts)
			end,
			desc = "Print Remaining Conflicts",
			mode = "n",
		},
		{
			"<leader>gs",
			function()
				vim.cmd.Telescope("git_status")
			end,
			desc = "Files Changed",
			mode = "n",
		},

		-- Git Stash Keys
		{ "<leader>gS", group = "Git Stash Commands" },
		{
			"<leader>gSp",
			function()
				local message = vim.fn.input("Stash Message: ")
				local file = vim.fn.expand("%")
				vim.cmd.Git("stash push --message '" .. message .. "' " .. file)
			end,
			desc = "Stash Current File",
			mode = "n",
		},
		{
			"<leader>gSl",
			function()
				vim.cmd.Telescope("git_stashes")
			end,
			desc = "List Stashes",
			mode = "n",
		},
		{
			"<leader>gSc",
			function()
				vim.cmd.Git("stash clear")
			end,
			desc = "Clears Stash",
			mode = "n",
		},

		-- Harpoon Keys
		{
			"<leader>h",
			group = "Harpoon",
		},
		{
			"<leader>he",
			vim.cmd.HarpoonToggle,
			desc = "Toggle Harpoon",
			mode = "n",
		},
		{
			"<leader>ha",
			vim.cmd.HarpoonAdd,
			desc = "Add To Harpoon",
			mode = "n",
		},
		{
			"<leader>h1",
			vim.cmd.SelectOne,
			desc = "Select First Harpoon",
			mode = "n",
		},
		{
			"<leader>h2",
			vim.cmd.SelectTwo,
			desc = "Select Two Harpoon",
			mode = "n",
		},
		{
			"<leader>h3",
			vim.cmd.SelectThree,
			desc = "Select Three Harpoon",
			mode = "n",
		},
		{
			"<leader>h4",
			vim.cmd.SelectFour,
			desc = "Select Four Harpoon",
			mode = "n",
		},
		{
			"<leader>h5",
			vim.cmd.SelectFive,
			desc = "Select Five Harpoon",
			mode = "n",
		},
		{
			"<leader>h6",
			vim.cmd.SelectSix,
			desc = "Select Six Harpoon",
			mode = "n",
		},
		{
			"<leader>h7",
			vim.cmd.SelectSeven,
			desc = "Select Seven Harpoon",
			mode = "n",
		},
		{
			"<leader>h8",
			vim.cmd.SelectEight,
			desc = "Select Eight Harpoon",
			mode = "n",
		},
		{
			"<leader>h9",
			vim.cmd.SelectNine,
			desc = "Select Nine Harpoon",
			mode = "n",
		},

		-- Hop/Easymotion Keys
		{
			"<leader>e",
			group = "Hop/Easymotion",
		},
		{
			"<leader>ew",
			vim.cmd.HopWord,
			desc = "Hop Words",
			mode = "n",
		},
		{
			"<leader>ee",
			vim.cmd.HopWordEnd,
			desc = "Hop Words End",
			mode = "n",
		},
		{
			"<leader>ec",
			vim.cmd.HopCamelCase,
			desc = "Hop Camel Case",
			mode = "n",
		},
		{
			"<leader>ef",
			vim.cmd.HopPattern,
			desc = "Hop Pattern",
			mode = "n",
		},
		{
			"<leader>e2",
			vim.cmd.HopChar2,
			desc = "Hop 2 Characters",
			mode = "n",
		},
		{
			"<leader>ea",
			vim.cmd.HopAnywhere,
			desc = "Hop Anywhere",
			mode = "n",
		},

		-- Insert Commands
		{ "<leader>i", group = "Insert" },
		{
			"<leader>ij",
			"m`o<Esc>``",
			desc = "Break Space Below",
			mode = "n",
		},
		{
			"<leader>ik",
			"m`O<Esc>``",
			desc = "Break Space Above",
			mode = "n",
		},

		-- Undotree Keys
		{
			"<leader>u",
			group = "Undotree",
		},
		{
			"<leader>ut",
			vim.cmd.UndotreeToggle,
			desc = "Toggle Undotree",
			mode = "n",
		},

		-- Project keys
		{ "<leader>p", group = "Project" },
		{
			"<leader>pf",
			function()
				vim.cmd.Telescope("find_files")
			end,
			desc = "Find Files",
			mode = "n",
		},
		{
			"<leader>pd",
			function()
				vim.cmd.Telescope("diagnostics")
			end,
			desc = "Project Diagnostics",
			mode = "n",
		},
		{
			"<leader>ph",
			function()
				vim.cmd.Telescope("help_tags")
			end,
			desc = "Find Help",
			mode = "n",
		},
		{
			"<leader>pp",
			function()
				vim.cmd.Telescope("project")
			end,
			desc = "Open Projects",
			mode = "n",
		},

		-- Exit Keys
		{ "<leader>q", group = "Exit" },
		{
			"<leader>qq",
			vim.cmd.Ex,
			desc = "Exit To Dir List",
			mode = "n",
		},

		-- Windows Keys
		{
			"<leader>w",
			group = "Window",
		},
		{
			"<leader>ws",
			vim.cmd.split,
			desc = "Split Window Horizontal",
			mode = "n",
		},
		{
			"<leader>wv",
			vim.cmd.vsplit,
			desc = "Split Window Vertical",
			mode = "n",
		},
		{
			"<leader>wq",
			"<C-w><C-q>",
			desc = "Closes Current Buffer",
			mode = "n",
		},

		-- MISC Keys
		{
			"gd",
			function()
				vim.cmd.Telescope("lsp_definitions")
			end,
			desc = "Goto Definition",
			mode = "n",
		},
		{
			"gr",
			function()
				vim.cmd.Telescope("lsp_references")
			end,
			desc = "Goto References",
			mode = "n",
		},
		{
			"gi",
			function()
				vim.cmd.Telescope("lsp_implementations")
			end,
			desc = "Goto Implementations",
			mode = "n",
		},
		{
			"<",
			"<gv",
			desc = "Move Line Indent Left",
			mode = "v",
		},
		{
			">",
			">gv",
			desc = "Move Line Indent Right",
			mode = "v",
		},
		{
			">",
			">>",
			desc = "Move Line Indent Right",
			mode = "n",
		},
		{
			"<",
			"<<",
			desc = "Move Line Indent Left",
			mode = "n",
		},
		{
			"p",
			"P",
			desc = "Paste",
			mode = "v",
		},
		{
			"<C-n>",
			function()
				vim.cmd("let @/ = ''")
				vim.cmd("nohlsearch")
			end,
			desc = "Clear Search Highlight",
			mode = "n",
		},
		{
			"J",
			":m '>+1<CR>gv=gv",
			desc = "Move Selected Lines Down",
			mode = "v",
		},
		{
			"K",
			":m '<-2<CR>gv=gv",
			desc = "Move Selected Lines Up",
			mode = "v",
		},
		{
			"<C-p>",
			'"*p',
			desc = "Paste From Clipboard",
			mode = "n",
		},
		{
			"<C-p>",
			'"*p',
			desc = "Paste From Clipboard",
			mode = "v",
		},
		{
			"K",
			vim.lsp.buf.hover,
			desc = "Hover",
			mode = "n",
		},
		{
			"J",
			vim.diagnostic.open_float,
			desc = "Diagnostic Float",
			mode = "n",
		},
	},
}
