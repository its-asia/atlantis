local Atlantis = {}

local Services = {}
local MetaServices = {__index = function(self, index) return rawget(Services, index) or game:GetService(index) end}

setmetatable(Services, MetaServices)

if not game:IsLoaded() then
	game.Loaded:Wait()
end

Atlantis.LocalPlayer = Services.Players.LocalPlayer

if Atlantis.LocalPlayer == nil then
	repeat task.wait()
		Atlantis.LocalPlayer = Services.Players.LocalPlayer
	until Atlantis.LocalPlayer ~= nil
end

function Dragify(Frame, Topbar)
	local dragToggle = nil
	local dragSpeed = 0.15
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil

	local Delta = UDim2.new()
	local Position = UDim2.new()

	local startPos = UDim2.new()
	local Topbar = Topbar or Frame

	local function updateInput(input)
		Delta = input.Position - dragStart
		Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)

		Frame.Position = Position
	end

	Topbar.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and Services.UserInputService:GetFocusedTextBox() == nil then
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	Topbar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	Services.UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragToggle then
			updateInput(input)
		end
	end)
end

local FileFunctions = {
	['writefile'] = writefile,
	['appendfile'] = appendfile,
	['readfile'] = readfile,
	['isfile'] = isfile,
	['delfile'] = delfile,
	['listfiles'] = listfiles,
	['isfolder'] = isfolder,
	['makefolder'] = makefolder,
	['delfolder'] = delfolder,
}

if not FileFunctions.isfolder('atlantis') then
	FileFunctions.makefolder('atlantis')
end

if not FileFunctions.isfolder('atlantis/executor') then
	FileFunctions.makefolder('atlantis/executor')
end

if not FileFunctions.isfolder('atlantis/executor/saves') then
	FileFunctions.makefolder('atlantis/executor/saves')
end

Atlantis.Gui = Instance.new('ScreenGui')

Atlantis.CachedPaths = {}
Atlantis.UIElements = {}

Atlantis.Frames = {}
Atlantis.Images = {}
Atlantis.Text = {}

Atlantis.Frames.Atlantis = Instance.new("Frame")

Atlantis.Frames.Topbar = Instance.new("Frame")
Atlantis.Frames.Actions = Instance.new("Frame")
Atlantis.Frames.Branding = Instance.new("Frame")

Atlantis.Frames.Frame = Instance.new("Frame")
Atlantis.Frames.Bottombar = Instance.new("Frame")

Atlantis.Frames.Left = Instance.new("Frame")
Atlantis.Frames.Right = Instance.new("Frame")

Atlantis.Frames.NameInput = Instance.new("Frame")

Atlantis.Frames.Executor = Instance.new("ScrollingFrame")
Atlantis.Frames.Scripts = Instance.new("ScrollingFrame")

Atlantis.UIElements.UICorner = Instance.new("UICorner")
Atlantis.UIElements.UICorner_2 = Instance.new("UICorner")
Atlantis.UIElements.UICorner_3 = Instance.new("UICorner")

Atlantis.UIElements.UIListLayout = Instance.new("UIListLayout")
Atlantis.UIElements.UIListLayout_2 = Instance.new("UIListLayout")
Atlantis.UIElements.UIListLayout_3 = Instance.new("UIListLayout")
Atlantis.UIElements.UIListLayout_4 = Instance.new("UIListLayout")
Atlantis.UIElements.UIListLayout_5 = Instance.new("UIListLayout")

Atlantis.UIElements.UIPadding = Instance.new("UIPadding")
Atlantis.UIElements.UIPadding_2 = Instance.new("UIPadding")
Atlantis.UIElements.UIPadding_3 = Instance.new("UIPadding")
Atlantis.UIElements.UIPadding_4 = Instance.new("UIPadding")

Atlantis.Images.Maximize = Instance.new("ImageButton")
Atlantis.Images.Minimize = Instance.new("ImageButton")
Atlantis.Images.Close = Instance.new("ImageButton")

Atlantis.Images.Clear = Instance.new("ImageButton")
Atlantis.Images.Execute = Instance.new("ImageButton")

