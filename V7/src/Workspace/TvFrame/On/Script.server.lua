function onClicked(playerWhoClicked)
    if playerWhoClicked.Character.TvScript.WatchingTv.Value == false then
		playerWhoClicked.Character.TvScript.WatchingTv.Value = true
	end
end

script.Parent.ClickDetector.MouseClick:connect(onClicked)