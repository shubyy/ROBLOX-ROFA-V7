local date = os.date('!*t',os.time())
math.randomseed(tonumber(date.day..date.month..date.year))
local weatherTable = {}
for i = 1, 5 do
	table.insert(weatherTable,0,"Storm")
	table.insert(weatherTable,0,"Snow")
end

for i = 1, 20 do
	table.insert(weatherTable,0,"Heat")
	table.insert(weatherTable,0,"Rain")
	table.insert(weatherTable,0,"Wind")
end

for i = 1, 30 do
	table.insert(weatherTable,0,"Normal")
end

table.sort(weatherTable)
local weather = weatherTable[math.random(0,#weatherTable)]


function rain()
	local rainGui = game.ServerStorage:WaitForChild("RainGUI"):Clone()
	rainGui.RainScript.Disabled = false
	rainGui.Parent = game.StarterGui
end

function storm()
	local rainGui = game.ServerStorage:WaitForChild("RainGUI"):Clone()
	rainGui.RainScript.Disabled = false
	rainGui.Parent = game.StarterGui
	local function spawnThunderAndLightning(sound1, sound2)
		local newSound = sound1:Clone()
		newSound.Parent = workspace
		newSound:Destroy()
		
		local newSound = sound2:Clone()
		newSound.Parent = workspace
		newSound:Destroy()
	end
	
	while wait(math.random(240, 360)) do
		spawnThunderAndLightning(script.LightningSound, script.ThunderSound)
		wait(0.1)
		game.Lighting.Ambient = Color3.new(1, 1, 1)
		wait(0.1)
		game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
		wait(1)
		game.Lighting.Ambient = Color3.new(1, 1, 1)
		wait(0.1)
		game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
		wait(0.05)
		game.Lighting.Ambient = Color3.new(1, 1, 1)
		wait(0.1)
		game.Lighting.Ambient = Color3.fromRGB(103, 48, 31)
	end	
end

function snow()
	game.Lighting.FogColor = Color3.fromRGB(255,255,255)
	game.Lighting.FogEnd = 300
	game.Lighting.Brightness = 3
	local snowGui = game.ServerStorage:WaitForChild("SnowGUI"):Clone()
	snowGui.SnowScript.Disabled = false
	snowGui.Parent = game.StarterGui
end

function heat()
	game.Lighting.OutdoorAmbient = Color3.fromRGB(255,190,0)
	game.Lighting.Brightness = 4
end

function wind()
	local newSound = script.WindSound:Clone()
	newSound.Parent = workspace
end

--weather = "Rain"

--weather = script.Weather.Value

if weather == "Rain" then
	rain()
elseif weather == "Storm" then
	storm()
elseif weather == "Snow" then
	snow()
elseif weather == "Heat" then
	heat()
elseif weather == "Wind" then
	wind()
end