Atlantis.Images.Save = Instance.new("ImageButton")
Atlantis.Images.Delete = Instance.new("ImageButton")

Atlantis.Text.Title = Instance.new("TextLabel")

Atlantis.Text.Lines = Instance.new("TextLabel")
Atlantis.Text.Source = Instance.new("TextBox")

Atlantis.Text.TextLabel = Instance.new("TextLabel")
Atlantis.Text.TextLabel_2 = Instance.new("TextLabel")
Atlantis.Text.TextLabel_3 = Instance.new("TextLabel")
Atlantis.Text.TextLabel_4 = Instance.new("TextLabel")

Atlantis.Text.Script = Instance.new("TextButton")

Atlantis.Text.Finalize = Instance.new("TextButton")
Atlantis.Text.Input = Instance.new("TextBox")

Atlantis.Frames.Atlantis.Name = "Atlantis"
Atlantis.Frames.Atlantis.Parent = Atlantis.Gui
Atlantis.Frames.Atlantis.AnchorPoint = Vector2.new(0.5, 0.5)
Atlantis.Frames.Atlantis.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Atlantis.Frames.Atlantis.Position = UDim2.new(0.83, 0, 0.8, 0)
Atlantis.Frames.Atlantis.Size = UDim2.new(0, 450, 0, 290)

Atlantis.UIElements.UICorner.CornerRadius = UDim.new(0, 10)
Atlantis.UIElements.UICorner.Parent = Atlantis.Frames.Atlantis

Atlantis.Frames.Topbar.Name = "Topbar"
Atlantis.Frames.Topbar.Parent = Atlantis.Frames.Atlantis
Atlantis.Frames.Topbar.AnchorPoint = Vector2.new(0.5, 0)
Atlantis.Frames.Topbar.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
Atlantis.Frames.Topbar.Position = UDim2.new(0.5, 0, 0, 0)
Atlantis.Frames.Topbar.Size = UDim2.new(1, 0, 0, 40)

Atlantis.UIElements.UICorner_2.CornerRadius = UDim.new(0, 10)
Atlantis.UIElements.UICorner_2.Parent = Atlantis.Frames.Topbar

Atlantis.Frames.Actions.Name = "Actions"
Atlantis.Frames.Actions.Parent = Atlantis.Frames.Topbar
Atlantis.Frames.Actions.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Actions.BackgroundTransparency = 1.000
Atlantis.Frames.Actions.Size = UDim2.new(1, 0, 1, 0)

Atlantis.UIElements.UIListLayout.Parent = Atlantis.Frames.Actions
Atlantis.UIElements.UIListLayout.FillDirection = Enum.FillDirection.Horizontal
Atlantis.UIElements.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
Atlantis.UIElements.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
Atlantis.UIElements.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
Atlantis.UIElements.UIListLayout.Padding = UDim.new(0, 5)

Atlantis.UIElements.UIPadding.Parent = Atlantis.Frames.Actions
Atlantis.UIElements.UIPadding.PaddingLeft = UDim.new(0, 10)
Atlantis.UIElements.UIPadding.PaddingRight = UDim.new(0, 10)

Atlantis.Images.Maximize.Name = "Maximize"
Atlantis.Images.Maximize.Parent = Atlantis.Frames.Actions
Atlantis.Images.Maximize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Maximize.BackgroundTransparency = 1.000
Atlantis.Images.Maximize.LayoutOrder = 9
Atlantis.Images.Maximize.Size = UDim2.new(0, 18, 0, 18)
Atlantis.Images.Maximize.Image = "rbxassetid://7072718726"

Atlantis.Images.Close.Name = "Close"
Atlantis.Images.Close.Parent = Atlantis.Frames.Actions
Atlantis.Images.Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Close.BackgroundTransparency = 1.000
Atlantis.Images.Close.LayoutOrder = 10
Atlantis.Images.Close.Size = UDim2.new(0, 18, 0, 18)
Atlantis.Images.Close.Image = "rbxassetid://7072725342"

