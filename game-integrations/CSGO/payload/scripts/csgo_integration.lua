-- All functions must sit within a unique class
-- This prevents any conflicts with other lua scripts
CSGO_Example = {}

local Colore = clr.Corale.Colore
local Razer =  Colore.Razer
local Thread = clr.System.Threading.Thread


-- Theme Options

local Theme = {
	Colors = {
		None = Colore.Core.Color(20, 20, 20),
		Dead = Colore.Core.Color(255, 0, 0),
		Freeze = Colore.Core.Color(255, 255, 255),
		Lite = Colore.Core.Color(50, 50, 50),
		Menu = Colore.Core.Color(255, 255, 255),
		Counter =   Colore.Core.Color(0, 0, 255),
		Terrorists = Colore.Core.Color(255, 69, 0),
		Health = {
			Low = Colore.Core.Color(60, 0, 0),
			Full = Colore.Core.Color(255, 0, 0)
		},
		Weapon = {
			Inactive = Colore.Core.Color(60, 0, 0),
			Active = Colore.Core.Color(0, 255, 0)
		},
		Armor = {
			Low = Colore.Core.Color(60, 0, 0),
			Full = Colore.Core.Color(255, 255, 255)
		},
		
		Ammo = {
			Low = Colore.Core.Color(60, 0, 0),
			Full = Colore.Core.Color(255, 255, 0)
		}
	}
}

local Colors = {
	Background = Colore.Core.Color(255, 69, 0), 
	One = Colore.Core.Color.Red,
	Two = Colore.Core.Color.Red,
	Three = Colore.Core.Color(255,140,0),
}

-- CS:GO Specific fields

local _team = "NA"
local _isAnimating = false
local _phase = "NA"
local _activity = "NA"
local _helmet = false
local _planted = false
local _flashed = false
local _burning = false



function CSGO_Example.SetAll(color)
	Colore.Core.Chroma.Instance.SetAll(color)
end


function CSGO_Example.SetNumpad(color)

	for x=0,5 do
		for y=15,21 do
			Keyboard[x,y] =  color
		end
	end
	
end

-- FreezeTime Animation
CSGO_Example.FreezeTime = coroutine.create(function ()
local mousepadNumber = 0
	while true do
		_isAnimating = true
		if _phase ~= "freezetime" then
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		--Keyboard.SetAll(Colore.Core.Color.Pink)
		if mousepadNumber > 7 then
			Keyboard.SetKey(Razer.Keyboard.Key.Escape, Theme.Colors.Freeze)
			CSGO_Example.SetNumpad(Theme.Colors.Freeze)
		else
		Keyboard.SetKey(Razer.Keyboard.Key.Escape, Colore.Core.Color.Black)
		CSGO_Example.SetNumpad(Theme.Colors.None)
		end
		Mousepad.SetAll(Theme.Colors.None)
		Mousepad[mousepadNumber] = Theme.Colors.Freeze
		Thread.Sleep(50)		
		
		mousepadNumber = mousepadNumber + 1
		if mousepadNumber >= 15 then
			mousepadNumber = 0
		end
	end
end)

-- Flashed Animation
CSGO_Example.Flashed = coroutine.create(function ()
local mousepadNumber = 0
	while true do
	
		_isAnimating = true
		if _flashed == false then
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		
		if _helmet == false then
            _flashed = false
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		
		--Keyboard.SetAll(Colore.Core.Color.Pink)
		
		CSGO_Example.SetAll(Theme.Colors.Freeze)
		Thread.Sleep(100)
	end
end)

CSGO_Example.Burning = coroutine.create(function ()
	while true do
		_isAnimating = true
		if _burning ~= true then
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()
		end
		
		if _helmet == false then
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		
		-- set keyboard colour
		
		CSGO_Example.SetAll(Theme.Colors.Terrorists)
		
		for x=0,5 do
			Keyboard[math.random(0,6), math.random(0,22)] =  Colors.One
		end
		
		-- set mousepad colour
		Mousepad[math.random(0,15)] = Colors.One

		
		-- set mouse colour		
		Mouse[math.random(0,9), math.random(0,7)] = Colors.One

		
		-- set keypad colour
		
		Keypad[math.random(0,4),math.random(0,5)] = Colors.One
		
		-- We don't want to spam the SDK, so throttle to 50ms
		Thread.Sleep(60)
	end
end)

