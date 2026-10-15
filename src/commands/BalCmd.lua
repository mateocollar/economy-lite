local economy = import ("economy")
local pf = import ("prefix")
local M = {}

function M.register(cfg)
	commands.register("bal", {
		description = "Muestra tu dinero o el de otro jugador",
		usage = "/bal [jugador]",
	}, function (sender, args)

		if sender.isConsole then
			commands.reply(sender, "Este comando debe usarse dentro del juego.")
			return
		end

		local target = sender.name
		if args[1] and args[1] ~= "" then
			target = args[1]
		end

		local bal
		if target == sender.name then
			bal = economy.getBalance(target, cfg.initial_balance)
		else
			bal = economy.peekBalance(target)
		end

		if bal == nil then
			commands.reply(sender, pf.prefix("&cEl jugador &f" .. target .. " &cno tiene balance registrado."))
		end

		commands.reply(sender, pf.prefix("&fBalance de " .. target .. ": &a" .. bal or 0 .. " " .. cfg.currency))
	end)
end


return M





