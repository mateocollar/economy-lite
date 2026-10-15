-- economy.lua
local M = {}
local DATA_FILE = "bals.json"


-- Internal methods

local function loadBalances()
  local bals = data.loadJson(DATA_FILE)
  if not bals then
    bals = {}
  end
  return bals
end

local function saveBalances(bals)
  data.saveJson(DATA_FILE, bals)
end


-- Public methods

function M.getBalance(playerName, initialDefault)
	local bals = loadBalances()
	if not bals[playerName] then
		bals[playerName] = initialDefault
		saveBalances(bals)
	end
	return bals[playerName]
end

function M.peekBalance (playerName)
	local bals = loadBalances()
	return bals[playerName]
end

function M.setBalance (playerName, amount)
	local bals = loadBalances()
	bals[playerName] = amount
	saveBalances(bals)
end

function M.addBalance (playerName, amount, maxLimit)
	local curr = M.getBalance(playerName, 0)
	local newBalance = curr + amount
	if newBalance > maxLimit then
		newBalance = maxLimit
	end
	M.setBalance(playerName, newBalance)
	return newBalance
end

function M.removeBalance (playerName, amount)
	local curr = M.getBalance(playerName, 0)
	if curr < amount then
		return false
	end
	M.setBalance(playerName, curr - amount)
	return true
end

function M.getTop (limit)
	limit = limit or 10
	local bals = loadBalances()
	local top = {}

	for name, coins in pairs(bals) do
		local i = #top + 1
		top[i] = { name = name, coins = coins }
		while i > 1 and top[i].coins > top[i - 1].coins do
			top[i], top[i - 1] = top[i - 1], top[i]
			i = i - 1
		end
		if #top > limit then
			top[#top] = nil
		end
	end

	return top
end

return M
