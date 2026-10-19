local M = {}

local function mergeConfig (default, current)
	for k, v in pairs(default) do
		if current[k] == nil then
			current[k] = v
		elseif type(v) == "table" and type(current[k]) then
			mergeConfig(v, current[k]) -- si es una subtabla
		end
	end
	return current
end

function M.load()
	local defaultConfig = {
		currency = "$",
		initial_balance = 100,
		max_balance = 1000000,
		blocks = {
			["58"] = 60
		}
	}

	local userConfig = data.loadYml("config.yml")

	if not userConfig then
		data.saveYml("config.yml", defaultConfig)
		return defaultConfig
	else
		local updatedConfig = mergeConfig(defaultConfig, userConfig)
		data.saveYml("config.yml", updatedConfig)
		return updatedConfig
	end
end

return M
