local sparkimage = script:WaitForChild("SparkImage")

game.Players.PlayerAdded:connect(function(p)
	sparkimage:Clone().Parent = p
end)