Atlantis.Images.Minimize.Name = "Minimize"
Atlantis.Images.Minimize.Parent = Atlantis.Frames.Actions
Atlantis.Images.Minimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Minimize.BackgroundTransparency = 1.000
Atlantis.Images.Minimize.LayoutOrder = 8
Atlantis.Images.Minimize.Size = UDim2.new(0, 18, 0, 18)
Atlantis.Images.Minimize.Image = "rbxassetid://7072719338"

Atlantis.Frames.Branding.Name = "Branding"
Atlantis.Frames.Branding.Parent = Atlantis.Frames.Topbar
Atlantis.Frames.Branding.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Branding.BackgroundTransparency = 1.000
Atlantis.Frames.Branding.Size = UDim2.new(1, 0, 1, 0)

Atlantis.Text.Title.Name = "Title"
Atlantis.Text.Title.Parent = Atlantis.Frames.Branding
Atlantis.Text.Title.AnchorPoint = Vector2.new(0, 0.5)
Atlantis.Text.Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Title.BackgroundTransparency = 1.000
Atlantis.Text.Title.Position = UDim2.new(0, 0, 0.5, 0)
Atlantis.Text.Title.Size = UDim2.new(0, 200, 0, 14)
Atlantis.Text.Title.Font = Enum.Font.Gotham
Atlantis.Text.Title.Text = "Atlantis"
Atlantis.Text.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Title.TextSize = 14.000
Atlantis.Text.Title.TextXAlignment = Enum.TextXAlignment.Left

Atlantis.UIElements.UIListLayout_2.Parent = Atlantis.Frames.Branding
Atlantis.UIElements.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
Atlantis.UIElements.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
Atlantis.UIElements.UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
Atlantis.UIElements.UIListLayout_2.Padding = UDim.new(0, 5)

Atlantis.UIElements.UIPadding_2.Parent = Atlantis.Frames.Branding
Atlantis.UIElements.UIPadding_2.PaddingLeft = UDim.new(0, 10)
Atlantis.UIElements.UIPadding_2.PaddingRight = UDim.new(0, 10)

Atlantis.Frames.Executor.Name = "Executor"
Atlantis.Frames.Executor.Parent = Atlantis.Frames.Atlantis
Atlantis.Frames.Executor.Active = true
Atlantis.Frames.Executor.AnchorPoint = Vector2.new(0, 1)
Atlantis.Frames.Executor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Executor.BackgroundTransparency = 1.000
Atlantis.Frames.Executor.BorderSizePixel = 0
Atlantis.Frames.Executor.Position = UDim2.new(0, 10, 1, -40)
Atlantis.Frames.Executor.Size = UDim2.new(1, -80, 1, -90)
Atlantis.Frames.Executor.CanvasSize = UDim2.new(0, 0, 0, 0)
Atlantis.Frames.Executor.ScrollBarThickness = 0

Atlantis.Text.Lines.Name = "Lines"
Atlantis.Text.Lines.Parent = Atlantis.Frames.Executor
Atlantis.Text.Lines.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Lines.BackgroundTransparency = 1.000
Atlantis.Text.Lines.Size = UDim2.new(0, 30, 1, 0)
Atlantis.Text.Lines.Font = Enum.Font.Gotham
Atlantis.Text.Lines.Text = "1"
Atlantis.Text.Lines.TextColor3 = Color3.fromRGB(75, 75, 75)
Atlantis.Text.Lines.TextSize = 14.000
Atlantis.Text.Lines.TextXAlignment = Enum.TextXAlignment.Left
Atlantis.Text.Lines.TextYAlignment = Enum.TextYAlignment.Top

Atlantis.Frames.Frame.Parent = Atlantis.Text.Lines
Atlantis.Frames.Frame.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
Atlantis.Frames.Frame.BackgroundTransparency = 0.500
Atlantis.Frames.Frame.BorderSizePixel = 0
Atlantis.Frames.Frame.Position = UDim2.new(1, 0, 0, 0)
Atlantis.Frames.Frame.Size = UDim2.new(0, 1, 1, 0)

