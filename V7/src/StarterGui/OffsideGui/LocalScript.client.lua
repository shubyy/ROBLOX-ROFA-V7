local event = game.ReplicatedStorage:WaitForChild("GameEvents")
local frame = script.Parent:WaitForChild("Frame")
local textbox = frame:WaitForChild("TextBox")

local tweening = false

function flash()
	frame.BackgroundTransparency = 0
	wait(0.1)
	frame.BackgroundTransparency = 0.4
	wait(0.1)
	frame.BackgroundTransparency = 0
	wait(0.1)
	frame.BackgroundTransparency = 0.4
	wait(8)
	frame:TweenPosition(UDim2.new(0.5, -150, -0.15, -25), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, false)
	repeat wait() until frame.Position == UDim2.new(0.5, -150, -0.15, -25)
	tweening = false
end

event.OnClientEvent:Connect(function(...)
	local tuple = {...}
	local info = tuple[1]
	if info == "message" then
		local task = tuple[2]
		while tweening == true do
			wait()
		end
		if tweening == false then
			tweening = true
			textbox.Text = task
			frame:TweenPosition(UDim2.new(0.5, -150, 0.15, -25), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, false, flash)
		--[[elseif task == "exlogs" then
			local info = tuple[2]
			for name, reason in pairs(info) do
				print(reason)
				repeat
					wait() --Wait to prevent crashing
					local Success = pcall(function()
						--Run SetCore method inside the pcall
						--The first argument of SetCore is the method we wish to use
						--In this case, the second argument is a dictionary of data for the chat message
						game.StarterGui:SetCore("ChatMakeSystemMessage", {
							Text = name + ": " + reason; --The chat message
							Color = Color3.fromRGB(255, 0, 0); --Chat message color, defaults to white
							Font = Enum.Font.SourceSansBold; --Chat message font, defaults to SourceSansBold
							TextSize = 20 --Text size, defaults to 18
						})
					end)
				until Success
			end]]--
		end
	end
end)