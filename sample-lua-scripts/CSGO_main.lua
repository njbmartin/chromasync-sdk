-- All functions must sit within a unique class
-- This prevents any conflicts with other lua scripts
CSGO_Example = {}

local Colore = clr.Corale.Colore
local Razer =  Colore.Razer
local Thread = clr.System.Threading.Thread

-- CS:GO Specific fields

local team = "NA"
local _isAnimating = false
local _phase = "NA"
local _activity = "NA"
local _helmet = false

-- FreezeTime Animation
CSGO_Example.FreezeTime = coroutine.create(function ()
	Keyboard.SetAll(Colore.Core.Color.Pink)
	while true do
		_isAnimating = true
		if _phase == "live" then
			
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		--Keyboard.SetAll(Colore.Core.Color.Pink)
		Keyboard.SetKey(Razer.Keyboard.Key.Escape, Colore.Core.Color.White)
		Thread.Sleep(200)
		--Keyboard.SetAll(Colore.Core.Color.Blue)
		Keyboard.SetKey(Razer.Keyboard.Key.Escape, Colore.Core.Color.Black)
		Thread.Sleep(200)
	end
end)


function CSGO_Example.RoundHandler(round)
	if round["phase"] ~= _phase then
		--DebugLua("phase changed: " .. round["phase"])
		_phase = round["phase"]
	end
	
	if _phase == "freezetime" then -- Check if Phase is FreezeTime
		--DebugLua("phase is now freezetime")
		coroutine.resume(CSGO_Example.FreezeTime)
	end
end


function CSGO_Example.PlayerHandler(player)
	if player["activity"] ~= _activity then
		_activity = player["activity"]
				
		if _activity == "menu" then
			Keyboard.SetAll(Colore.Core.Color.White)
		else
			CSGO_Example.SetTeam(player["team"])
		end
	end
	DebugLua("helmet: " .. player["state"]["helmet"])
	if player["state"]["helmet"] ~= _helmet then
		_helmet = player["state"]["helmet"]
		if _helmet then
			CSGO_Example.SetTeam(_team)
		else
			Keyboard.SetAll(Colore.Core.Color.Red)
		end
	end

end


function CSGO_Example.SetTeam(team)
	_team = team
	if _team == "CT" then
		Keyboard.SetAll(Colore.Core.Color.Blue)
	else
		Keyboard.SetAll(Colore.Core.Color(255,255,255))
	end
end

-- our main function to handle the data 
function CSGO_Example.handleData(json)	
	-- Get the current phase (if any)
	
	player = json["player"]
	DebugLua("Got player data")
	CSGO_Example.PlayerHandler(player)
	
	round = json["round"]
	CSGO_Example.RoundHandler(round)
	
	
	--phase = json["round"]["phase"]
	--CSGO_Example.PhaseHandler(phase)
	
end

-- Finally, we must register this script in order to receive data
RegisterForEvents("Counter-Strike: Global Offensive", CSGO_Example.handleData)
