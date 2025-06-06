-- [ Variables ] --

local log = {}

local customLogsColors = {
	
	{"ERROR", Color3.fromRGB(255, 0, 0)},
	{"WARNING", Color3.fromRGB(255, 255, 0)},
	{">", Color3.fromRGB(170, 170, 170)},
}

local actualLogsColors = {
	
	{Enum.MessageType.MessageError, Color3.fromRGB(255, 0, 0)},
	{Enum.MessageType.MessageWarning, Color3.fromRGB(255, 255, 0)},
	{Enum.MessageType.MessageInfo, Color3.fromRGB(85, 170, 255)},
	{Enum.MessageType.MessageOutput, Color3.fromRGB(255, 255, 255)},
}

-- [ Modules ] --

local settings = require(script.Parent.Parent.Settings)

-- [ Functions ] --

--[[
Makes the <strong>TextLabel</strong> being selectable.
]]
local SelectableLog = function(label: TextLabel)

	-- [ Variables ] --

	local text = label.Text
	
	-- [ Children ] --

	local box = Instance.new("TextBox")
	box.Text = text
	box.Name = "Box"
	box.TextScaled = true
	box.FontFace = label.FontFace
	box.TextStrokeTransparency = 0
	box.BackgroundTransparency = 1
	box.Size = UDim2.new(1, 0, 1, 0)
	box.TextColor3 = label.TextColor3
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.TextStrokeColor3 = label.TextStrokeColor3
	box.Parent = label

	local underline = Instance.new("Frame")
	underline.Name = "Underline"
	underline.BorderSizePixel = 0
	underline.Size = UDim2.new(1, 0, 0.05, 0)
	underline.AnchorPoint = Vector2.new(0, 1)
	underline.Position = UDim2.new(0, 0, 1, 0)
	underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	underline.Parent = label

	label.Text = ""

	-- [ Connections ] --

	box:GetPropertyChangedSignal("Text"):Connect(function()
		
		box.Text = text
	end)
end

--[[
Assigns a custom log into the list containt all custom logs.
]]
log.Custom = function(console: Frame, args: StringValue)
	
	-- [ Children ] --
	
	local clone = console.Frames.Custom.Template:Clone() :: TextLabel
	clone.Text = args.Value
    clone.Name = tostring(tonumber(#console.Frames.Custom:GetChildren()) - 2)
	clone.Visible = true

	-- [ Loop ] --
	
	for _, color in pairs(customLogsColors) do
		
		if args.Value:find(tostring(color[1])) then
			
			clone.TextColor3 = color[2]
		end
	end

	clone.Parent = console.Frames.Custom

	if clone.Text:find("http") or clone.Text:find("rbxassetid") or settings.MAKE_ANY_TEXT_SELECTABLE == true then
		
		-- [ Coroutines ] --

		coroutine.wrap(SelectableLog)(clone)
	end
end

--[[
Assigns an actual log into the list containt all actual logs.
]]
log.Actual = function(console: Frame, message: string, messageType: Enum.MessageType)
	
	-- [ Children ] --
	
	local clone = console.Frames.Actual.Template:Clone() :: TextLabel
	clone.Text = message
    clone.Name = tostring(tonumber(#console.Frames.Actual:GetChildren()) - 2)
	clone.Visible = true
	
	-- [ Loop ] --

	for _, color in pairs(actualLogsColors) do

		if messageType == color[1] then

			clone.TextColor3 = color[2]
		end
	end
	
	if clone.Text:find(">") then

		clone.TextColor3 = Color3.fromRGB(170, 170, 170)
	end
	
	clone.Parent = console.Frames.Actual

	if clone.Text:find("http") or clone.Text:find("rbxassetid") or settings.MAKE_ANY_TEXT_SELECTABLE == true then
		
		-- [ Coroutines ] --

		coroutine.wrap(SelectableLog)(clone)
	end
end

-- [ Return ] --

return log