Atlantis.Text.Source.Name = "Source"
Atlantis.Text.Source.Parent = Atlantis.Frames.Executor
Atlantis.Text.Source.AnchorPoint = Vector2.new(1, 0)
Atlantis.Text.Source.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Source.BackgroundTransparency = 1.000
Atlantis.Text.Source.Position = UDim2.new(1, 0, 0, 0)
Atlantis.Text.Source.Size = UDim2.new(1, -36, 1, 0)
Atlantis.Text.Source.Font = Enum.Font.Gotham
Atlantis.Text.Source.Text = ""
Atlantis.Text.Source.TextColor3 = Color3.fromRGB(235, 235, 235)
Atlantis.Text.Source.TextSize = 14.000
Atlantis.Text.Source.TextXAlignment = Enum.TextXAlignment.Left
Atlantis.Text.Source.TextYAlignment = Enum.TextYAlignment.Top
Atlantis.Text.Source.ClearTextOnFocus = false
Atlantis.Text.Source.MultiLine = true

Atlantis.Frames.Bottombar.Name = "Bottombar"
Atlantis.Frames.Bottombar.Parent = Atlantis.Frames.Atlantis
Atlantis.Frames.Bottombar.AnchorPoint = Vector2.new(0, 1)
Atlantis.Frames.Bottombar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Bottombar.BackgroundTransparency = 1.000
Atlantis.Frames.Bottombar.Position = UDim2.new(0, 10, 1, 0)
Atlantis.Frames.Bottombar.Size = UDim2.new(1, -10, 0, 35)

Atlantis.Frames.Left.Name = "Left"
Atlantis.Frames.Left.Parent = Atlantis.Frames.Bottombar
Atlantis.Frames.Left.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Left.BackgroundTransparency = 1.000
Atlantis.Frames.Left.Size = UDim2.new(1, 0, 1, 0)

Atlantis.Images.Execute.Name = "Execute"
Atlantis.Images.Execute.Parent = Atlantis.Frames.Left
Atlantis.Images.Execute.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Execute.BackgroundTransparency = 1.000
Atlantis.Images.Execute.Size = UDim2.new(0, 20, 0, 20)
Atlantis.Images.Execute.Image = "rbxassetid://7072720722"
Atlantis.Images.Execute.LayoutOrder = 1

Atlantis.Text.TextLabel.Parent = Atlantis.Images.Execute
Atlantis.Text.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel.BackgroundTransparency = 1.000
Atlantis.Text.TextLabel.Position = UDim2.new(1, 5, 0, 0)
Atlantis.Text.TextLabel.Size = UDim2.new(0, 200, 1, 0)
Atlantis.Text.TextLabel.Font = Enum.Font.Gotham
Atlantis.Text.TextLabel.Text = "Execute"
Atlantis.Text.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel.TextSize = 13.000
Atlantis.Text.TextLabel.TextXAlignment = Enum.TextXAlignment.Left

Atlantis.Images.Clear.Name = "Clear"
Atlantis.Images.Clear.Parent = Atlantis.Frames.Left
Atlantis.Images.Clear.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Clear.BackgroundTransparency = 1.000
Atlantis.Images.Clear.Size = UDim2.new(0, 20, 0, 20)
Atlantis.Images.Clear.Image = "rbxassetid://7072715962"
Atlantis.Images.Clear.LayoutOrder = 2

Atlantis.Text.TextLabel_2.Parent = Atlantis.Images.Clear
Atlantis.Text.TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel_2.BackgroundTransparency = 1.000
Atlantis.Text.TextLabel_2.Position = UDim2.new(1, 5, 0, 0)
Atlantis.Text.TextLabel_2.Size = UDim2.new(0, 200, 1, 0)
Atlantis.Text.TextLabel_2.Font = Enum.Font.Gotham
Atlantis.Text.TextLabel_2.Text = "Clear"
Atlantis.Text.TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel_2.TextSize = 13.000
Atlantis.Text.TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

Atlantis.UIElements.UIPadding_3.Parent = Atlantis.Frames.Left
Atlantis.UIElements.UIPadding_3.PaddingLeft = UDim.new(0, 10)
Atlantis.UIElements.UIPadding_3.PaddingRight = UDim.new(0, 10)

Atlantis.UIElements.UIListLayout_3.Parent = Atlantis.Frames.Left
Atlantis.UIElements.UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
Atlantis.UIElements.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
Atlantis.UIElements.UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
Atlantis.UIElements.UIListLayout_3.Padding = UDim.new(0, 60)

