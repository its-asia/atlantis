_G.AutoFocus = _G.AutoFocus or true -- whether or not to auto focus custom chat bar when you press /

-- end of settings

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local TextButton = Instance.new("TextButton")
local TextButton_2 = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")

local TextBox = Instance.new("TextBox")
local textboxUICorner = Instance.new("UICorner")

if game:GetService('CoreGui'):FindFirstChild('atlantisfunny') then
	game:GetService('CoreGui'):FindFirstChild('atlantisfunny'):Destroy()
end

ScreenGui.Name = 'atlantisfunny'
ScreenGui.IgnoreGuiInset = true
ScreenGui.Enabled = false
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService('CoreGui')
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Frame.BackgroundTransparency = 0.200
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 450, 0, 250)
Frame.Visible = false

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Frame

Title.Name = "Title"
Title.Parent = Frame
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0.5, 0, 0, 0)
Title.Size = UDim2.new(1, -60, 0, 30)
Title.Font = Enum.Font.Gotham
Title.Text = "atlantis: jg edition"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000

ScrollingFrame.Parent = Frame
ScrollingFrame.Active = true
ScrollingFrame.AnchorPoint = Vector2.new(0, 1)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ScrollingFrame.BackgroundTransparency = 1.000
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, 1, 0)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollingFrame.ScrollBarThickness = 8

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout.CellSize = UDim2.new(0, 110, 0, 30)

TextButton.Parent = ScrollingFrame
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Font = Enum.Font.Gotham
TextButton.Text = "baseplate"
TextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
TextButton.TextSize = 14.000

TextButton_2.Parent = ScreenGui
TextButton_2.AnchorPoint = Vector2.new(0, 1)
TextButton_2.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
TextButton_2.BackgroundTransparency = 0.200
TextButton_2.Position = UDim2.new(0, 8, 1, -25)
TextButton_2.Size = UDim2.new(0, 100, 0, 30)
TextButton_2.Font = Enum.Font.Gotham
TextButton_2.Text = "open"
TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton_2.TextSize = 14.000

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = TextButton_2

TextBox.Parent = ScreenGui
TextBox.AnchorPoint = Vector2.new(0, 1)
TextBox.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
TextBox.BackgroundTransparency = 0.200
TextBox.Position = UDim2.new(0, 8, 1, -63)
TextBox.Size = UDim2.new(0, 200, 0, 30)
TextBox.Font = Enum.Font.Gotham
TextBox.PlaceholderText = "chat here"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14.000

textboxUICorner.CornerRadius = UDim.new(0, 5)
textboxUICorner.Name = "textboxUICorner"
textboxUICorner.Parent = TextBox

do
	local DragSpeed = 0
	local StartPos
	local DragToggle, DragInput, DragStart, DragPos

	local TweenService = game:GetService('TweenService')
	local function UpdateInput(Input)
		local Delta = Input.Position - DragStart
		local Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)

		Frame.Position = Position

		local Tween = TweenService.Create(TweenService, Frame, TweenInfo.new(0.25), {Position = Position});
		Tween.Play(Tween);
	end

	Frame.InputBegan:Connect(function(Input)
		if ((Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and game:GetService('UserInputService'):GetFocusedTextBox() == nil) then
			DragToggle = true
			DragStart = Input.Position
			StartPos = Frame.Position

			Input.Changed:Connect(function()
				if (Input.UserInputState == Enum.UserInputState.End) then
					DragToggle = false
				end
			end)
		end
	end)

	Frame.InputChanged:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
			DragInput = Input
		end
	end)

	game:GetService('UserInputService').InputChanged:Connect(function(Input)
		if (Input == DragInput and DragToggle) then
			UpdateInput(Input)
		end
	end)
end

local Template = TextButton:Clone()
local function addButton(name, func)
	local button = Template:Clone()

	button.Name = name
	button.Text = name:lower()

	button.MouseButton1Down:Connect(func)
	button.TouchTap:Connect(func)

	button.Parent = ScrollingFrame
end

local splitHeader = '|AAsplit|'
local messageTroller = tostring(game.PlaceId * 2.382283)

local function boomboxError(text)
	if not text then return false end

	local boombox = LocalPlayer.Backpack:FindFirstChild('BoomBox') or LocalPlayer.Character:FindFirstChild('BoomBox')
	if not boombox then return false end

	local lastParent = boombox.Parent
	local remote = boombox:FindFirstChild('RemoteEvent')
	
	local newtext = ''
	
	local textSplit = string.gmatch(text, '.')
	for letter, _ in textSplit do
		newtext = newtext .. letter .. messageTroller
	end

	newtext = splitHeader .. newtext .. splitHeader .. tick()
	boombox.Parent = LocalPlayer.Character

	remote:FireServer(newtext)

	boombox.Parent = lastParent

	return true
