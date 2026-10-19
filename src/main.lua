local configMgr = import ("config")
local economy   = import ("economy")
local balCmd    = import ("commands.BalCmd")
local payCmd    = import ("commands.PayCmd")
local ecoCmd    = import ("commands.EcoCmd")
local topCmd    = import ("commands.TopCmd")

local pluginTable = {}

function pluginTable.onEnable()
	log.info("EconomyLite habilitado.")

	local cfg = configMgr.load()

	balCmd.register(cfg)
	payCmd.register(cfg)
	ecoCmd.register(cfg)
	topCmd.register(cfg)
end

function pluginTable.onDisable()
	log.info("EconomyLite deshabilitado.")
end

events.on("PlayerJoin", function(player)
	local _ = economy.getBalance(player.name, configMgr.initial_balance)
end)

return pluginTable
