local Colore = clr.Corale.Colore.Core
local Thread = clr.System.Threading.Thread

function play_anim()
	while true do
		-- Everthing should be white (strobe effect!!!!)
		c = Colore.Color.White
		-- set keyboard colour
		Colore.Keyboard.Instance.SetPosition(math.random(0,5), math.random(1,18), c, true)
		-- set mousepad colour
		local custom = NewCustom("mousepad")
		custom.Colors[math.random(0,14)] = c
		custom.Colors[math.random(0,14)] = c
		custom.Colors[math.random(0,14)] = c
		Colore.Mousepad.Instance.SetCustom(custom)
		-- set mouse colour
		local mouseCustom = NewCustom("mouse")		
		mouseCustom.Colors[math.random(0,17)] = c
		mouseCustom.Colors[math.random(0,17)] = c
		mouseCustom.Colors[math.random(0,17)] = c
		Colore.Mouse.Instance.SetCustom(mouseCustom)
		-- set keypad colour
		local keypadCustom = NewCustom("keypad")

		keypadCustom[math.random(0,4),math.random(0,5)] = c
		keypadCustom[math.random(0,4),math.random(0,5)] = c
		keypadCustom[math.random(0,4),math.random(0,5)] = c
		-- WASD
		--keypadCustom[1,2] = c
		--keypadCustom[2,1] = c
		--keypadCustom[2,2] = c
		--keypadCustom[2,3] = c
		Colore.Keypad.Instance.SetCustom(keypadCustom)
		-- We don't want to spam the SDK, so throttle to 50ms
		Thread.Sleep(50)
	end
end

play_anim()
