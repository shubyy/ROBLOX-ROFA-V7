local gameevent = game.ReplicatedStorage:WaitForChild("GameEvent")

local start = workspace:WaitForChild("Sounds"):WaitForChild("Start")
--local penmode = game.ReplicatedStorage:WaitForChild("PenaltyMode")
local songModule = require(2636498987)
local currSong = nil
--format: id, startpos, length, volume, playbackSpeed
--local songs = {{138257163, 0, -1, 3, 1}, {131122314, 0, -1, 3, 1}, {2351148978, 39, 20, 3, 1}, {4907112249, 0, -1, 3, 1.1111}, {4907091933, 0, -1, 3, 1.11111},{4910548180, 1, -1, 3, 1.11111}}
game.SoundService.AmbientReverb = Enum.ReverbType.Auditorium

local soundpos = workspace:WaitForChild("ScriptStuff"):WaitForChild("Goals"):WaitForChild("GoalRed"):WaitForChild("GoalDetection")
local soundpart = Instance.new("Sound")
soundpart.Parent = soundpos
soundpart.EmitterSize = 1000
soundpart.MaxDistance = 10000



local function playGoalSong()
	if start.IsPlaying and currSong then
		soundpart.Volume = currSong[5] / 2
		local length = currSong[4]
		local startpos = currSong[3]
		soundpart.SoundId  = "rbxassetid://" .. tostring(currSong[2])
		soundpart.TimePosition = startpos
		wait(1)
		soundpart:Play()
		if length == -1 then
			soundpart:Play()
		else
			while soundpart.IsPlaying do
				if soundpart.TimePosition > (startpos + length) then
					soundpart:Stop()
				end
				wait()
			end
		end
	end
end

gameevent.Event:Connect(function(...)
	local tuple = {...}
	local event = tuple[1]
	if event == "GOAL" then
		local scorer = tuple[2]
		if scorer and scorer.Team.TeamColor == BrickColor.new("Bright yellow") then
			playGoalSong()
		end	
	end
end)

local function updateSong()
	local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	
	for _, each in pairs(songModule.songs) do
		local name = each[1]
		if string.find(placeName, name) ~= nil then
			currSong = each
			print("FOUND CURRENT SONG FOR PLACE " .. name .. " song: " .. currSong[2])
		end
	end
end

updateSong()


