local sGui = script.Parent
local frame = sGui.Frame
local image = frame.ImageLabel
local Nome = sGui.NoName
local scoreLog = {}
local CHOICE_GUI = Instance.new("TextButton")
CHOICE_GUI.Name = "BACKPACK_CHOICE"
CHOICE_GUI.Size = UDim2.new(0, 100, 0, 25)
--local pc = script.Parent.Parent.Part:Clone()
--pc.Parent = game.ServerStorage
function clear()
	scoreLog = {}
end


function changeName(name,side)
	if name and game.Players:FindFirstChild(name) then
			
		Nome.Text = name..'!'
		image.Image = 'http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=200&Format=Png&username='..name
		local plr = game.Players:FindFirstChild(name)
		local c3 = Color3.new(plr.TeamColor.Color.r,plr.TeamColor.Color.g,plr.TeamColor.Color.b)
		frame.BackgroundColor3 = c3
		frame.BackgroundTransparency = 0
		
		local logMan = {}
		logMan.Name = name
		logMan.Color = c3
		
		table.insert(scoreLog,logMan)
		
		wait(10)
		Nome.Text = ' '
		image.Image = ' '
		frame.BackgroundTransparency = 1
	else
		return
	end
end

function onClick(p)
	if p.PlayerGui:FindFirstChild("LogContainer") then
		p.PlayerGui.LogContainer:Destroy()
	end		
	
	local x = 0
	local y = 250
	local s = Instance.new('ScreenGui',p.PlayerGui)
	s.Name = 'LogContainer'
	for index, child in pairs(scoreLog) do
		local new_gui = CHOICE_GUI:clone()
		new_gui.Position = UDim2.new(0, x, 0, y)
		new_gui.Parent = s
		new_gui.Text = child.Name
		new_gui.MouseButton1Down:connect(function() s:Destroy() end)
		new_gui.BackgroundColor3 = child.Color					
		y = y + 25
		if y > 350 then
			y = 250
			x = x + 100
		end
	end
end




script.Parent.Parent.Parent.Parent.RefConsole.Scorelog.ClickDetector.MouseClick:connect(onClick)
--script.Parent.Parent.Part2.ClickDetector.MouseClick:connect(function(p)
--		print('p2')
--		onClick(p)
--		pc:Clone().Parent = workspace
--	end)
script.Parent.Parent.Parent.Event.Event:connect(changeName)

--script.Parent.Parent.Changed:connect(function()
--	if not script.Parent.Parent:FindFirstChild("Part") then
--		pc:Clone().Parent = workspace		
--	end
--end)

--script.Parent.Parent.Clr.Event:connect(clear)

--script.Parent.Parent.ClearPart.ClickDetector.MouseClick:connect(function(p)
--	if p:GetRankInGroup(2912781) >= 70 then
--		warn(tostring(p)..' just cleared the scoreLog')
--		clear()
--	end
--end)