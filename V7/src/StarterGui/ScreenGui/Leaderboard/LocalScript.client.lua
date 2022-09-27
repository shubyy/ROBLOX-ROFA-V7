local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
local leaderboard = script.Parent
local scrollframe = leaderboard:WaitForChild("ScrollingFrame")
local topline = leaderboard:WaitForChild("TopLine")
local fullgame = topline:WaitForChild("FullGame")
local serverlocation = game.ReplicatedStorage:WaitForChild("ServerLocation")
local serverlocationlabel = leaderboard:WaitForChild("ServerLocation")
local toggle = topline:WaitForChild("ToggleButton")

toggle.MouseButton1Click:Connect(function()
	if scrollframe.Visible == true then
		scrollframe.Visible = false
		leaderboard.Size = UDim2.new(0, 250, 0, 25)
	else
		scrollframe.Visible = true
		leaderboard.Size = UDim2.new(0, 250, 0, 400)
	end
end)

serverlocation.Changed:Connect(function()

	serverlocationlabel.Text = "Server Location: " .. serverlocation.Value
	print("sevrer location changed text " .. serverlocationlabel.Text)
end)

local function changePingLength(frame, ping)
	if ping > 200 then
		ping = 200
	end
	
	local length = .15 - (ping * (0.15/250))
	local newSize = UDim2.new(length, 0, 0, 15)
	frame.Size = newSize
	
	local green = 200 - (ping * (155/200))
	local red = ping * (200/200)
	frame.BackgroundColor3 = Color3.fromRGB(red, green, 0)
end

local function updateLeaderboard()
	scrollframe:ClearAllChildren()
	local teams = game:GetService("Teams"):GetChildren()
	local currentspacing = 0
	local numplayers = #game.Players:GetPlayers()
	if numplayers >= game.Players.MaxPlayers then
		fullgame.Visible = true
	else
		fullgame.Visible = false
	end
	
	for _, team in pairs(teams) do
		local teamline = leaderboard:WaitForChild("TeamLine"):Clone()
		local teamplayers = team:GetPlayers()
		teamline:WaitForChild("NumPlayers").Text = tostring(#teamplayers) .. " Players"
		teamline:WaitForChild("TeamName").Text = team.Name
		teamline.Parent = scrollframe
		teamline.Position = UDim2.new(0, 0, 0, currentspacing)
		teamline.BackgroundColor3 = team.TeamColor.Color
		teamline.Visible = true
		currentspacing = currentspacing + teamline.Size.Height.Offset
		for _, player in pairs(teamplayers) do
			local plrline = leaderboard:WaitForChild("PlayerLine"):Clone()
			plrline:WaitForChild("PlayerName").Text = player.Name
			plrline:WaitForChild("GroupRank").Text = player:WaitForChild("leaderstats"):WaitForChild("Role").Value
			local ping = player:WaitForChild("leaderstats"):WaitForChild("Ping").Value
			plrline:WaitForChild("Ping").Text = tostring(ping) .. " ms"
			
			changePingLength(plrline:WaitForChild("PingLength"), ping)
			if player:WaitForChild("leaderstats"):WaitForChild("Rank").Value == 2 then
				plrline.BackgroundColor3 = Color3.fromRGB(100,0,0)
			end
			
			if player:WaitForChild("leaderstats"):WaitForChild("Rank").Value >= 150 then
				plrline.BackgroundColor3 = Color3.fromRGB(0,100,0)
			end
			
			plrline.Visible = true
			plrline.Position = UDim2.new(0, 0, 0, currentspacing)
			plrline.Parent = scrollframe
			
			currentspacing = currentspacing + plrline.Size.Height.Offset
		end
	end
	
	scrollframe.CanvasSize = UDim2.new(0, 0, 0, currentspacing)
end

serverlocationlabel.Text = "Server Location: " .. serverlocation.Value

while true do
	updateLeaderboard()
	wait(.5)
end