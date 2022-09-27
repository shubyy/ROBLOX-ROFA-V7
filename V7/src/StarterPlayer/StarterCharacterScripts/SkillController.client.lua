
local uis = game:GetService("UserInputService")
local skillevent = script.Parent:WaitForChild("SkillEvent")
local skillMode = false
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local mouseconn = nil
local cachedPos
local cam = workspace.CurrentCamera 

local function inputChanged(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == Enum.KeyCode.E then
			if input.UserInputState == Enum.UserInputState.Begin then
				print("Starting Skill Mode")
				skillevent:FireServer("Start")
				skillMode = true
				cachedPos = Vector2.new(mouse.X, mouse.Y)
				
				
				
				--[[
				cam.CameraType = Enum.CameraType.Scriptable
				local lookVec = cam.CFrame.LookVector
				local forwardVector = Vector3.new(0,0,1)
				local rightVector = cam.CFrame.RightVector
				cam.CFrame = CFrame.fromMatrix(workspace.CurrentCamera.CFrame.Position, forwardVector, rightVector )
				]]--
				
				while skillMode do
					local newPos = Vector2.new(mouse.X, mouse.Y)
					local power = (newPos - cachedPos).Magnitude
					if power > 110 then
						if power > 200 then 
							power = 200
						end
						local screenDirection = (newPos - cachedPos).Unit
						
						local vector2 = Vector2.new(0, -1)
						local angleInRadians = math.atan2(vector2.Y, vector2.X) - math.atan2(screenDirection.Y, screenDirection.X)
						--print(math.deg(angleInRadians))
						
						--calculate direction
						local camRightVec = workspace.CurrentCamera.CFrame.RightVector
						local upVector = Vector3.new(0,1,0)
						local newCFrame = CFrame.fromMatrix(cam.CFrame.Position, camRightVec, upVector)
						local finalCFrame = newCFrame * CFrame.Angles(0, angleInRadians, 0)
						
						--[[-- Debug testing
						local part = Instance.new("Part")
						local newPos = finalCFrame.p + finalCFrame.LookVector
						part.Parent = workspace
						part.Position = newPos
						part.Anchored = true
						part.Size = Vector3.new(1,1,1)
						]]--
						
						skillevent:FireServer("Skill", finalCFrame.LookVector, power)
						
					end
					cachedPos = newPos
					wait(.05)
				end
			else
				print("Ending Skill Mode")
				skillevent:FireServer("End")
				cam.CameraType = Enum.CameraType.Custom
				skillMode = false
			end
		end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		if skillMode then
			print("jumping client")
			if input.UserInputState == Enum.UserInputState.End then
				skillevent:FireServer("Jump")
			end
		end
		
	end
end

uis.InputBegan:Connect(function(input, gpe) inputChanged(input, gpe) end)
uis.InputEnded:Connect(function(input, gpe) inputChanged(input, gpe) end)


while true do 
	--print(cam.CFrame.RightVector)
	wait(.1)
end