CSGO_Example.Planted = coroutine.create(function ()
	while true do
		_isAnimating = true
		if _planted ~= "planted" then
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		
		if _helmet == false then
			CSGO_Example.SetTeam(_team)
			_isAnimating = false
			coroutine.yield()		
		end
		
		--Keyboard.SetAll(Colore.Core.Color.Pink)
		Keyboard.SetKey(Razer.Keyboard.Key.D5, Theme.Colors.Dead)
		CSGO_Example.SetNumpad(Theme.Colors.Dead)

		Mousepad.SetAll(Theme.Colors.Dead)
		
		
		Thread.Sleep(500)
		--Keyboard.SetAll(Colore.Core.Color.Blue)
		Keyboard.SetKey(Razer.Keyboard.Key.D5, Theme.Colors.None)
		Mousepad.SetAll(Theme.Colors.None)
		CSGO_Example.SetNumpad(Theme.Colors.None)
		Thread.Sleep(500)
	end
end)

function CSGO_Example.RoundHandler(round)
	if _activity == "playing" then
		if round["phase"] ~= _phase then
			--DebugLua("phase changed: " .. round["phase"])
			_phase = round["phase"]
		end
		
		if round["bomb"] ~= _planted then
			--DebugLua("phase changed: " .. round["phase"])
			_planted = round["bomb"]
		end
		
		
		if _planted == "planted" then -- Check if Phase is FreezeTime
			--DebugLua("phase is now freezetime")
			
			coroutine.resume(CSGO_Example.Planted)
		end
		
		if _phase == "freezetime" then -- Check if Phase is FreezeTime
			--DebugLua("phase is now freezetime")
					coroutine.resume(CSGO_Example.FreezeTime)
		end
	end
	
