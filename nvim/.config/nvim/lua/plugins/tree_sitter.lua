return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		local languages = {
			"bash",
			"c",
			"cpp",
			"css",
			"dockerfile",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"rust",
			"typescript",
			"vue",
			"yaml",
			"terraform",
			"vim",
			"vimdoc",
		}

		local configs = require("nvim-treesitter")
		configs.setup({
			ensure_installed = languages,
			highlight = { enable = true },
			indent = { enable = true },
			-- 1. Incremental Selection (Your previous <CR> maps)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<c-s>",
					node_decremental = "<BS>",
				},
			},
			-- 2. Textobjects (The "Select", "Move", and "Swap" logic)
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["<leader>nf"] = "@function.outer",
						["<leader>nc"] = "@class.outer",
					},
					goto_previous_start = {
						["<leader>pf"] = "@function.outer",
						["<leader>pc"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = { ["<leader>ns"] = "@parameter.inner" },
					swap_previous = { ["<leader>ps"] = "@parameter.inner" },
				},
			},
		})

		local ts_install_config = require("nvim-treesitter.install")
		local api_config = require("nvim-treesitter.config")
		local already_installed = api_config.get_installed()
		local parsers_to_install = {}

		for _, parser in ipairs(languages) do
			if not vim.tbl_contains(already_installed, parser) then
				table.insert(parsers_to_install, parser)
			end
		end

		if #parsers_to_install > 0 then
			ts_install_config.install(parsers_to_install)
		end

		-- 4. Manual Start Logic (The Autocmd)
		local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if lang and vim.tbl_contains(api_config.get_installed(), lang) then
					vim.treesitter.start(args.buf)
				end
			end,
		})

		-- DevOps Filetype detection
		vim.filetype.add({
			extension = {
				tf = "terraform",
				tfvars = "terraform",
				pipeline = "groovy",
				multibranch = "groovy",
			},
		})
	end,
}
