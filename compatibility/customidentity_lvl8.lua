-- custom identity
-- level 8

-- synapse > scriptware
-- dont run this without the proper functions you bozo

local GameMetatable = getrawmetatable(game); setreadonly(GameMetatable, false)
local GameNewIndex = GameMetatable.__newindex

GameMetatable.__newindex = newcclosure(function(self, Index, Value, ...)
	if self and checkcaller() then
		if gethiddenproperty and sethiddenproperty then
			local success, newindexreturn = pcall(GameNewIndex, self, Index, Value, ...)
			if not success then
				local isHidden, err = pcall(gethiddenproperty, self, Index)
				if not isHidden then return error(newindexreturn) end

				newindexreturn = nil

				pcall(sethiddenproperty, self, Index, Value)
			end

			return newindexreturn
		end
	end

	return GameNewIndex(self, Index, Value, ...)
end)

setreadonly(GameMetatable, true)

local OriginalPrintIdentity = printidentity
if getgenv and getgenv() and not getgenv().originalprintidentity then
	getgenv().originalprintidentity = OriginalPrintIdentity
	getgenv().printidentity = function()
		print('Current identity is 8')
	end
end