end
function CSGO_Example.PlayerHandler(player)
	
	if player["activity"] ~= _activity then
		_activity = player["activity"]
				
		if _activity == "menu" then
				_team = "NA"
				_burning = false
		_flashed = false
		_planted = false
		_phase = "NA"
			CSGO_Example.SetAll(Theme.Colors.Terrorists)
			Keyboard.SetKey(Razer.Keyboard.Key.C, Theme.Colors.Menu)
			Keyboard.SetKey(Razer.Keyboard.Key.S, Theme.Colors.Menu)
			Keyboard.SetKey(Razer.Keyboard.Key.G, Theme.Colors.Menu)
			Keyboard.SetKey(Razer.Keyboard.Key.O, Theme.Colors.Menu)
			do return end
		
		end
		
	end
	
	if _activity == "menu" then
		_team = "NA"
		_burning = false
		_flashed = false
		_planted = false
		_phase = "NA"
		do return end
	end
	
	if player["state"]["flashed"] > 0 then
		_flashed = true
		--DebugLua(player["state"]["flashed"])
		coroutine.resume(CSGO_Example.Flashed)
		do return end
	else
		_flashed = false
	end
	
	if player["state"]["burning"] > 0 then
		_burning = true
		--DebugLua(player["state"]["burning"])
		coroutine.resume(CSGO_Example.Burning)
		do return end
	else
		_burning = false
	end

	if player["state"] ~= nil then
		if player["state"]["helmet"] ~= _helmet then
			_helmet = player["state"]["helmet"]
			if _helmet == false then
				CSGO_Example.SetAll(Colore.Core.Color.Red)
				_team = "NA"
			do return end
		end
	end
		
		if _team ~= player["team"] then
			_team = player["team"]
			CSGO_Example.SetTeam(_team)
		end
		
		if (_activity ~="menu" and _helmet) then
			local health = math.ceil((4 / 100) * ConvertInt(player["state"]["health"]))
			for i=1, 4 do
				if health >= i then
					Keyboard[0,6+i]= Theme.Colors.Health.Full
				else
					Keyboard[0,6+i]= Theme.Colors.None
				end
			end
			
			local armor = math.ceil((4 / 100) * ConvertInt(player["state"]["armor"]))
			for i=1, 4 do
				if armor >= i then
					Keyboard[0,10+i]= Theme.Colors.Armor.Full
				else
					Keyboard[0,10+i]= Theme.Colors.None
				end
			end
			
			-- WEAPONS
			
			local Set = {
				One = Theme.Colors.None,
				Two = Theme.Colors.None,
				Three = Theme.Colors.None,
				Four = Theme.Colors.None,
				Five = Theme.Colors.None
			}
			
			for i=0,10 do --pseudocode
				local color = Theme.Colors.None
				--Keyboard[1,1+i]= Theme.Colors.None
				local weapon = player["weapons"]["weapon_" .. i]
    			if weapon ~= nil then
					local type= weapon["type"]
					
					if type == "Pistol" then
						color = Theme.Colors.Weapon.Inactive
						if weapon["state"]== "active" then
							color = Theme.Colors.Weapon.Active
						end
						Set.Two = color
					elseif type == "Knife" then
						color = Theme.Colors.Weapon.Inactive
						if weapon["state"] == "active" then
							color = Theme.Colors.Weapon.Active
						end
						Set.Three = color

					elseif type == "Grenade" then
						color = Theme.Colors.Weapon.Inactive
						if weapon["state"] == "active" then
							color = Theme.Colors.Weapon.Active
						end
						Set.Four = color
					elseif type == "C4" then
						color = Theme.Colors.Weapon.Inactive
						if weapon["state"] == "active" then
							color = Theme.Colors.Weapon.Active
						end
						Set.Five = color
					else
						color = Theme.Colors.Weapon.Inactive
						if weapon["state"] == "active" then
							color = Theme.Colors.Weapon.Active
						end
						Set.One = color
					end
					
					
					-- Current Ammo
					local ammo = weapon["ammo_clip"]
					if (weapon["state"] == "active" and ammo ~= nil) then
						local keyboardTotal = math.ceil((4 / ConvertInt(weapon["ammo_clip_max"])) * ConvertInt(ammo))
						local mouseTotal = math.ceil((7 / ConvertInt(weapon["ammo_clip_max"])) * ConvertInt(ammo))
						local mouseCustom = NewCustom("mouse")
						c = Theme.Colors.Ammo.Full
							
						if (mouseTotal < 3) then
							c = Theme.Colors.Ammo.Low
							
						end
							
						for i=1, 7 do
								
							if(i >= mouseTotal) then
								c = Theme.Colors.None
							end
							
							Mouse[i,0] = c
							Mouse[i,6] = c
							
						end
						
						c = Theme.Colors.Ammo.Full
							
						if (keyboardTotal < 2) then
							c = Theme.Colors.Ammo.Low
							Keyboard.SetKey(Razer.Keyboard.Key.R, Theme.Colors.Menu)
						else
							c = Theme.Colors.Ammo.Full
							Keyboard.SetKey(Razer.Keyboard.Key.R, Theme.Colors.None)
						end
						
						for i=0, 3 do
								
							if(i >= keyboardTotal) then
								c = Theme.Colors.None
							end
							Keyboard[0, 3 + i] = c
						end
						
						
					end
				end
			end
			Keyboard.SetKey(Razer.Keyboard.Key.D1, Set.One)
			Keyboard.SetKey(Razer.Keyboard.Key.D2, Set.Two)
			Keyboard.SetKey(Razer.Keyboard.Key.D3, Set.Three)
			Keyboard.SetKey(Razer.Keyboard.Key.D4, Set.Four)
			Keyboard.SetKey(Razer.Keyboard.Key.D5, Set.Five)
		end
	end
end

function CSGO_Example.SetTeam(team)
		--DebugLua("team: " .. _team)
		
	if _activity ~= "menu" then
		if team == "CT" then
			CSGO_Example.SetAll(Theme.Colors.Counter)
		else
			CSGO_Example.SetAll(Theme.Colors.Terrorists)
		end
		-- WASD
		Keyboard.SetKey(Razer.Keyboard.Key.W, Theme.Colors.Menu)
		Keyboard.SetKey(Razer.Keyboard.Key.A, Theme.Colors.Menu)
		Keyboard.SetKey(Razer.Keyboard.Key.S, Theme.Colors.Menu)
		Keyboard.SetKey(Razer.Keyboard.Key.D, Theme.Colors.Menu)
	
	else
		_team = "NA"
	end
end

-- our main function to handle the data 
function CSGO_Example.handleData(json)	
	-- Get the current phase (if any)
	player = json["player"]
	CSGO_Example.PlayerHandler(player)
	round = json["round"]
	if round ~= nil then
		CSGO_Example.RoundHandler(round)
	end
	--phase = json["round"]["phase"]
	--CSGO_Example.PhaseHandler(phase)

end

-- Finally, we must register this script in order to receive data
RegisterForEvents("Counter-Strike: Global Offensive", CSGO_Example.handleData)