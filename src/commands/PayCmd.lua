local economy = import ("economy")
local pf = import ("prefix")

local M = {}

function M.register(cfg)
	commands.register("pay", {
		description = "Envía dinero a otro jugador",
		usage = "/pay <jugador> <cantidad>"
	}, function (sender, args)

		if sender.isConsole then
			commands.reply(sender, "Usa este comando en el juego.")
			return
		end

		if #args < 2 then
			commands.reply(sender, pf.colorize("&cUso: /pay <jugador> <cantidad>"))
			return
		end

		-- Las tablas en lua siempre empiezan en indice 1.
		-- Estuve 10 minutos buscando si en la tabla de los argumentos primero iba
		-- el nombre del comando (SPOILER: **NO**)
		local target = args[1]
		local amount = tonumber(args[2])

		if not amount or amount < 0 then
			commands.reply(sender, pf.colorize("&cPor favor introduce una cantidad válida."))
			return
		end

		-- sender es una tabla, por eso podemos acceder a campos dentro de ella.
		if target == sender.name then
			commands.reply(sender, pf.colorize("&c¡No puedes pagarte a tí mismo!"))
			return
		end

		local senderBal = economy.getBalance(sender.name, cfg.initial_balance)
		if senderBal < amount then
			commands.reply(sender, pf.prefix("No tienes dinero suficiente. Tienes:&a " .. senderBal .. " " .. cfg.currency))
			return
		end

		economy.removeBalance(sender.name, amount)
		economy.addBalance(target, amount, cfg.max_balance)

		player.message(target, pf.prefix("Recibiste &a" .. amount .. " " .. cfg.currency .. "&e de " .. sender.name))
		commands.reply(sender, pf.prefix("Has enviado " .. amount .. " " .. cfg.currency .. "&e a " .. target))
	end)
end


return M

