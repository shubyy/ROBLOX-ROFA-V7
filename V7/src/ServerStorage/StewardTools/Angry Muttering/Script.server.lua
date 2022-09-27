local tool = script.Parent
local anim = tool:WaitForChild("Wag")
repeat wait() until tool.Parent.Name == "Backpack"
local player = tool.Parent.Parent
local char = player.Character
local debounce = true
local sound = tool:WaitForChild("Sound")

tool.Activated:Connect(function()
	if char and char.Humanoid and debounce then
		debounce = false
		local newsound = sound:Clone()
		newsound.Parent = char.Head
		newsound:Play()
		local face = char.Head:WaitForChild("face")
		local olddecal = face.Texture
		face.Texture = "rbxassetid://210559168"
		local track = char.Humanoid:LoadAnimation(anim)
		track:Play()
		wait(3)
		newsound:Destroy()
		face.Texture = olddecal
		debounce = true
	end
end)