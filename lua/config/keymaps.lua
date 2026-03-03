local wk = require("which-key")

wk.add({
	-- Project search keys
	{ "<leader>p", group = "Project Commands" },
	{
		"<leader>pf",
		function()
			vim.cmd.ProjectFiles()
		end,
		desc = "Find Files",
		mode = "n",
	},
	{
		"<leader>pg",
		function()
			vim.cmd.ProjectGrep()
		end,
		desc = "Grep Files",
		mode = "n",
	},
	{
		"<leader>pb",
		function()
			vim.cmd.ProjectBuffers()
		end,
		desc = "Find Buffers",
		mode = "n",
	},
	{
		"<leader>ph",
		function()
			vim.cmd.ProjectHelp()
		end,
		desc = "Find Help",
		mode = "n",
	},
	{
		"<leader>pt",
		function()
			vim.cmd.ProjectTreesitter()
		end,
		desc = "Query Treesitter",
		mode = "n",
	},

	-- Git keys
	{ "<leader>g", group = "Git Commands" },
	{
		"<leader>gb",
		function()
			vim.cmd.ProjectGitBranches()
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

	-- Git Stash Keys
	{ "<leader>gs", group = "Git Stash Commands" },
	{
		"<leader>gsp",
		function()
			local message = vim.fn.input("Stash Message: ")
			local file = vim.fn.expand("%")
			vim.cmd.Git("stash push --message '" .. message .. "' " .. file)
		end,
		desc = "Stash Current File",
		mode = "n",
	},
	{
		"<leader>gsl",
		function()
			vim.cmd.Git("stash list")
		end,
		desc = "List Stashes",
		mode = "n",
	},
	{
		"<leader>gsP",
		function()
			local stash = vim.fn.input("Stash Name: ")
			vim.cmd.Git("stash pop " .. stash)
		end,
		desc = "Pop Selected Stash",
		mode = "n",
	},
	{
		"<leader>gsc",
		function()
			vim.cmd.Git("stash clear")
		end,
		desc = "Clears Stash",
		mode = "n",
	},

	-- CMake Keys
	{
		"<leader>c",
		group = "CMake Commands",
	},
	{
		"<leader>cb",
		function()
			vim.cmd.CMakeBuild()
		end,
		desc = "Build The CMake File",
		mode = "n",
	},
	{
		"<leader>cr",
		function()
			vim.cmd.CMakeRun()
		end,
		desc = "Run The CMake File",
		mode = "n",
	},
	{
		"<leader>cg",
		function()
			vim.cmd.CMakeGenerate()
		end,
		desc = "Generate CMake File",
		mode = "n",
	},
	{
		"<leader>cd",
		function()
			vim.cmd.CMakeDebug()
		end,
		desc = "Debug The CMake File",
		mode = "n",
	},

	-- DAP UI
	{
		"<leader>u",
		group = "DAP UI Commands",
	},
	{
		"<leader>ue",
		function()
			vim.cmd.DapUiEval()
		end,
		desc = "Open A REPL",
		mode = "n",
	},
	{
		"<leader>uf",
		function()
			vim.cmd.DapUiFloatElement()
		end,
		desc = "Inspect Element",
		mode = "n",
	},

	-- DAP
	{
		"<leader>d",
		group = "DAP Commands",
	},
	{
		"<leader>db",
		function()
			vim.cmd.DapToggleBreakpoint()
		end,
		desc = "Toggle Breakpoint",
		mode = "n",
	},
	{
		"<leader>dc",
		function()
			vim.cmd.DapClearBreakpoints()
		end,
		desc = "Clear All Breakpoints",
		mode = "n",
	},
	{
		"<leader>de",
		function()
			vim.cmd.DapEval()
		end,
		desc = "Open REPL",
		mode = "n",
	},
	{
		"<leader>ds",
		function()
			vim.cmd.DapShowLog()
		end,
		desc = "Open Log",
		mode = "n",
	},
	{
		"<leader>dr",
		function()
			vim.cmd.DapToggleRepl()
		end,
		desc = "Toggle REPL",
		mode = "n",
	},
	{
		"<leader>dk",
		function()
			vim.cmd.DapTerminate()
		end,
		desc = "Kill DAP",
		mode = "n",
	},
	{
		"<leader>dn",
		function()
			vim.cmd.DapNew()
		end,
		desc = "Create New DAP Instance",
		mode = "n",
	},
	{
		"<leader>dd",
		function()
			vim.cmd.DapDisconnect()
		end,
		desc = "Disconnect Current DAP Instance",
		mode = "n",
	},
	{
		"<leader>dC",
		function()
			vim.cmd.DapContinue()
		end,
		desc = "Continue To Next Step",
		mode = "n",
	},
	{
		"<leader>di",
		function()
			vim.cmd.DapStepInto()
		end,
		desc = "Step Into Function",
		mode = "n",
	},
	{
		"<leader>do",
		function()
			vim.cmd.DapStepOver()
		end,
		desc = "Step Over Function",
		mode = "n",
	},
	{
		"<leader>dO",
		function()
			vim.cmd.DapStepOut()
		end,
		desc = "Step Out Of Function",
		mode = "n",
	},
	{
		"<leader>dp",
		function()
			vim.cmd.DapStepOut()
		end,
		desc = "Pause DAP Instance",
		mode = "n",
	},
	{
		"<leader>dr",
		function()
			vim.cmd.DapRestartFrame()
		end,
		desc = "Restart DAP Instance",
		mode = "n",
	},

	-- Harpoon Keys
	{
		"<leader>h",
		group = "Harpoon Commands",
	},
	{
		"<leader>he",
		function()
			vim.cmd.HarpoonToggle()
		end,
		desc = "Toggle Harpoon",
		mode = "n",
	},
	{
		"<leader>ha",
		function()
			vim.cmd.HarpoonAdd()
		end,
		desc = "Add To Harpoon",
		mode = "n",
	},
	{
		"<leader>h1",
		function()
			vim.cmd.SelectOne()
		end,
		desc = "Select First Harpoon",
		mode = "n",
	},
	{
		"<leader>h2",
		function()
			vim.cmd.SelectTwo()
		end,
		desc = "Select Two Harpoon",
		mode = "n",
	},
	{
		"<leader>h3",
		function()
			vim.cmd.SelectThree()
		end,
		desc = "Select Three Harpoon",
		mode = "n",
	},
	{
		"<leader>h4",
		function()
			vim.cmd.SelectFour()
		end,
		desc = "Select Four Harpoon",
		mode = "n",
	},
	{
		"<leader>h5",
		function()
			vim.cmd.SelectFive()
		end,
		desc = "Select Five Harpoon",
		mode = "n",
	},
	{
		"<leader>h6",
		function()
			vim.cmd.SelectSix()
		end,
		desc = "Select Six Harpoon",
		mode = "n",
	},
	{
		"<leader>h7",
		function()
			vim.cmd.SelectSeven()
		end,
		desc = "Select Seven Harpoon",
		mode = "n",
	},
	{
		"<leader>h8",
		function()
			vim.cmd.SelectEight()
		end,
		desc = "Select Eight Harpoon",
		mode = "n",
	},
	{
		"<leader>h9",
		function()
			vim.cmd.SelectNine()
		end,
		desc = "Select Nine Harpoon",
		mode = "n",
	},

	-- Hop Keys
	{
		"<leader>e",
		group = "Hop Commands",
	},
	{
		"<leader>ew",
		function()
			vim.cmd.HopWord()
		end,
		desc = "Hop Words",
		mode = "n",
	},
	{
		"<leader>ee",
		function()
			vim.cmd.HopWordEnd()
		end,
		desc = "Hop Words End",
		mode = "n",
	},
	{
		"<leader>ec",
		function()
			vim.cmd.HopCamelCase()
		end,
		desc = "Hop Camel Case",
		mode = "n",
	},
	{
		"<leader>ef",
		function()
			vim.cmd.HopPattern()
		end,
		desc = "Hop Pattern",
		mode = "n",
	},
	{
		"<leader>e2",
		function()
			vim.cmd.HopChar2()
		end,
		desc = "Hop 2 Characters",
		mode = "n",
	},
	{
		"<leader>ea",
		function()
			vim.cmd.HopAnywhere()
		end,
		desc = "Hop Anywhere",
		mode = "n",
	},

	-- Undotree Keys
	{
		"<leader>u",
		group = "Undotree Commands",
	},
	{
		"<leader>ut",
		function()
			vim.cmd.UndotreeToggle()
		end,
		desc = "Toggle Undotree",
		mode = "n",
	},

	-- Windows Keys
	{
		"<leader>w",
		group = "Window Commands",
	},
	{
		"<leader>w-",
		function()
			vim.cmd.SplitWindowV()
		end,
		desc = "Splits Window Using Tmux Hor",
		mode = "n",
	},
	{
		"<leader>w\\",
		function()
			vim.cmd.SplitWindowH()
		end,
		desc = "Splits Window Using Tmux Vert",
		mode = "n",
	},
	{
		"<leader>wq",
		function()
			vim.cmd.KillPane()
		end,
		desc = "Kills Tmux Pane",
		mode = "n",
	},
	{
		"<leader>wk",
		"<C-w><C-k>",
		desc = "Moves To The Above Buffer",
		mode = "n",
	},
	{
		"<leader>wl",
		"<C-w><C-l>",
		desc = "Moves To The Right Buffer",
		mode = "n",
	},
	{
		"<leader>wj",
		"<C-w><C-j>",
		desc = "Moves To The Below Buffer",
		mode = "n",
	},
	{
		"<leader>wh",
		"<C-w><C-h>",
		desc = "Moves To The Left Buffer",
		mode = "n",
	},
	{
		"<leader>wx",
		"<C-w><C-q>",
		desc = "Closes Current Buffer",
		mode = "n",
	},

	-- MISC Keys
	{
		"gd",
		function()
			vim.cmd.GotoDefintion()
		end,
		desc = "Goto Definition",
		mode = "n",
	},
	{
		"gr",
		function()
			vim.cmd.GotoReferences()
		end,
		desc = "Goto References",
		mode = "n",
	},
	{
		"gi",
		function()
			vim.cmd.GotoImplementations()
		end,
		desc = "Goto Implementations",
		mode = "n",
	},
	{
		"<leader>?",
		function()
			vim.cmd.SearchCommands()
		end,
		desc = "Search All Commands",
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
		":nohlsearch<Bar>:echo<CR>",
		desc = "Clear Search Highlight",
		mode = "n",
	},
	{
		"J",
		"m`o<Esc>``",
		desc = "Break Space Below",
		mode = "n",
	},
	{
		"K",
		"m`O<Esc>``",
		desc = "Break Space Above",
		mode = "n",
	},
	{
		"J",
		":m `>+1<CR>gv=gv",
		desc = "Move Selected Lines Down",
		mode = "v",
	},
	{
		"K",
		":m <-2<CR>gv=gv",
		desc = "Move Selected Lines Up",
		mode = "n",
	},
	{
		"<C-p>",
		'"*p',
		desc = "Paste From Clipboard",
		mode = "n",
	},
	{
		"<leader>y",
		'"+y',
		desc = "Yank To Clipboard",
		mode = "n",
	},
	{
		"<leader>m",
		":Mason<CR>",
		desc = "Open Mason",
		mode = "n",
	},
	{
		"<leader>l",
		":Lazy<CR>",
		desc = "Open Lazy",
		mode = "n",
	},
})
