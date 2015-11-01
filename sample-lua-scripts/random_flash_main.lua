local Colore = clr.Corale.Colore.Core
local Thread = clr.System.Threading.Thread

function play_anim()
	while true do
		-- set mousepad colour
		local custom = NewCustom("mousepad")
		c = Colore.Color.White
		custom.Colors[math.random(0,14)] = c
		Colore.Mousepad.Instance.SetCustom(custom)
		-- set mouse colour
		local mouseCustom = NewCustom("mouse")		
		mouseCustom.Colors[math.random(0,17)] = c
		Colore.Mouse.Instance.SetCustom(mouseCustom)
		-- We don't want to spam the SDK, so throttle to 50ms
		Thread.Sleep(50)
	end
end

play_anim()
