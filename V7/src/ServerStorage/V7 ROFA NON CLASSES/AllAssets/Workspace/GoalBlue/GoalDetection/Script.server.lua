repeat wait() until script.Parent.Parent.Parent.Name == "Goals"
local srcoreBoard = script.Parent.Parent.Parent.Parent.Scoreboard
local Srevent = srcoreBoard.Event

local goal = workspace:WaitForChild("Sounds"):WaitForChild("GoalScored")
local start = workspace:WaitForChild("Sounds"):WaitForChild("Start")
--local scoreTeam = 'Red'
local deadBall = true
local db = false

--GLTDELAY ALSO CHANGE IN THE OTHER GOALS SCRIPT
local GLTDELAY = 0.23

--script.Parent.Touched:connect(function(hit)
--	if hit.Parent:FindFirstChild("SoccerBallScript") or hit.Parent:FindFirstChild("PersonToPassTo") or hit.Parent.Name == "SoccerBall" then
--		if db == true then return end
--		db = true
--		local num = tonumber(script.Parent.Parent.Parent:FindFirstChild('Goal'..scoreTeam).Score.SurfaceGui.TextLabel.Text)
--		num = num + 1
--		script.Parent.Parent.Parent:FindFirstChild('Goal'..scoreTeam).Score.SurfaceGui.TextLabel.Text = tostring(num)
--		script.Parent.Parent.Parent.Score.Event:Fire()
--		Default(hit)
--	end
--end)
local scoreLog = {}

local function animpicker(scorer)
	local animations = game.ServerStorage:WaitForChild("Animations")
	local common = animations:WaitForChild("Common"):GetChildren()
	local rare = animations:WaitForChild("Rare"):GetChildren()
	local legendary = animations:WaitForChild("Legendary"):GetChildren()
	
	local chance = math.random(1,10000)
	local goalscorers = scoreLog
	local goaltally = 0
	for _, each in pairs(goalscorers) do
		if each == scorer then
			goaltally = goaltally + 1
		end
	end
	chance = chance * (1 + (0.2*goaltally))
	table.insert(scoreLog, scorer)
	if chance <= 7000 then
		return common[math.random(1,#common)]:Clone()
	elseif chance > 7000 and chance <= 13000 then
		return rare[math.random(1,#rare)]:Clone()
	else
		return legendary[math.random(1,#legendary)]:Clone()
	end
end

script.Parent.Touched:connect(function(hit)
	if hit.Name == "SSBall" then
		if db == true then return end
		hit.Velocity = Vector3.new(0,0,0)
		hit.RotVelocity = Vector3.new(0,0,0)
		if hit:WaitForChild("PlayerOnBall").Value == nil then
			wait(GLTDELAY)
			if hit:WaitForChild("PlayerOnBall").Value ~= nil then
				return
			else
				hit.Script.Disabled = true
				hit.Script:Destroy()
			end
		end
		db = true
		for i, child in pairs(script.Parent.Parent.Parent:GetChildren()) do
			if child ~= script.Parent.Parent then
				local num = child.Score.Value
				num = num + 1
				child.Score.Value = num
				Srevent:Fire(hit.LastShot.Value,'Score')
				Default2(hit)				
			end
		end
	end
end)

function Default2(hit)
	if deadBall then
		local scorer = game.Players:FindFirstChild(hit:WaitForChild("LastShot").Value)
		if scorer == nil then
			return
		end
		if hit.PlayerOnBall.Value ~= nil then
			scorer = game.Players:FindFirstChild(hit:WaitForChild("PlayerOnBall").Value)
		end
		
		if start.IsPlaying == true then
			if scorer.Team.Name ~= "Referee" and scorer ~= nil and goal.IsPlaying == false then
				goal.Volume = start.Volume - 0.1
				goal:Play()
				local anim1 = animpicker(scorer)
				anim1.Parent = scorer.Backpack
				local anim2 = animpicker(scorer)
				anim2.Parent = scorer.Backpack
			end	
		end
		
		hit.Parent = workspace
		local clone = hit:Clone()
		clone:WaitForChild("Decal"):Destroy()
		clone.Transparency = 0.5
		clone.Parent = workspace
		clone.Position = hit.Position
		clone.Mesh.TextureId = "http://www.roblox.com/asset/?id=690662958"
		clone.Anchored = true
		clone.CanCollide = false
		game.Debris:AddItem(clone,2)
		wait(2)
	end
	db = false
	hit:Destroy()	
end