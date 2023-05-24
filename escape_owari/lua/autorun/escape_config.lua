F606_Escape = F606_Escape or {}
F606_Escape.Config = F606_Escape.Config or {}
F606_Escape.Config.Fonts = "Shojumaru"
F606_Escape.Config.Fonts2 = "Shojumaru"
F606_Escape.Config.BackgroundImage = Material("ui/escape/echap4k.png")
F606_Escape.Config.DiscordLink = "https://discord.gg/Kw4Kq7bHP4"
F606_Escape.Config.WorkshopLink = "https://steamcommunity.com/sharedfiles/filedetails/?id=2935976321"
F606_Escape.Config.TextRight = "Yoyo DS"
F606_Escape.Config.ButtonList = {
	[1] = {
		["Name"] = "Reprendre",
		["Function"] = function() F606MainEsc:Close() end
	},
	[2] = {
		["Name"] = "Discord",
		["Function"] = function() gui.OpenURL(F606_Escape.Config.DiscordLink) end
	},
	[3] = {
		["Name"] = "Workshop",
		["Function"] = function() gui.OpenURL(F606_Escape.Config.WorkshopLink) end
	},
	[4] = {
		["Name"] = "Parametres",
		["Function"] = function() RunConsoleCommand("gamemenucommand", "openoptionsdialog") timer.Simple( 0, function() RunConsoleCommand("gameui_activate") end ) end
	},
	[5] = {
		["Name"] = "Se Deconnecter",
		["Function"] = function() RunConsoleCommand("disconnect") end
	}
}