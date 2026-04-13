-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- LINKS :
--   > github : https://github.com/nvim-tree/nvim-tree.lua

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ee", ":Neotree toggle reveal position=left<CR>", silent = true, desc = "󰙅 Toggle Explorer" },
		{ "<leader>er", ":Neotree reveal<CR>", silent = true, desc = "󰙅 Reveal in Explorer" },
		{ "<leader>ef", ":Neotree toggle float<CR>", silent = true, desc = "󰙅 Float Explorer" },
		{ "<leader>eg", ":Neotree float git_status<CR>", silent = true, desc = "󰙅 Git Status Explorer" },
	},
	opts = {
		close_if_last_window = false,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
		sort_case_insensitive = false,
		default_component_configs = {
			indent = {
				indent_size = 2,
				padding = 1,
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				expander_collapsed = "",
				expander_expanded = "",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
			},
			git_status = {
				symbols = {
					added = "✚",
					modified = "",
					deleted = "✖",
					renamed = "🅡",
					untracked = "󰞋",
					ignored = "󰈛",
					unstaged = "󰄱",
					staged = "󰄵",
					conflict = "󰕚",
				},
			},
		},
		window = {
			position = "left",
			width = 30,
			mappings = {
				["<space>"] = { "toggle_node", nowait = false },
				["<cr>"] = "open",
				["h"] = "open_split",
				["v"] = "open_vsplit",
				["z"] = "close_all_nodes",
				["q"] = "close_window",
			},
		},
		filesystem = {
			filtered_items = {
				visible = false,
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
				hide_by_name = {
					".DS_Store",
					"thumbs.db",
					"node_modules",
					"__pycache__",
					".git",
					".python-version",
					".venv",
				},
			},
			follow_current_file = {
				enabled = true,
				leave_dirs_open = false,
				always_focus_file = true,
				use_libuv_file_watcher = true,
			},
			group_empty_dirs = false,
			hijack_netrw_behavior = "open_current",
			use_libuv_file_watcher = true,
		},
	},
}
