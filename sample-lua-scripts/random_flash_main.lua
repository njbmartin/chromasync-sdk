local Colore = clr.Corale.Colore.Core
local Thread = clr.System.Threading.Thread

function play_anim()
	while true do
		-- Everthing should be white (strobe effect!!!!)
		c = Colore.Color.White
		background = Colore.Color.Black
		-- set keyboard colour
		Keyboard.SetPosition(math.random(0,5), math.random(1,18), c, true)
		-- set mousepad colour
		Mousepad.SetAll(background)
		Mousepad[math.random(0,14)] = c
		Mousepad[math.random(0,14)] = c
		Mousepad[math.random(0,14)] = c
		-- set mouse colour
		Mouse.SetAll(background)
		Mouse[math.random(0,17)] = c
		Mouse[math.random(0,17)] = c
		Mouse[math.random(0,17)] = c
	
		-- set keypad colour
		Keypad.SetAll(background)
		Keypad[math.random(0,4),math.random(0,5)] = c
		Keypad[math.random(0,4),math.random(0,5)] = c
		Keypad[math.random(0,4),math.random(0,5)] = c

		-- We don't want to spam the SDK, so throttle to 50ms
		Thread.Sleep(50)
	end
end

play_anim()
