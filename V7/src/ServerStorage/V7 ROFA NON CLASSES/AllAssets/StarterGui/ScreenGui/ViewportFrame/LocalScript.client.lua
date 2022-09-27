local viewportFrame = script.Parent
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(1.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local leagueName = game.ReplicatedStorage:WaitForChild("LeagueName")
local leaguetext = viewportFrame.Parent:WaitForChild("LeagueName")
local maintext = "RO-FOOTBALL ASSOCIATION: "

local sponsornames = {
	gold = "GOLD LEAGUE",
	prime = "PRIME LEAGUE",
	x = "X LEAGUE",
	z = "Z LEAGUE",
	ace = "ACE LEAGUE",
	pro = "PRO LEAGUE",
	basic = "BASIC LEAGUE",
	foundation = "FOUNDATION LEAGUE",
	glory = "GLORY LEAGUE",
	silver = "SILVER LEAGUE",
	bravo = "BRAVO LEAGUE",
}

local leaguecolors = {
	gold = Color3.fromRGB(120, 117, 17),
	prime = Color3.fromRGB(85, 255, 0),
	x = Color3.fromRGB(114, 36, 255),
	z = Color3.fromRGB(118, 1, 127),
	ace = Color3.fromRGB(0, 74, 127),
	pro = Color3.fromRGB(40, 40, 40),
	basic = Color3.fromRGB(112, 150, 96),
	foundation = Color3.fromRGB(103, 103, 103),
	glory = Color3.fromRGB(234, 228, 33),
	silver = Color3.fromRGB(234, 228, 33),
	bravo = Color3.fromRGB(82, 96, 124),
}

local leaguedecals = {
	gold = 4024088373, 
	prime = 4024089891,
	x = 4024093890, 
	ace = 4024082610, 
	pro = 4024091173,
	z = 4024095551,
	basic = 4024084263,
	foundation = 4024087112, 
	glory = 3667278667,
	bravo = 4024085721,
	silver = 4024092465,
}

local part = Instance.new("Part")
part.Material = Enum.Material.Concrete
part.Color = Color3.new(0.25, 0.75, 1)
part.Position = Vector3.new(0, 0, 0)
part.Parent = viewportFrame
part.Size = Vector3.new(4.03, 4.03, 0.05)
part.Transparency = 1

local decal1 = Instance.new("Decal")
decal1.Parent = part
decal1.Face = Enum.NormalId.Back
decal1.Transparency = 0
decal1.Texture = "rbxassetid://" .. tostring(leaguedecals["prime"])

local decal2 = Instance.new("Decal")
decal2.Parent = part
decal2.Face = Enum.NormalId.Front
decal2.Transparency = 0
decal2.Texture = "rbxassetid://" .. tostring(leaguedecals["prime"])

local origframe = part.CFrame
local tween = TweenService:Create(part, tweenInfo, {CFrame = part.CFrame * CFrame.Angles(0,math.pi,0)})

local viewportCamera = Instance.new("Camera")
viewportFrame.CurrentCamera = viewportCamera
viewportCamera.Parent = viewportFrame
viewportCamera.CFrame = CFrame.new(Vector3.new(0, 0, 3), part.Position)

local function updateLeague(league)
	if sponsornames[league] then
		viewportFrame.Visible = true
		leaguetext.Visible = true
		leaguetext.Text = maintext .. sponsornames[league]
		leaguetext.TextColor3 = leaguecolors[league]
		decal1.Texture = "rbxassetid://" .. tostring(leaguedecals[league])
		decal2.Texture = "rbxassetid://" .. tostring(leaguedecals[league])
	end
end

leagueName.Changed:Connect(function()
	updateLeague(leagueName.Value)
end)

updateLeague(leagueName.Value)

while true do
	tween:Play()
	wait(10)
	part.CFrame = origframe
end