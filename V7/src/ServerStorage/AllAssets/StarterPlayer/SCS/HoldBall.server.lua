local char = script.Parent
local torso = char:WaitForChild("Torso")
local anim = script:WaitForChild("Animation")
local weld1
local weld2
local humanoid = char:WaitForChild("Humanoid")
local animtrack = humanoid:LoadAnimation(anim)

local function unEquip()
	if char:FindFirstChild("Head") then
		if char.Head:FindFirstChild("BillboardGui") then
			char.Head.BillboardGui:Destroy()
		end
	end
	animtrack:Stop()
end

script.Parent:WaitForChild("Torso").ChildAdded:Connect(function(des)
	if des.Name == "BallWeld" then
		animtrack:Play()
		if game.Players:GetPlayerFromCharacter(char):FindFirstChild("Mobile") then
			script.Parent.Humanoid.AutoJumpEnabled = false
		end
	end 
end)

script.Parent:WaitForChild("Torso").ChildRemoved:Connect(function(des)
	if des.Name == "BallWeld" then
		unEquip()
		if game.Players:GetPlayerFromCharacter(char):FindFirstChild("Mobile") then
			script.Parent.Humanoid.AutoJumpEnabled = true
		end
	end
end)