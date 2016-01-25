Minecraft_Example = {}

local colore = clr.Corale.Colore.Core
-- local keyboard = colore.Keyboard.Instance
local thread = clr.System.Threading.Thread

local background_color = colore.Color.Black
local isRaining = false
local time = 12000

local showingBackground = false
local showingDeathBackground = false
local showingFireBackground = false

local fireColors = {colore.Color.Orange, colore.Color.Yellow, colore.Color(255, 55, 0), colore.Color(255, 136, 0), colore.Color(255, 196, 0)}

Minecraft_Example.GenerateBackground = coroutine.create(function ()
        while true do
            if showingBackground == false then 
                Keyboard.SetAll(background_color)
                Mouse.SetAll(background_color)
                Mousepad.SetAll(background_color)
                coroutine.yield() 
            end
            local timeconvert = math.ceil((254 / 23999) * ConvertInt(time))
            c = colore.Color(timeconvert, 0, 255-timeconvert);
            for x = 0, 17 do
                Keyboard[5, x] = c
                Keyboard[4, x] = c
            end
        
            thread.Sleep(25)
        end
    end)

Minecraft_Example.HandleDeath = coroutine.create(function ()
        while true do
            local time = 0
            while time < 255 do
                if showingDeathBackground == false then 
                    Keyboard.SetAll(background_color)
                    Mouse.SetAll(background_color)
                    Mousepad.SetAll(background_color)
                    coroutine.yield() 
                end
                c = colore.Color((254 - time),0,0)
                Keyboard.SetAll(c)
                Mouse.SetAll(c)
                Mousepad.SetAll(c)
                
                time = time + 1
                thread.Sleep(2)
            end
        end
    end)

Minecraft_Example.HandleFire = coroutine.create(function ()
        while true do
            if showingFireBackground == false then 
                Keyboard.SetAll(background_color)
                Mouse.SetAll(background_color)
                Mousepad.SetAll(background_color)
                coroutine.yield() 
            end
            
            -- local randomInt = math.random(4)
            
            Keyboard.SetAll(colore.Color.Red)
            for x=0, 21 do
                local height = math.random(5)
                for y=0, height do
                    randomInt = math.random(4)
                    c = fireColors[randomInt]
                    Keyboard[5-y,x] = c
                end
            end
            Mouse.SetAll(colore.Color.Red)
            for i=0, 6 do
                local height = math.random(4, 5)
                
                if(i < height) then
                    randomInt2 = math.random(4)
                    c = fireColors[randomInt2]
                    Mouse[17 - i] = c
                    Mouse[10 - i] = c
                end
            end
            Mousepad.SetAll(colore.Color.Red)
            for i=0, 13 do	
                randomInt2 = math.random(4)
                c = fireColors[randomInt2]
                Mousepad[i] = c
            end
            thread.Sleep(100)
        end
    end)

function Minecraft_Example.SetAll(color)
	for x=0,5 do
		for y=0,21 do
			Keyboard[x,y] = color
		end
	end
end

function Minecraft_Example.HandleHealth(json)
    --keyboard.SetAll(colore.Color(255,0,0))
    local healthTotal = math.ceil((12 / ConvertInt(json["player"]["maxhealth"])) * ConvertInt(json["player"]["health"]))
    for i=1, 12 do
        c = colore.Color.Red
        if (i >= 5) then
            c = colore.Color.Orange
        end
        if (i >= 9) then
            c = colore.Color.Green
        end
        if i > healthTotal then
            c = background_color
        end
        Keyboard[0,i + 2] = c

    end
    
    local healthTotal2 = math.ceil((6 / ConvertInt(json["player"]["maxhealth"])) * ConvertInt(json["player"]["health"]))
    for i=0, 6 do
        c = colore.Color.Red
        
        if(i < 2) then
            if(i < healthTotal2) then
                Mouse[2] = colore.Color.Red
            end
        end
        if (i > 2) then
            c = colore.Color.Orange
        end
        if (i > 4) then
            if (i <= healthTotal2+1) then
                Mouse[1] = colore.Color.Green
            else
                Mouse[1] = colore.Color.Black
            end
            c = colore.Color.Green
        end

        if(i > healthTotal2) then
            c = colore.Color.Black
        end

        Mouse[17 - i] = c
        Mouse[10 - i] = c
    end
    
    local healthTotal3 = math.ceil((8 / ConvertInt(json["player"]["maxhealth"])) * ConvertInt(json["player"]["health"]))
    for i=0, 7 do	
        c = colore.Color.Red
        if (i > 2) then
            c = colore.Color(255, 140, 0)
            end
        if (i > 5) then
            c = colore.Color.Green
            end
        if i >= healthTotal3 then
            c = colore.Color.Black
        end
        Mousepad[7+i] = c
        Mousepad[7-i] = c
    end
