local M = {}

function M.load ()
  local cfg = data.loadYml("config.yml")
  local bals = data.loadJson("bals.json")
  if not bals then
		bals = {}
		data.saveJson("bals.json", bals)
  end
  if not cfg then
    cfg = {
      currency = "$",
      initial_balance = 100,
      max_balance = 1000000
    }
    data.saveYml("config.yml", cfg)
  end

  return cfg
end

return M
