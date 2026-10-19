local economy = import("economy")
local p       = import("prefix")

local M = {}

function M.registerListener(cfg)
    if not cfg or not cfg.blocks then
        return
    end

    events.on("BlockBreak", function(e)
        local status, err = pcall(function()
            local key = tostring(e.block_id)
            local reward = cfg.blocks[key]

            if reward and reward > 0 then
                economy.addBalance(e.player, reward, cfg.max_balance)
                
                local msg = "&a+" .. reward
                msg = p.colorize(msg .. " " .. (cfg.currency or ""))

                player.tip(e.player, msg)
            end
        end)

        if not status then
            log.error("Error en BlockBreak: " .. tostring(err))
        end
    end)
end

return M
