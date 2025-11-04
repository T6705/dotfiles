if vim.g.neovide then
	vim.print(vim.g.neovide_version)

	vim.g.neovide_confirm_quit = false
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_fullscreen = false
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_profiler = false
	vim.g.neovide_remember_window_size = true

	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_refresh_rate_idle = 5
	vim.g.neovide_theme = "auto"

	-- vim.g.neovide_opacity = 0.8
	-- vim.g.neovide_normal_opacity = 0.8

	vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end