Atlantis.Frames.Right.Name = "Right"
Atlantis.Frames.Right.Parent = Atlantis.Frames.Bottombar
Atlantis.Frames.Right.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Right.BackgroundTransparency = 1.000
Atlantis.Frames.Right.Size = UDim2.new(1, 0, 1, 0)

Atlantis.Images.Save.Name = "Save"
Atlantis.Images.Save.Parent = Atlantis.Frames.Right
Atlantis.Images.Save.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Save.BackgroundTransparency = 1.000
Atlantis.Images.Save.Size = UDim2.new(0, 20, 0, 20)
Atlantis.Images.Save.Image = "rbxassetid://7072724296"
Atlantis.Images.Save.LayoutOrder = 1

Atlantis.Text.TextLabel_3.Parent = Atlantis.Images.Save
Atlantis.Text.TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel_3.BackgroundTransparency = 1.000
Atlantis.Text.TextLabel_3.Position = UDim2.new(1, 5, 0, 0)
Atlantis.Text.TextLabel_3.Size = UDim2.new(0, 200, 1, 0)
Atlantis.Text.TextLabel_3.Font = Enum.Font.Gotham
Atlantis.Text.TextLabel_3.Text = "Save"
Atlantis.Text.TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel_3.TextSize = 13.000
Atlantis.Text.TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

Atlantis.UIElements.UIPadding_4.Parent = Atlantis.Frames.Right
Atlantis.UIElements.UIPadding_4.PaddingLeft = UDim.new(0, 50)
Atlantis.UIElements.UIPadding_4.PaddingRight = UDim.new(0, 50)

Atlantis.UIElements.UIListLayout_4.Parent = Atlantis.Frames.Right
Atlantis.UIElements.UIListLayout_4.FillDirection = Enum.FillDirection.Horizontal
Atlantis.UIElements.UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Right
Atlantis.UIElements.UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
Atlantis.UIElements.UIListLayout_4.VerticalAlignment = Enum.VerticalAlignment.Center
Atlantis.UIElements.UIListLayout_4.Padding = UDim.new(0, 60)

Atlantis.Frames.NameInput.Name = "NameInput"
Atlantis.Frames.NameInput.Visible = false
Atlantis.Frames.NameInput.Parent = Atlantis.Frames.Atlantis
Atlantis.Frames.NameInput.AnchorPoint = Vector2.new(0.5, 0)
Atlantis.Frames.NameInput.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Atlantis.Frames.NameInput.Position = UDim2.new(0.5, 0, 1, 5)
Atlantis.Frames.NameInput.Size = UDim2.new(1, 0, 0, 30)

Atlantis.UIElements.UICorner_3.CornerRadius = UDim.new(0, 10)
Atlantis.UIElements.UICorner_3.Parent = Atlantis.Frames.NameInput

Atlantis.Text.Finalize.Name = "Finalize"
Atlantis.Text.Finalize.Parent = Atlantis.Frames.NameInput
Atlantis.Text.Finalize.AnchorPoint = Vector2.new(1, 0)
Atlantis.Text.Finalize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Finalize.BackgroundTransparency = 1.000
Atlantis.Text.Finalize.Position = UDim2.new(1, 0, 0, 0)
Atlantis.Text.Finalize.Size = UDim2.new(0, 70, 1, 0)
Atlantis.Text.Finalize.Font = Enum.Font.Gotham
Atlantis.Text.Finalize.Text = "Finalize"
Atlantis.Text.Finalize.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Finalize.TextSize = 13.000

Atlantis.Text.Input.Name = "Input"
Atlantis.Text.Input.Parent = Atlantis.Frames.NameInput
Atlantis.Text.Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Input.BackgroundTransparency = 1.000
Atlantis.Text.Input.Position = UDim2.new(0, 8, 0, 0)
Atlantis.Text.Input.Size = UDim2.new(1, -78, 1, 0)
Atlantis.Text.Input.Font = Enum.Font.Gotham
Atlantis.Text.Input.PlaceholderColor3 = Color3.fromRGB(75, 75, 75)
Atlantis.Text.Input.PlaceholderText = "File Name"
Atlantis.Text.Input.Text = ""
Atlantis.Text.Input.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Input.TextSize = 13.000
Atlantis.Text.Input.TextWrapped = true
Atlantis.Text.Input.TextXAlignment = Enum.TextXAlignment.Left

