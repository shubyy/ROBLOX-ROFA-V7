local TweenService = game:GetService("TweenService")


function makeitRain()

local amount = 8

local raindrop = Instance.new("Frame")
raindrop.BackgroundColor3 = Color3.fromRGB(230,255,255)
raindrop.BackgroundTransparency = 0.9
raindrop.Size = UDim2.new(0,1,0,20)
local droplet = Instance.new("Frame",raindrop)
droplet.BackgroundColor3 = Color3.fromRGB(230,255,255)
droplet.BackgroundTransparency = 0.9
droplet.Position = UDim2.new(0,0,0,3)
droplet.Size = UDim2.new(0,1,0,14)


while true do
	for i = 1, amount do
		wait(.001)
		local drop = raindrop:Clone()
		drop.Parent = script.Parent
		local dropudim = UDim2.new(math.random(0,100)/100,0,math.random(0,100)/100,0)
		drop.Position = dropudim
		local goal = {}
		goal.Position = dropudim + UDim2.new(0,0,0,300)
	
		local dropTween = TweenService:Create(drop,TweenInfo.new(0.5,Enum.EasingStyle.Linear),goal)
		dropTween:Play()
		dropTween.Completed:connect(function()
			drop:Destroy()
		end)
	end
	
end

end

makeitRain()