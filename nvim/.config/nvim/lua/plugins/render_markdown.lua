require("render-markdown").setup({
	render_modes = { "n" },
	heading = {
		icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
		position = "inline",
		-- backgrounds = { "RenderMarkdownH1Bg" },
		-- foregrounds = { "RenderMarkdownH1" },
	},
	code = {
		border = "thin",
		language_icon = false,
		language_name = false,
	},
	html = { enabled = false },
	latex = { enabled = false },
	yaml = { enabled = false },
})