Atlantis.Images.Delete.Name = "Delete"
Atlantis.Images.Delete.Parent = Atlantis.Frames.Right
Atlantis.Images.Delete.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Images.Delete.BackgroundTransparency = 1.000
Atlantis.Images.Delete.Size = UDim2.new(0, 20, 0, 20)
Atlantis.Images.Delete.Image = "rbxassetid://7072723769"
Atlantis.Images.Delete.LayoutOrder = 2

Atlantis.Text.TextLabel_4.Parent = Atlantis.Images.Delete
Atlantis.Text.TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel_4.BackgroundTransparency = 1.000
Atlantis.Text.TextLabel_4.Position = UDim2.new(1, 5, 0, 0)
Atlantis.Text.TextLabel_4.Size = UDim2.new(0, 200, 1, 0)
Atlantis.Text.TextLabel_4.Font = Enum.Font.Gotham
Atlantis.Text.TextLabel_4.Text = "Delete"
Atlantis.Text.TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.TextLabel_4.TextSize = 13.000
Atlantis.Text.TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left

Atlantis.Frames.Scripts.Name = "Scripts"
Atlantis.Frames.Scripts.Parent = Atlantis.Frames.Atlantis
Atlantis.Frames.Scripts.Active = true
Atlantis.Frames.Scripts.AnchorPoint = Vector2.new(1, 1)
Atlantis.Frames.Scripts.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Frames.Scripts.BackgroundTransparency = 1.000
Atlantis.Frames.Scripts.Position = UDim2.new(1, -8, 1, -40)
Atlantis.Frames.Scripts.Size = UDim2.new(0, 55, 1, -90)
Atlantis.Frames.Scripts.CanvasSize = UDim2.new(0, 0, 0, 0)
Atlantis.Frames.Scripts.ScrollBarThickness = 0

Atlantis.Text.Script.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Atlantis.Text.Script.BackgroundTransparency = 1.000
Atlantis.Text.Script.Size = UDim2.new(1, 0, 0, 16)
Atlantis.Text.Script.Font = Enum.Font.Gotham
Atlantis.Text.Script.TextColor3 = Color3.fromRGB(75, 75, 75)
Atlantis.Text.Script.TextSize = 13.000

Atlantis.UIElements.UIListLayout_5.Parent = Atlantis.Frames.Scripts

function Atlantis:Clear()
	local TweenService = Services.TweenService
	local Create = TweenService.Create
	
	local Time = .25
	
	Create(TweenService, Atlantis.Text.Lines, TweenInfo.new(Time), {TextTransparency = 1}):Play()
	Create(TweenService, Atlantis.Text.Source, TweenInfo.new(Time), {TextTransparency = 1}):Play(); task.wait(Time); Atlantis.Text.Source.Text = ''
	
	Atlantis.Text.Source.TextTransparency = 0
	Atlantis.Text.Lines.TextTransparency = 0
end

function Atlantis:Execute()
	local Source = Atlantis.Text.Source.Text
	local Format = 'Atlantis encountered an error:\n%s'
	
	xpcall(function()
		loadstring(Source)()
	end, function(Error)
		if not printconsole then
			warn(string.format(Format, Error))
			
			return
		end
		
		printconsole(string.format(Format, Error), 255, 0, 0)
	end)
end

function Atlantis:Save()
	local Source = Atlantis.Text.Source.Text
	local Format = 'atlantis/executor/saves/%s.lua'

	if Atlantis.Frames.NameInput.Visible == true then return end

	Atlantis.Frames.NameInput.Visible = true
	Atlantis.Text.Finalize.MouseButton1Click:Wait()
	
	local FileName = Atlantis.Text.Input.Text
	local FilePath = string.format(Format, FileName)
	
	FileFunctions.writefile(FilePath, Source)
	Atlantis:AddToScripts(FilePath)

	Atlantis.Text.Input.Text = ''
	Atlantis.Frames.NameInput.Visible = false
