local tool = script.Parent
local foam = tool:WaitForChild('RemoteEvent')
local lastsphere = nil
local foamcount = 0

local function createsphere(pos)
	local sphere = Instance.new('Part', workspace.Foam)
	sphere.Shape = Enum.PartType.Ball
	sphere.Transparency = 0.375
	sphere.Name = 'FOAM'
	sphere.BrickColor = BrickColor.White()
	sphere.Anchored = true
	sphere.CanCollide = false
	sphere.Size = Vector3.new(1,0.5,1)
	sphere.BottomSurface = Enum.SurfaceType.SmoothNoOutlines
	sphere.TopSurface = Enum.SurfaceType.SmoothNoOutlines
	script:WaitForChild('Script'):Clone().Parent = sphere
	sphere.Script.Disabled = false
	sphere.CFrame = pos - Vector3.new(0,.2,0)
	return sphere.CFrame
end

foam.OnServerEvent:Connect(function(plr, hit, typo)
	if typo == nil then
		if hit ~= nil then
			foamcount = foamcount + 1
			local foamindex = foamcount
			if lastsphere then 
				local loops = (hit.p - lastsphere.p).Magnitude * 1.5
				if loops < 30 then
					for i=1,loops,1 do
						local pos = hit:Lerp(lastsphere, i/loops)
						createsphere(pos)
					end
				end
			end
			local pos = createsphere(hit)
			lastsphere = pos
			wait(0.5)
			if foamcount == foamindex then
				lastsphere = nil
			end
		end
	elseif typo == 'clear' then
		if plr.TeamColor == BrickColor.new'Bright green' then
			workspace.Foam:ClearAllChildren()
		end
	end
end)