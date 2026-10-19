local economy = import ("economy")
local p       = import ("prefix")

local M = {}

function M.registerListener(cfg)
  if not cfg.blocks then
		return
  end

  events.on("BlockBreaks", function (e)
		local key = cfg.blocks[tostring(e.block_id)]
		local reward = cfg.blocks[key]

		if reward and reward > 0 then
			economy.addBalance(e.player, reward, cfg.max_balance)
			player.tip(e.player, p.colorize("&a+" .. reward .. " " .. cfg.currency))
		end
  end)
end

return M
