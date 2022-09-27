--game.Players.CharacterAutoLoads = false
local module = require(2582963263)
local ss = game:GetService("ServerStorage")
local airpods = ss:WaitForChild("AirPods")
local leagueName = game.ReplicatedStorage:WaitForChild("LeagueName")
local databaseService = require(script:WaitForChild("DatabaseService"))
local globalDatabase = databaseService:GetDatabase("Global")
local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local classinfofolder = game.ReplicatedStorage:WaitForChild("ClassInformation")
--local mask = game.InsertService:LoadAsset(69225884):FindFirstChild("SurgeonMask")

local classnames = {"Goalkeeper", "Sweeper Keeper", "Shot Stopper", "Guard", "Tank", "Chaser", "Destroyer", "Architect", "Playmaker", "Engine", "Transporter", "Sprinter", "Assassin", "Hammer", "The Superroblox"}

local function billwithtext(par, text)
	local billBoard = Instance.new("BillboardGui")
	billBoard.Parent = par
	billBoard.Name = "ClassType"
	billBoard.Size = UDim2.new(5,0,5,0)
	billBoard.Adornee = par
	local ImageL = Instance.new("TextLabel")
	ImageL.Parent = billBoard
	ImageL.Font = Enum.Font.GothamBold
	ImageL.TextSize = 7
	ImageL.Text = text
	ImageL.TextColor3 = Color3.fromRGB(255, 255, 255)
	ImageL.TextStrokeTransparency = 0
	ImageL.TextStrokeColor3 = Color3.new(0,0,0)
	ImageL.Position = UDim2.new(0.45,0,0.3,0)
end

local function resize(character, ratio)
	local function recurse(x)
		local R6 = character.Humanoid.RigType == Enum.HumanoidRigType.R6
		for k, v in pairs(x:GetChildren()) do
			if v:IsA("Attachment") and (v.Parent.Name == "Handle" or R6) then
				v.Position = v.Position * ratio
			elseif v.ClassName == "SpecialMesh" and v.MeshType == Enum.MeshType.FileMesh then
				v.Scale = v.Scale * ratio
			elseif R6 then
				if v:IsA("BasePart") then
					v.Size = v.Size * ratio
				elseif v:IsA("JointInstance") then
					local c0, c1 = v.C0, v.C1
					c0 = c0-c0.p + c0.p*ratio
					c1 = c1-c1.p + c1.p*ratio
					v.C0, v.C1 = c0, c1
				end
			elseif v:IsA("Humanoid") then
				v.BodyDepthScale.Value = v.BodyDepthScale.Value * ratio
				v.BodyHeightScale.Value = v.BodyHeightScale.Value * ratio
				v.BodyWidthScale.Value = v.BodyWidthScale.Value * ratio
				v.HeadScale.Value = v.HeadScale.Value * ratio
			end
			recurse(v)
		end
	end
	recurse(character)
end

game.Players.PlayerAdded:Connect(function(player)
	
	local classVal = Instance.new("StringValue")
	classVal.Name = "CurrentClass"
	classVal.Value = "10"
	
	player.CharacterAdded:Connect(function(char)
		for i, child in pairs(char:GetChildren()) do
			if child:IsA("CharacterMesh") then 
				child:Destroy()
			end
		end
		
		for _,each in pairs(module.airpods) do
			if game.Players:GetUserIdFromNameAsync(each) == player.UserId then
				local Hat = Instance.new("Hat")
				Hat.Name = "Headphones"
				Hat.AttachmentForward = Vector3.new(0, 0, 1)
				Hat.AttachmentPos = Vector3.new(0, 0.300000012, 0)
				Hat.AttachmentRight = Vector3.new(1, 0, 0)
				Hat.AttachmentUp = Vector3.new(0, 1, 0)
				local Handle = airpods:Clone()
				Handle.Anchored = false
				Handle.Locked = true
				Handle.CanCollide = true
				Handle.Name = "Handle"
				Handle.Parent = Hat
				Hat.Parent = char
			end
		end
		
		local classnumber = tonumber(classVal.Value)
		if classnumber > 0 then
			local classfolder = classinfofolder:WaitForChild(classVal.Value)
			local height = classfolder:WaitForChild("Height").Value
			local heightscale = (height)*(0.3)/(20) + 0.85
			resize(char, heightscale)
			
			local agilval = classfolder:WaitForChild("Agility").Value
			local agilscale = (agilval)*(20)/(20) + 40
			char:WaitForChild("Humanoid").JumpPower = agilscale
			
			billwithtext(char:WaitForChild("Head"), classnames[classnumber])
		end
		
		for _,each in pairs(module.stadiumpass) do
			local id = 0
			local success, res = pcall(function()
				id = game.Players:GetUserIdFromNameAsync(each)
			end)
			if id == player.UserId and player.Team.Name == "Crowd" then
				player.Team = game.Teams:WaitForChild("Stadium Pass")
				break
			end
		end
		for _,each in pairs(module.adminstadiumpass) do
			local id = 0
			local success, res = pcall(function()
				id = game.Players:GetUserIdFromNameAsync(each)
			end)
			if id == player.UserId and player.Team.Name == "Crowd" then
				player.Team = game.Teams:WaitForChild("Stadium Pass")
				break
			end
		end
		
		event:FireClient(player, "CharLoad")
		
	end)	
	
	local val = nil --globalDatabase:GetAsync(player.UserId)
	if val then
		classVal.Value = tostring(val)
	end
	classVal.Parent = player
	
	player:LoadCharacter()
	
end)

game.Teams:WaitForChild("Stadium Pass").PlayerAdded:Connect(function(player)
	ss:WaitForChild("Spectate"):Clone().Parent = player:WaitForChild("Backpack")
	ss:WaitForChild("Boo"):Clone().Parent = player:WaitForChild("Backpack")
	ss:WaitForChild("Cheer"):Clone().Parent = player:WaitForChild("Backpack")
	ss:WaitForChild("Ace Brew"):Clone().Parent = player:WaitForChild("Backpack")
	ss:WaitForChild("Mike Ashley Special"):Clone().Parent = player:WaitForChild("Backpack")
	player.CharacterAdded:Connect(function(char)
		ss:WaitForChild("Spectate"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Boo"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Cheer"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Ace Brew"):Clone().Parent = player:WaitForChild("Backpack")
		ss:WaitForChild("Mike Ashley Special"):Clone().Parent = player:WaitForChild("Backpack")
	end)
end)

game.Teams:WaitForChild("Referee").PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if string.lower(string.sub(msg, 1, 8)) == ":toggle " then
			local league = string.lower(string.sub(msg, 9))
			leagueName.Value = league
		--[[elseif string.lower(string.sub(msg, 1, 7)) == ":exlogs" then
			print("cmd logs")
			local info = {}
			for _,each in pairs(logs:GetChildren()) do
				info[each.Name] = each.Value
			end
			event:FireClient(player, "exlogs")]]--
		end
	end)
end)




