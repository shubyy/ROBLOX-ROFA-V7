local newrgoal = workspace:WaitForChild("GoalRed")
local newbgoal = workspace:WaitForChild("GoalBlue")

game.StarterPlayer.NameDisplayDistance = 400

local goalfolder = workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals")
local oldrCFrame = goalfolder:WaitForChild("GoalRed"):WaitForChild("GoalDetection").CFrame
local oldbCFrame = goalfolder:WaitForChild("GoalBlue"):WaitForChild("GoalDetection").CFrame
goalfolder:ClearAllChildren()
newbgoal.Parent = goalfolder
newrgoal.Parent = goalfolder
newrgoal:SetPrimaryPartCFrame(oldrCFrame)
newbgoal:SetPrimaryPartCFrame(oldbCFrame)


local rd = workspace:WaitForChild("BlueDefense",3)
if rd then
	rd.Anchored = true
	rd.Position = newbgoal.PrimaryPart.Position + Vector3.new(197.929398, -4.05001831, -196.336456)
end


local bd = workspace:WaitForChild("RedDefense",3)
if bd then
	bd.Anchored = true
	bd.Position = newrgoal.PrimaryPart.Position + Vector3.new(198.319656, -4.05001831, 170.539154)
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

workspace:WaitForChild("ScriptStuff"):WaitForChild("Scoreboard"):WaitForChild("Score"):WaitForChild("Script").Disabled = true
workspace:WaitForChild("ScriptStuff"):WaitForChild("Scoreboard"):WaitForChild("Score"):WaitForChild("Script").Disabled = false

if not workspace:FindFirstChild("Foam") then
	local foam = Instance.new("Folder")
	foam.Name = "Foam"
	foam.Parent = workspace
end

local vector = newrgoal.PrimaryPart.CFrame.LookVector
local newvector = Vector3.new(round(vector.X, 0), round(vector.Y,0), round(vector.Z, 0))
if newvector ~= Vector3.new(-1,0,0) then
	for _, each in pairs(game.Players:GetPlayers()) do
		each:WaitForChild("PlayerGui"):WaitForChild("ScreenGui"):WaitForChild("TextLabel").Visible = true
	end
	game.StarterGui:WaitForChild("ScreenGui"):WaitForChild("TextLabel").Visible = true
end


 

local serverlocation = game.ReplicatedStorage:WaitForChild("ServerLocation")
local request = {}
request.Url = "http://ip-api.com/json/"  

local response
local success = pcall(function()
	response = game.HttpService:RequestAsync(request)
end)

if success and response.Success == true then
	print("SUCCESS")
	print(response.Body)
	local data = game.HttpService:JSONDecode(response.Body)
	print(data)
	print(data["country"])
	print(data["city"])
	local locstring = data["country"] .. ",  " .. data["city"]
	serverlocation.Value = locstring
else
	serverlocation.Value = "Unknown"
end
