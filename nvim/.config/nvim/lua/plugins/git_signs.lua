-- github : https://github.com/l
return {
	"lewis6991/gitsigns.nvim",
	opts = {
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, lhs, rhs, opts)
				if type(opts) == "string" then
					opts = { desc = opts }
				end
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, lhs, rhs, opts)
			end

			-- Actions
			map("n", "<leader>gs", gitsigns.stage_hunk, "󰊢 Stage Hunk")
			map("n", "<leader>gr", gitsigns.reset_hunk, "󰊢 Reset Hunk")
			map("v", "<leader>gs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "󰊢 Stage Selection")
			map("v", "<leader>gr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "󰊢 Reset Selection")
			map("n", "<leader>gS", gitsigns.stage_buffer, "󰊢 Stage Buffer")
			map("n", "<leader>gR", gitsigns.reset_buffer, "󰊢 Reset Buffer")
			map("n", "<leader>gu", gitsigns.undo_stage_hunk, "󰊢 Undo Stage Hunk")
			map("n", "<leader>gp", gitsigns.preview_hunk, "󰊢 Preview Hunk")
			map("n", "<leader>gb", function()
				gitsigns.blame_line({ full = true })
			end, "󰊢 Blame Line")
			map("n", "<leader>gd", gitsigns.diffthis, "󰊢 Diff Against Index")
			map("n", "<leader>gD", function()
				gitsigns.diffthis("~")
			end, "󰊢 Diff Against Last Commit")

			-- Toggles
			map("n", "<leader>gt", gitsigns.toggle_current_line_blame, "󰊢 Toggle Blame Line")
			map("n", "<leader>gx", gitsigns.toggle_deleted, "󰊢 Toggle Deleted")

			-- Fugitive
			map("n", "<leader>gg", "<cmd>Git<cr>", "󰊢 Git Status (Fugitive)")

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "󰊢 Select Hunk")
		end,
	},
}
