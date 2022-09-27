local serverlocation = game.ReplicatedStorage:WaitForChild("ServerLocation")
local request = {}
request.Url = ""  

local response
local success = pcall(function()
	response = game.HttpService:RequestAsync(request)
end)

if success and response.Success == true then
	print("SUCCESS")
	print(response.Body)
	local data = game.HttpService:JSONDecode(response.Body)
	print(data)
	print(data["country"])
	print(data["city"])
	local locstring = data["country"] .. ",  " .. data["city"]
	serverlocation.Value = locstring
else
	serverlocation.Value = "Unknown"
end
