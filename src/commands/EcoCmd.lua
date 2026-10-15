local economy = import ("economy")
local p = import ("prefix")
local M = {}

function M.register (cfg)
	commands.register("eco", {
		description = "Administra el dinero de los jugadores.",
		usage = "/eco <give|take|set> <jugador> <cantidad>",
		premission = "op",
	}, function (sender, args)

		-- Asumo que la API maneja los permisos en y de los comandos.
		-- (Veasé: https://docs-cursestone.readthedocs.io/en/latest/plugins-es.html#permisos)
		-- en caso de que **NO** se manejen los permisos automaticamente, puedes
		-- hacerlo manual:
			if not sender.isOp then -- o player.hasPermission(sender, "yourNode")
				commands.reply(sender, p.colorize("&c¡No tienes permiso para usar este comando!"))
				return
			end
		
			if #args < 3 then
				commands.reply(sender, p.colorize("&cUso: /eco <give|take|set> <jugador> <cantidad>"))
				return
			end

			--https://www.lua.org/manual/5.4/manual.html#pdf-string.lower
			local action = string.lower(args[1]) -- gave|take|set
			local target = args[2]
			local amount = tonumber(args[3])

			if not amount or amount < 0 then
				commands.reply(sender, p.colorize("&cCantidad inválida."))
				return
			end

			if action == "give" then
				economy.addBalance(target, amount, cfg.max_balance)
				commands.reply(sender, p.prefix("Se han añadido &a" .. amount .. " " .. cfg.currency .. "&e a " .. target))
			elseif action == "take" then
				economy.removeBalance(target, amount)
				-- TODO: Verificar errores en caso de que la función retorne false.
				commands.reply(sender, p.prefix("Se han descontado &c" .. amount .. " " .. cfg.currency .. "&e a " .. target))
			elseif action == "set" then
				economy.setBalance(target, amount)
				commands.reply(sender, p.prefix("El balance de " .. target .. " ahora es &a" .. amount .. " " .. cfg.currency))
			else
				commands.reply(sender, p.colorize("&cAcción desconocida. Usa: give, take, set"))
			end
	end)
end

return M







