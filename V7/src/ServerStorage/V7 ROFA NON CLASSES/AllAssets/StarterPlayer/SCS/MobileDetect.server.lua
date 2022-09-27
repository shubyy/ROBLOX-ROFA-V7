script.RemoteEvent.OnServerEvent:connect(function(plr)
	local mb = Instance.new("BoolValue")
	mb.Name = "Mobile"
	mb.Parent = plr
	mb.Value = true
end)