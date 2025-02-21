local handle = io.popen("zsh -c 'source ~/.zshrc && macos_theme'")

if handle == nil then
	error("Failed to run macos_theme")
end

local mode = handle:read("*a")
handle:close()

function SwitchThemeMode(on_light, on_dark)
	return string.find(mode, "Dark") and on_dark or on_light;
end
