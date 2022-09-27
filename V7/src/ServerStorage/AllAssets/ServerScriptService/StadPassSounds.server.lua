local cheer = workspace:WaitForChild("Sounds"):WaitForChild("Cheer")
local boo = workspace:WaitForChild("Sounds"):WaitForChild("Boo")
local start = workspace:WaitForChild("Sounds"):WaitForChild("Start")
local re = game.ReplicatedStorage:WaitForChild("Sounds")

local debounce = false

re.OnServerEvent:Connect(function(...)
	local tuple = {...}
	if tuple[2] == "Cheer" then
		if start.IsPlaying == true and start.Volume > 0.2 and debounce == false then
			debounce = true
			cheer.Volume = start.Volume
			cheer:Play()
			wait(15)
			debounce = false
		end
	elseif tuple[2] == "Boo" then
		if start.IsPlaying == true and start.Volume > 0.2 and debounce == false then
			debounce = true
			boo.Volume = start.Volume
			boo:Play()
			wait(15)
			debounce = false
		end
	end
end)