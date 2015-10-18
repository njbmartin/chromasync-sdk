-- All functions must sit within a unique class
-- This prevents any conflicts with other lua scripts
CSGO_Example = {}

local colore = clr.Corale.Colore.Core
local keyboard = colore.Keyboard.Instance
local thread = clr.System.Threading.Thread

-- CS:GO Specific fields

local team = "NA"
local _isAnimating = false
local _phase = "NA"

-- FreezeTime Animation
CSGO_Example.FreezeTime = coroutine.create(function ()
	while true do
		_isAnimating = true
		if phase ~= "freezetime" then
		_isAnimating = false
			coroutine.yield()			
		end
		keyboard.SetAll(colore.Color(255,0,0))
		thread.Sleep(200)
		keyboard.SetAll(colore.Color(0,0,255))
		thread.Sleep(200)
	end
end)


function CSGO_Example.PhaseHandler(phase)

	if phase == "freezetime" then -- Check if Phase is FreezeTime
		coroutine.resume(CSGO_Example.FreezeTime)
	end
end

-- our main function to handle the data 
function CSGO_Example.handleData(json)	

	-- Get the current phase (if any)
	phase = json["round"]["phase"].ToString()
	PhaseHandler(phase)
end

-- Finally, we must register this script in order to receive data
RegisterForEvents("Counter-Strike: Global Offensive", CSGO_Example.handleData)
