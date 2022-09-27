local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
 
local playerCollisionGroupName = "Players"
local ballCollision = "Ball"
local blockerCollision = "Blocker"
PhysicsService:CreateCollisionGroup(playerCollisionGroupName)
PhysicsService:CreateCollisionGroup(ballCollision)
PhysicsService:CreateCollisionGroup(blockerCollision)
PhysicsService:CollisionGroupSetCollidable(playerCollisionGroupName, ballCollision, false)
PhysicsService:CollisionGroupSetCollidable(blockerCollision, ballCollision, false)
repeat wait() until workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):FindFirstChild("GoalRed") and workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):FindFirstChild("GoalRed"):FindFirstChild("Blocker")
repeat wait() until workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):FindFirstChild("GoalBlue") and workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):FindFirstChild("GoalBlue"):FindFirstChild("Blocker")
local blocker1 = workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):WaitForChild("GoalBlue"):WaitForChild("Blocker")
local blocker2 = workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):WaitForChild("GoalRed"):WaitForChild("Blocker")

 
local function setCollisionGroupRecursive(object)
	if object:IsA("BasePart") then
		PhysicsService:SetPartCollisionGroup(object, playerCollisionGroupName)
	end
	for _, child in ipairs(object:GetChildren()) do
		setCollisionGroupRecursive(child)
	end
end
 
local function onCharacterAdded(character)
	setCollisionGroupRecursive(character)
end
 
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end
 
Players.PlayerAdded:Connect(onPlayerAdded)

--PhysicsService:SetPartCollisionGroup(workspace.Handle,ballCollision)
PhysicsService:SetPartCollisionGroup(game.ServerStorage:WaitForChild("SSBall"),ballCollision)
PhysicsService:SetPartCollisionGroup(blocker1, blockerCollision)
PhysicsService:SetPartCollisionGroup(blocker2, blockerCollision)
--PhysicsService:SetPartCollisionGroup(workspace.Model.WhiteWall,ballCollision)
--setCollisionGroupRecursive(workspace.Dummy)