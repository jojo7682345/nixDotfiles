vim.g.selectedTheme = vim.g.selectedTheme or "evergarden"

local function getThemeConfig(themeName)
	local success, theme = pcall(require, "plugins.themes." .. themeName)
	if not success then
    		vim.notify("Colorscheme " .. themeName .. " not found!", vim.log.levels.ERROR)
    		return
	end
	return theme
end

local theme = getThemeConfig("evergarden")
theme.config = function()
	vim.cmd("colorscheme " ..vim.g.selectedTheme)
end or theme.config
return theme 

