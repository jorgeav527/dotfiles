-- ================================================================================================
-- TITLE : gitsigns.nvim
-- ABOUT : Git integration for buffers (signs, hunks, etc.)
-- LINKS :
--   > github : https://github.com/lewis6991/gitsigns.nvim
-- ================================================================================================

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
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
			map("n", "<leader>hs", gitsigns.stage_hunk, "󰊢 Stage Hunk")
			map("n", "<leader>hr", gitsigns.reset_hunk, "󰊢 Reset Hunk")
			map("v", "<leader>hs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "󰊢 Stage Selection")
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "󰊢 Reset Selection")
			map("n", "<leader>hS", gitsigns.stage_buffer, "󰊢 Stage Buffer")
			map("n", "<leader>hR", gitsigns.reset_buffer, "󰊢 Reset Buffer")
			map("n", "<leader>hu", gitsigns.undo_stage_hunk, "󰊢 Undo Stage Hunk")
			map("n", "<leader>hp", gitsigns.preview_hunk, "󰊢 Preview Hunk")
			map("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, "󰊢 Blame Line")
			map("n", "<leader>hd", gitsigns.diffthis, "󰊢 Diff Against Index")
			map("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, "󰊢 Diff Against Last Commit")

			-- Toggles
			map("n", "<leader>ht", gitsigns.toggle_current_line_blame, "󰊢 Toggle Blame Line")
			map("n", "<leader>hx", gitsigns.toggle_deleted, "󰊢 Toggle Deleted")

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "󰊢 Select Hunk")
		end,
	},
}