end

local function getMessageFromError(text)
	local split = text:split(splitHeader)

	local address = split[1] -- the roblox.com address gets removed by the reciever so it doesnt really matter lol
	if not address then return end

	local message = split[2] -- usually the message, if some moron decides to use |AAsplit| in their message kinda their fault lol
	if not message then return end
	
	message = message:gsub(messageTroller, '') -- removes the thing we use to hide our messages, wouldn't want a skid checking console!

	local when = split[3] -- when the message happened (local time)
	if not when then return end

	return message
end

TextButton_2.MouseButton1Down:Connect(function()
	Frame.Visible = not Frame.Visible

	if Frame.Visible then
		TextButton_2.Text = 'close'
	else
		TextButton_2.Text = 'open'
	end
end)

addButton('baseplate', function()
	local baseplate = workspace:FindFirstChild('AABaseplate') or Instance.new('Part')

	baseplate.Size = Vector3.new(512, 20, 512)
	baseplate.Position = Vector3.new(0, 800, 0)
	baseplate.Color = Color3.fromRGB(99, 95, 98)

	baseplate.Name = 'AABaseplate'
	baseplate.TopSurface = 'Studs'

	baseplate.Anchored = true
	baseplate.CastShadow = false

	baseplate.Parent = workspace
	LocalPlayer.Character:MoveTo(baseplate.Position)
end)

addButton('remove plate', function()
	local baseplate = workspace:FindFirstChild('AABaseplate') or Instance.new('Part')

	LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(0, 50 + 20, 0)); task.wait()
	baseplate:Destroy()
end)

addButton('refresh', function()
	local ChatBar     = LocalPlayer:FindFirstChildWhichIsA('PlayerGui'):FindFirstChild('Chat'):FindFirstChild('Frame'):FindFirstChild('ChatBarParentFrame'):FindFirstChild('Frame'):FindFirstChild('BoxFrame'):FindFirstChild('Frame'):FindFirstChild('ChatBar')
	local ChatBarText = ChatBar.Text

	ChatBar:SetTextFromInput('-re')
	Players:Chat('-re')
	ChatBar:SetTextFromInput(ChatBarText)
end)

addButton('respawn', function()
	local ChatBar     = LocalPlayer:FindFirstChildWhichIsA('PlayerGui'):FindFirstChild('Chat'):FindFirstChild('Frame'):FindFirstChild('ChatBarParentFrame'):FindFirstChild('Frame'):FindFirstChild('BoxFrame'):FindFirstChild('Frame'):FindFirstChild('ChatBar')
	local ChatBarText = ChatBar.Text

	ChatBar:SetTextFromInput('-gr')
	Players:Chat('-gr')
	ChatBar:SetTextFromInput(ChatBarText)
end)

addButton('reset', function()
	local Humanoid = LocalPlayer.Character:FindFirstChildOfClass('Humanoid')
	
	Humanoid.Health = 0
end)

TextButton.Parent = nil
ScreenGui.Enabled = true

local sentEvent = Instance.new('BindableEvent')

