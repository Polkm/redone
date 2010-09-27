local Entity = FindMetaTable("Entity")

--#|###|%%%%%|
--Jigger323


function Entity:AddItem(strItem, intAmount)
	if !ValidEntity(self) then return false end
	local tblItemTable = GAMEMODE.DataBase.Items[strItem]
	if !tblItemTable then return false end
	intAmount = tonumber(intAmount) or 1
	self.Data = self.Data or {}
	self.Data.Inventory = self.Data.Inventory or {}
	self.Data.Inventory[strItem] = self.Data.Inventory[strItem] or 0
	self.Weight = self.Weight or 0
	local intMaxItems = math.Clamp(math.floor((self:GetMaxWeight() - self.Weight) / tblItemTable.Weight), 0, intAmount)
	intAmount = math.Clamp(intAmount, -self.Data.Inventory[strItem], intMaxItems)
	if intAmount == 0 then return false end
	if SERVER then
		if self.Data.Paperdoll && intAmount < 0 then
			if self.Data.Inventory[strItem] == 1 && self.Data.Paperdoll[tblItemTable.Slot] == strItem then
				self:UseItem(strItem)
			end
		end
	end
	self.Data.Inventory[strItem] = self.Data.Inventory[strItem] + intAmount
	self.Weight = self.Weight + (tblItemTable.Weight * intAmount)
	if SERVER && self:GetClass() == "player" then
		SendUsrMsg("UD_UpdateItem", self, {strItem, intAmount})
		self:SaveGame()
	end
	if CLIENT then
		if GAMEMODE.MainMenu then GAMEMODE.MainMenu.InventoryTab:LoadInventory() end
		if GAMEMODE.ShopMenu then GAMEMODE.ShopMenu:LoadShop() end
		if GAMEMODE.ShopMenu then GAMEMODE.ShopMenu:LoadPlayer() end
		if GAMEMODE.BankMenu then GAMEMODE.BankMenu:LoadPlayer() end
		if GAMEMODE.UpdateHotBar then GAMEMODE:UpdateHotBar() end
	end
	return true
end


concommand.Add("PrintSomething", function()
	math.pSeedRand(1337)
	print(math.pRand(), math.pRand(), math.pRand())
	--math.srand(1337)
	print(math.pRand(), math.pRand(), math.pRand())
	--[[
	for i = 0, 10 do
		math.randomseed(1337)
		print(math.random(), math.random(), math.random())
	end]]
end)