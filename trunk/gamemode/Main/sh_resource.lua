local ClientPaths = {}
ClientPaths[1] = "gamemode/Main/client"

local ServerPaths = {}
ServerPaths[1] = "gamemode/Main/server"

local SharedPaths = {}
SharedPaths[1] = "gamemode/Main/shared"
SharedPaths[2] = "Data/items"
SharedPaths[3] = "Data/npcs"
SharedPaths[4] = "Data/quests"

for _, strPaths in pairs(SharedPaths) do
	local Path = string.Replace(GM.Folder,"gamemodes/","").."/" .. strPaths .. "/"
	for _,v in pairs(file.FindInLua(Path.."*.lua")) do
		include(Path..v)
		if SERVER then
			AddCSLuaFile(Path..v)
			print("Added cl file " .. v)
		end
	end
end
if SERVER then
	for _, strPaths in pairs(ServerPaths) do
		local Path = string.Replace(GM.Folder,"gamemodes/","").."/" .. strPaths .. "/"
		for _,v in pairs(file.FindInLua(Path.."*.lua")) do
			include(Path..v)
		end
	end
	for _, strPaths in pairs(ClientPaths) do
		local Path = string.Replace(GM.Folder,"gamemodes/","").."/" .. strPaths .. "/"
		for _,v in pairs(file.FindInLua(Path.."*.lua")) do
			AddCSLuaFile(Path..v)
			print("Added cl file " .. v)
		end
	end
	function resource.AddDir(dir, ext)
		for _, f in pairs(file.Find("../" .. dir .. "/*" .. (ext or ""))) do
			resource.AddFile(dir .. "/" .. f)
		end
	end	
else
	for _, strPaths in pairs(ClientPaths) do
		local Path = string.Replace(GM.Folder,"gamemodes/","").."/" .. strPaths .. "/"
		for _,v in pairs(file.FindInLua(Path.."*.lua")) do
			include(Path..v)
		end
	end
end