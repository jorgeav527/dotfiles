local function is_image_file(name)
	local ext = name:match("^.+%.([^.]+)$")
	if not ext then
		return false
	end

	ext = ext:lower()

	local image_exts = {
		png = true,
		jpg = true,
		jpeg = true,
		gif = true,
		webp = true,
		bmp = true,
		svg = true,
		ico = true,
	}

	return image_exts[ext] == true
end

require("neo-tree").setup({
	hijack_netrw_behavior = "open_default",
	close_if_last_window = true,

	window = {
		width = 30,
		mappings = {
			["<space>"] = "none",

			["<cr>"] = function(state)
				local node = state.tree:get_node()
				if not node then
					return
				end

				-- If it's an image file, preview it in a normal window
				if node.type == "file" and is_image_file(node.name) then
					require("neo-tree.sources.common.commands").toggle_preview(state, {
						use_float = false,
						use_snacks_image = true,
						use_image_nvim = true,
					})
				else
					-- otherwise do the normal open behavior
					require("neo-tree.sources.filesystem.commands").open(state)
				end
			end,

			["l"] = "open",
			["c"] = "close_node",
			["v"] = "open_vsplit",
			["h"] = "open_split",

			["P"] = {
				"toggle_preview",
				config = {
					use_float = false,
					use_snacks_image = true,
					use_image_nvim = true,
				},
			},
		},
	},

	filesystem = {
		filtered_items = {
			show_hidden = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = { enabled = true },
		use_libuv_file_watcher = true,
	},
})
