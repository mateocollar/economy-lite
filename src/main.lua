local configMgr = import ("config")
local economy   = import ("economy")

-- Commands
local balCmd    = import ("commands.BalCmd")
local payCmd    = import ("commands.PayCmd")
local ecoCmd    = import ("commands.EcoCmd")
local topCmd    = import ("commands.TopCmd")

-- Listeners
local miningRewardL = import ("listeners.MiningRewardListener")

local pluginTable = {}

function pluginTable.onEnable()
	log.info("EconomyLite habilitado.")

	local cfg = configMgr.load()

	-- Commands registry
	balCmd.register(cfg)
	payCmd.register(cfg)
	ecoCmd.register(cfg)
	topCmd.register(cfg)

	-- Listeners registry
	miningRewardL.registerListener(cfg)
end

function pluginTable.onDisable()
	log.info("EconomyLite deshabilitado.")
end

-- TODO: Move to a different file
events.on("PlayerJoin", function(e)
	local cfg = configMgr.load()
	local _ = economy.getBalance(e.player, cfg.initial_balance)
	player.giveItem(e.player, 58, 1)
end)

return pluginTable