end

function Atlantis:Delete()
	local Source = Atlantis.Text.Source.Text
	local Format = 'atlantis/executor/saves/%s.lua'
	
	if Atlantis.Frames.NameInput.Visible == true then return end

	Atlantis.Frames.NameInput.Visible = true
	Atlantis.Text.Finalize.MouseButton1Click:Wait()

	local FileName = Atlantis.Text.Input.Text
	local FilePath = string.format(Format, FileName)
	
	if FileFunctions.isfile(FilePath) then
		FileFunctions.delfile(FilePath)
		Atlantis.CachedPaths[FilePath] = nil
		
		if Atlantis.Frames.Scripts:FindFirstChild(FileName) then
			Atlantis.Frames.Scripts:FindFirstChild(FileName):Destroy()
		end
	end
	
	Atlantis.Text.Input.Text = ''
	Atlantis.Frames.NameInput.Visible = false
end

function Atlantis:Close()
	xpcall(function()
		syn.unprotect_gui(Atlantis.Gui)
	end, function()
		warn(Atlantis.LocalPlayer.Name .. ' is not using synapse x!')
	end)
	
	Atlantis.Gui:Destroy()
end

function Atlantis:AddToScripts(Path)
	Path = Path:gsub('\\', '/')
	
	if Atlantis.CachedPaths[Path] == true then
		return
	else
		Atlantis.CachedPaths[Path] = true
	end
	
	local PathTable = Path:split('/')

	local FileNameFull = PathTable[#PathTable]
	local FileName = FileNameFull:split('.')[1]

	local ScriptButton = Atlantis.Text.Script:Clone()

	ScriptButton.Text = FileName
	ScriptButton.Name = FileName
	
	ScriptButton.MouseButton1Click:Connect(function()
		if not FileFunctions.isfile(Path) then
			ScriptButton:Destroy()

			return
		end

		local FileData = FileFunctions.readfile(Path)

		Atlantis.Text.Source.Text = FileData
	end)

	ScriptButton.Parent = Atlantis.Frames.Scripts
end

Atlantis.Images.Save.MouseButton1Click:Connect(Atlantis.Save)
Atlantis.Images.Delete.MouseButton1Click:Connect(Atlantis.Delete)

Atlantis.Images.Clear.MouseButton1Click:Connect(Atlantis.Clear)
Atlantis.Images.Execute.MouseButton1Click:Connect(Atlantis.Execute)

Atlantis.Images.Close.MouseButton1Click:Connect(Atlantis.Close)

Atlantis.Text.Source:GetPropertyChangedSignal('Text'):Connect(function()
	local Lines, String = 1, ''
	for Line in string.gmatch(Atlantis.Text.Source.Text, '\n') do
		Lines = Lines + 1
		String = String .. Lines - 1 .. '\n'
	end

	Lines = Lines + 1
	String = String .. Lines - 1 .. '\n'

	Atlantis.Text.Lines.Text = String

	local Size = Atlantis.Text.Source.TextSize * (Lines + .5)
	if Size > Atlantis.Frames.Executor.AbsoluteSize.Y then
		Atlantis.Frames.Executor.CanvasSize = UDim2.new(0, 0, 0, Size)
	else
		Atlantis.Frames.Executor.CanvasSize = UDim2.new(0, 0, 0, 0)
	end
end)

Dragify(Atlantis.Frames.Atlantis, Atlantis.Frames.Topbar)

xpcall(function()
	syn.protect_gui(Atlantis.Gui)
end, function()
	warn(Atlantis.LocalPlayer.Name .. ' is not using synapse x!')
end)

local Files = FileFunctions.listfiles('atlantis/executor/saves')
for _, FilePath in pairs(Files) do
	Atlantis:AddToScripts(FilePath)
end

local CoreGui = (Services.RunService:IsStudio()) and Atlantis.LocalPlayer:WaitForChild('PlayerGui', math.huge) or Services.CoreGui
if CoreGui then
	Atlantis.Gui.Parent = CoreGui
end