local connected = {}
local function sentConnection(boomBox)
	if table.find(connected, boomBox) then return end

	local handle = boomBox:FindFirstChild('Handle')
	if not handle then return end

	table.insert(connected, boomBox)

	local sound = handle:FindFirstChildOfClass('Sound')
	local function fire(sound)
		local soundId = sound.SoundId

		local character = boomBox.Parent
		local player = game:GetService('Players'):GetPlayerFromCharacter(character)

		if character:IsA('Backpack') then
			player = character:FindFirstAncestorOfClass('Player')
		end

		if not player then print('no player found for ' .. boomBox:GetFullName()) return end -- better safe than sorry lol
		local soundId = string.sub(soundId, 33, #soundId)

		sentEvent:Fire(player, soundId)
	end

	local function hook(sound, fireStart)
		if fireStart then
			fire(sound)
		end

		sound:GetPropertyChangedSignal('SoundId'):Connect(function()
			fire(sound)
		end)
	end

	if sound then
		hook(sound, true)
	end

	handle.ChildAdded:Connect(function(sound)
		if not sound:IsA('Sound') then return end

		hook(sound)
	end)
end

local function getRadios(character)
	local tools = character:GetChildren()
	local radios = {}

	for _, Tool in pairs(tools) do
		if not (Tool.Name == 'BoomBox') then continue end

		table.insert(radios, Tool)
	end

	return radios
end

local function characterAdded(character, player)
	local boomBoxes = getRadios(character)
	for _, boomBox in pairs(boomBoxes) do
		sentConnection(boomBox)
	end

	local backpack = player:FindFirstChildOfClass('Backpack')

	local boomBoxes = getRadios(backpack)
	for _, boomBox in pairs(boomBoxes) do
		sentConnection(boomBox)
	end

	backpack.ChildAdded:Connect(function(boomBox)
		if not (boomBox.Name == 'BoomBox') then return end

		sentConnection(boomBox)
	end)
end

local function playerAdded(Player)
	if Player.Character then
		characterAdded(Player.Character, Player)
	end

	Player.CharacterAdded:Connect(function(character)
		characterAdded(character, Player)
	end)
end

game:GetService('Players').PlayerAdded:Connect(playerAdded)

local cooldown = {}
for _, player in pairs(game:GetService('Players'):GetPlayers()) do
	playerAdded(player)
end

local adminColor = Color3.fromRGB(85, 255, 156)
local chatColors = {
	[154144731] = adminColor,
	[981335534] = adminColor,
	[630839350] = adminColor,
}

local textboxX = TextBox.Size.X.Offset

sentEvent.Event:Connect(function(player, message)
	if not ScreenGui:IsDescendantOf(game) then return end

	if cooldown[player.UserId] and cooldown[player.UserId] >= 30 then return end -- there is no time where saying 30 messages in .1 seconds is normal

	local message = getMessageFromError(message)
	if not message then return end

	local character = player.Character
	if not character then return end

	local head = character:FindFirstChild('Head')
	if not head then return end

	if message:len() >= 1000 then
		message = string.sub(message, 1, 1000)

		return
	end

	local color = chatColors[player.UserId] or Color3.fromRGB(255, 255, 255)

	cooldown[player.UserId] = cooldown[player.UserId] or 0
	cooldown[player.UserId] = cooldown[player.UserId] + 1

	game:GetService('Chat'):Chat(head, message, Enum.ChatColor.White)
	game:GetService('StarterGui'):SetCore('ChatMakeSystemMessage', {
		['Text'] = player.Name .. ': ' .. message,
		['Color'] = color,
		['Font'] = Enum.Font.SourceSansBold,
		['FontSize'] = Enum.FontSize.Size24})
end)

TextBox.FocusLost:Connect(function(enterPressed)
	if not enterPressed then return end

	local text = TextBox.Text
	local prefix = string.sub(text, 1, 1)

	TextBox.Text = ''

	if prefix ~= '!' then
		boomboxError(text)

		return
	end

	text = string.sub(text, 2, #text)

	local arguments = text:split(' ')
	local command = arguments[1]

	table.remove(arguments, 1)

	if command == 'autofocus' then 
		AutoFocus = not AutoFocus

		game:GetService('StarterGui'):SetCore('ChatMakeSystemMessage', {
			['Text'] = '{System} set autofocus setting to ' .. tostring(AutoFocus),
			['Color'] = Color3.fromRGB(255, 255, 255),
			['Font'] = Enum.Font.SourceSansBold,
			['FontSize'] = Enum.FontSize.Size24
		}) 
	elseif command == 'help' or command == 'cmds' then
		game:GetService('StarterGui'):SetCore('ChatMakeSystemMessage', {
			['Text'] = '{System} commands: !autofocus (changes your autofocus setting for the custom chatbar)',
			['Color'] = Color3.fromRGB(255, 255, 255),
			['Font'] = Enum.Font.SourceSansBold,
			['FontSize'] = Enum.FontSize.Size24
		}) 
	end
end)

TextBox:GetPropertyChangedSignal('Text'):Connect(function()
	if TextBox.TextBounds.X >= (textboxX - 20) then
		TextBox.Size = UDim2.new(0, TextBox.TextBounds.X + 20, 0, 30)
	else
		TextBox.Size = UDim2.new(0, textboxX, 0, 30)
	end
end)

game:GetService('UserInputService').InputBegan:Connect(function(input)
	if not ScreenGui:IsDescendantOf(game) then return end
	if not AutoFocus then return end

	if game:GetService('UserInputService'):GetFocusedTextBox() then return end
	if input.KeyCode ~= Enum.KeyCode.Slash then return end
	
	task.wait()
	
	local box = game:GetService('UserInputService'):GetFocusedTextBox()
	if box then
		box:ReleaseFocus()
	end
	
	TextBox:CaptureFocus()

	if TextBox.Text == '/' then
		TextBox.Text = ''
	end
end)

while true do
	task.wait(.1)

	if not ScreenGui:IsDescendantOf(game) then break end
	for id, amount in pairs(cooldown) do
		cooldown[id] = amount - 1
	end end