end
function Minecraft_Example.HandleHotbar(json)
    for i=1, 9 do
        c = colore.Color.Blue
        if (i-1 == ConvertInt(json["player"]["hotbar"]["selected"])) then
            c = colore.Color.White
        end
        Keyboard[1,i + 1] = c
    end
end
function Minecraft_Example.HandlePotions(json)
    for i=0, 8 do
        c = background_color
        if #json["player"]["potioneffects"] > 0 then
            if i < #json["player"]["potioneffects"] then
                local effect = json["player"]["potioneffects"][i]
                local colors = effect["color"]

                local red = ConvertInt(colors["r"])
                local green = ConvertInt(colors["g"])
                local blue = ConvertInt(colors["b"])

                -- DebugLua(i .. ": " .. effect["name"] .. "  R: " .. red .. " G: " .. green .. " B: " .. blue)

                c = colore.Color (red,green,blue)

            end
        end

        local x = 0;
        local y = 0;

        if i == 0 then
            x = 0;
            y = 0;
        end
        if i == 1 then
            x = 1;
            y = 0;
        end
        if i == 2 then
            x = 2;
            y = 0;
        end
        if i == 3 then
            x = 0;
            y = 1;
        end
        if i == 4 then
            x = 1;
            y = 1;
        end
        if i == 5 then
            x = 2;
            y = 1;
        end
        if i == 6 then
            x = 0;
            y = 2;
        end
        if i == 7 then
            x = 1;
            y = 2;
        end
        if i == 8 then
            x = 2;
            y = 2;
        end
        Keyboard[2+y,18+x] = c
    end
end
function Minecraft_Example.HandleKeys(json)	
    c = colore.Color.Green
    Keyboard[2,3] = c
    Keyboard[3,3] = c
    Keyboard[3,2] = c
    Keyboard[3,4] = c
    Keyboard[2,6] = c
end

-- our main function to handle the data 
-- JSON Container format: https://gist.github.com/MusicalCreeper01/12c340c532501cd67e1e
function Minecraft_Example.handleData(json)	
    time = json["player"]["time"]
    isRaining = json["player"]["raining"]
    if json["player"]["isDead"] == true then
        showingDeathBackground = true
        showingFireBackground = false
        showingBackground = false
        if coroutine.status(Minecraft_Example.HandleDeath) ~= "running" then
            coroutine.resume(Minecraft_Example.HandleDeath)
        end
    elseif json["player"]["inFire"] == true then
        showingFireBackground = true
        showingBackground = false
        if coroutine.status(Minecraft_Example.HandleFire) ~= "running" then
            coroutine.resume(Minecraft_Example.HandleFire)
        end
    else
        showingDeathBackground = false
        showingFireBackground = false
        showingBackground = true
        --if coroutine.status(Minecraft_Example.GenerateBackground) ~= "running" then
            --coroutine.resume(Minecraft_Example.GenerateBackground)
        --end
        Minecraft_Example.HandleHealth(json)
        Minecraft_Example.HandleHotbar(json)
        Minecraft_Example.HandlePotions(json)
        Minecraft_Example.HandleKeys(json)
    end
end

-- Finally, we must register this script in order to receive data
RegisterForEvents("Minecraft", Minecraft_Example.handleData)