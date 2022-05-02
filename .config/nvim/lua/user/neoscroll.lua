local status_ok, neoscroll = pcall(require, "neoscroll")

if not status_ok then
	return
end

neoscroll.setup({
	mapping = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-e>", "zt", "zz", "zb" },
	hide_cursor = true,
	stop_eof = true,
	use_local_scrolloff = false,
	respect_scrollof = false,
	cursor_scrolls_alone = true,
	easting_function = nil,
	pre_hook = nil,
	post_hook = nil,
})
