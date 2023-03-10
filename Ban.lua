-- ░█████╗░░█████╗░██████╗░███████╗██████╗░  ██████╗░██╗░░░██╗
--██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗  ██╔══██╗╚██╗░██╔╝
--██║░░╚═╝██║░░██║██║░░██║█████╗░░██║░░██║  ██████╦╝░╚████╔╝░
--██║░░██╗██║░░██║██║░░██║██╔══╝░░██║░░██║  ██╔══██╗░░╚██╔╝░░
--╚█████╔╝╚█████╔╝██████╔╝███████╗██████╔╝  ██████╦╝░░░██║░░░
--░╚════╝░░╚════╝░╚═════╝░╚══════╝╚═════╝░  ╚═════╝░░░░╚═╝░░░

--██╗░░██╗░█████╗░░██████╗███████╗███████╗██████╗░░█████╗░██╗░░░░░██╗░█████╗░░█████╗░
--██║░░██║██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗██╔══██╗██║░░░░░██║██╔══██╗██╔══██╗
--███████║███████║╚█████╗░█████╗░░█████╗░░██████╦╝███████║██║░░░░░██║╚█████╔╝██║░░██║
--██╔══██║██╔══██║░╚═══██╗██╔══╝░░██╔══╝░░██╔══██╗██╔══██║██║░░░░░██║██╔══██╗██║░░██║
--██║░░██║██║░░██║██████╔╝███████╗███████╗██████╦╝██║░░██║███████╗██║╚█████╔╝╚█████╔╝
--╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝╚══════╝╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░╚════╝░░╚════╝░

-- I've added some notes on what the specific lines/functions do
-- BanGUI is in this script, These all go to ServerScriptService. To get the ui, put your userid in the admins section where mine is
-- This system and ui is free to use
-- You can delete the folders when you have put the things in the right place

local admins = {121923793}

game.Players.PlayerAdded:Connect(function(plr) -- When a player joins
	for i,v in pairs(admins) do -- Go through the values in the table called admins
		if v == plr.UserId then -- if the id in the table
			local cl = script.BanGUI:Clone() -- clone the gui
			cl.Parent = plr.PlayerGui -- put it in the player's gui
		end
	end
end)



local datastoreservice = game:GetService("DataStoreService") -- These two lines are the datastores
local bandata = datastoreservice:GetDataStore("TimedBans")

game.Players.PlayerAdded:Connect(function(plr) -- When a player joins the server
	local data = bandata:GetAsync(plr.UserId) -- Ban Data we stored
	if data[1] == plr.UserId then
		if os.time() >= data[2] then
			bandata:SetAsync(plr.UserId,{".",".","."})
		else
			local d = data[2] - os.time()
			local s = d / 86400 -- Days
			local f = math.round(s)
			plr:Kick("\n You have been banned\n For: "..data[3].."\n Day/Days Left Until Unban: "..f.."")
		end
	end
end)

