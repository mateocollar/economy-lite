local economy = import ("economy")
local p       = import ("prefix")
local M       = {}

local LIMIT = 10

function M.register (cfg)
	commands.register("topcoins", {
		description = "Muestra el top " .. LIMIT .. " de jugadores con más dinero",
		usage = "/topcoins",
	}, function (sender, args)

		if sender.isConsole then
			commands.reply(sender, p.colorize("&cUsa este comando en el juego."))
			return
		end

		local top = economy.getTop(LIMIT)

		if #top == 0 then
			commands.reply(sender, p.colorize("&cNo hay jugadores con balance todavía."))
			return
		end

		commands.reply(sender, p.prefix("&6Top " .. #top .. " de " .. cfg.currency .. ":"))

		for i, entry in ipairs(top) do
				local line = string.format("&e%2d. &f%-20s &a%d %s",
					i, entry.name, entry.coins, cfg.currency)
				commands.reply(sender, p.colorize(line))
		end
	end)
end	

return M
