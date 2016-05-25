local Colore = clr.Corale.Colore
local rgb = Colore.Core.Color
local Razer =  Colore.Razer
local Thread = clr.System.Threading.Thread

local Memory = {
	Keyboard = {
		X = 0,
		Y = 0,
	},
	Color = 0.00,
}

util = {
	maxcolumns = Razer.Keyboard.Constants.MaxColumns, -- The maximum amount of columns we can use, without crashing.
	maxrows = Razer.Keyboard.Constants.MaxRows, -- The maximum amount of rows we can use, without crashing.
}

function randomColor()
	r,g,b = hsvToRgb(math.random(),1,math.random())
	return rgb(r,g,b)
end

function hsvToRgb(h, s, v, a)
  local r, g, b
  local i = math.floor(h * 6);
  local f = h * 6 - i;
  local p = v * (1 - s);
  local q = v * (1 - f * s);
  local t = v * (1 - (1 - f) * s);
  i = i % 6
  if i == 0 then r, g, b = v, t, p
  elseif i == 1 then r, g, b = q, v, p
  elseif i == 2 then r, g, b = p, v, t
  elseif i == 3 then r, g, b = p, q, v
  elseif i == 4 then r, g, b = t, p, v
  elseif i == 5 then r, g, b = v, p, q
  end
  return r * 255, g * 255, b * 255
end

function row(n, colour)
	n = n <= util.maxrows-1 and n >= 0 and n or 0
	for i=0,21 do
		Keyboard[n,i] = colour
	end
end

function column(n, colour)
	n = n <= util.maxcolumns-1 and n >= 0 and n or 0
	for i=0,5 do
		Keyboard[i,n] = colour
	end
end

function fill(colour, fancy)
	if fancy then
		local c = true;
		for i=0,(util.maxcolumns+util.maxrows) do
			for x=0,30 do
				Keyboard[math.random(0,util.maxrows),math.random(0,util.maxcolumns)] = colour
			end
			Thread.Sleep(60)
		end
	end
	Keyboard.SetAll(colour)
end

function play_anim()
	c = rgb;
	-- set the background.
	Keyboard.SetAll(c.Purple) -- Makes the whole keyboard purple.
	Keyboard.SetKey(Razer.Keyboard.Key.Escape, c(255,0,0)) -- Makes the Escape key red. 
	-- For other keys see https://coralestudios.github.io/Colore/docs/_key_8cs.html
	Thread.Sleep(1000) -- This is about a 1 second delay.

	while true do
		local cols = {randomColor(), randomColor(), randomColor(), randomColor()}
		-- set keyboard colour
		for i=0,5 do
			row(i, cols[1])
			Thread.Sleep(60)
		end

		for i=5,0,-1 do
			row(i, cols[2])
			Thread.Sleep(60)
		end

		for i=0,21 do
			column(i, cols[3])
			Thread.Sleep(60)
		end

		for i=21,0,-1 do
			column(i, cols[4])
			Thread.Sleep(60)
		end

		fill(randomColor(), true)
		
		-- We don't want to spam the SDK, so throttle to 50ms
		Thread.Sleep(50)
	end
end

play_anim()
