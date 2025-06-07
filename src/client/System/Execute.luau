local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

-- [ Children ] --

local modules = ReplicatedStorage:WaitForChild("Modules")

-- [ Modules ] --

local console = require(modules:WaitForChild("Console"))

local commands = require(script.Parent.Parent.Commands)

-- [ Variables ] --

local index = 1
local temp = {}
local execute = {}
local editing = false
local selected: string = nil

-- [ Functions ] --

--[[
Clears a list of any logs, depending on requested frame.
]]
local ClearList = function(list: Frame)
	
	-- [ Loop ] --
	
	for _, instance in list:GetChildren() do
		
		if instance:IsA("TextButton") then
			
			if instance.Name ~= "Template" then
				
				instance:Destroy()
			end
		end
	end
end

local ColorOptions = function(options: Frame)
	
	-- [ Loop ] --

	for _, option: Instance in options.List:GetChildren() do

		if option:IsA("TextButton") then
				
			if temp[index] == option.Name then

				-- [ Children ] --

				local color = options.List.BackgroundColor3 :: Color3

				-- [ Variables ] --

				local r = color.R * 255 - 15
				local g = color.G * 255 - 15
				local b = color.B * 255 - 15

				selected = option.Name
				
				option.BackgroundColor3 = Color3.fromRGB(r, g, b)

			else

				option.BackgroundColor3 = options.List.BackgroundColor3
			end
		end
	end
end

--[[
Displays an information about requested command.
]]
local DisplayCommand = function(gui: ScreenGui, options: Frame, command: {}, text: string)

	if text:find(command.Title) then
						
		options.Command.Visible = true
		options.Command.Title.Text = command.Title
		options.Command.Args.Text = "Args: " .. command.Args
		options.Command.Description.Text = command.Description
		options.Command.Example.Text = "Example: " .. command.Example
						
		if command.Choices then
							
			options.Choices.Visible = true
							
			-- [ Calls ] --
							
			ClearList(options.Choices)
							
			-- [ Loop ] --
							
			for _, choice in ipairs(command.Choices) do

				-- [ Children ] --
								
				local clone = options.Choices.Template:Clone()
				clone.Name = choice
				clone.Text = choice
				clone.Visible = true
				clone.Parent = options.Choices
								
				-- [ Connections ] --
								
				clone.Activated:Connect(function()
									
					gui.Console.Command.Bar.Box.Text = command.Title .. "-" .. choice
				end)
			end
							
		else
							
			options.Choices.Visible = false
		end
	end
end

--[[
Creates a list of available commands with provided text.
]]
execute.CommandInput = function(gui: ScreenGui, text: string)
	
    -- [ Variables ] --

	temp = {}
	index = 1
	text = string.lower(text)

	local tempIndex = 0
	
	-- [ Children ] --
	
	local options = gui.Console.Options
	
	if text ~= "" then
		
		options.Visible = true
		options.Command.Visible = false
		options.Choices.Visible = false
		
		-- [ Calls ] --
		
		ClearList(options.List)
		
		--[[
		if text:find("	") then
			
			-- [ Variables ] --
			
			local split = string.split(text, '	') -- Tab key.
			local combined = ''
			
			-- [ Loop ] --
			
			for i = 1, #split do

                -- [ Variables ] --
				
				combined = combined .. split[i]
			end

			gui.Console.Command.Bar.Box.Text = combined
		end
		]]

		-- [ Loop ] --
		
		for _, command in pairs(commands) do
			
			if command.Title:find(text) or text:find(command.Title) then

				table.insert(temp, command.Title)

				-- [ Children ] --
					
				local clone = options.List.Template:Clone() :: TextButton
				clone.Visible = true
				clone.Name = command.Title
				clone.Text = command.Title
				clone.Parent = options.List

				if #options.List:GetChildren() == 4 then
					
					-- [ Variables ] --

					selected = command.Title
				end

				-- [ Connections ] --
				
				clone.Activated:Connect(function()
								
					gui.Console.Command.Bar.Box.Text = command.Title
				end)

				-- [ Calls ] --

				DisplayCommand(gui, options, command, text)
			end
		end

		table.sort(temp)

	else
		
		options.Visible = false
	end
end

--[[
Fires a command when input ended or run button clicked.
If command does exist eventually.
]]
execute.InputEnded = function(gui: ScreenGui, text: string)
	
	if text == "" then return end
	
	console.Log(">" .. text)
	
	-- [ Variables ] --
	
	local split = string.split(text, '-')
	
	if commands[split[1]] then

		if not script.Parent.Parent.Callbacks:FindFirstChild(split[1]) then

			console.Error(string.format("Command module [%s] not found.", split[1]))

            -- [ Return ] --

			return
		end
		
		-- [ Modules ] --

		local Execute = require(script.Parent.Parent.Callbacks[split[1]])
		
		-- [ Calls ] --
		
		Execute(text)
		
		gui.Console.Command.Bar.Box.Text = ""

	else

		console.Error(string.format("Command [%s] is invalid or does not exist.", text))
	end
end

-- [ Connections ] --

UserInputService.InputBegan:Connect(function(input)

	-- [ Children ] --

	local options = script.Parent.Parent.Console.Options

	if input.KeyCode == Enum.KeyCode.Up and editing == true and #temp >= 1 then

		-- [ Variables ] --
		
		index = math.clamp(index - 1, 1, #temp) or 1

		-- [ Calls ] --

		DisplayCommand(script.Parent.Parent, options, commands[temp[index]], temp[index])
		ColorOptions(options)

	elseif input.KeyCode == Enum.KeyCode.Down and editing == true and #temp >= 1 then

		-- [ Variables ] --
		
		index = math.clamp(index + 1, 1, #temp) or 1

		-- [ Calls ] --

		DisplayCommand(script.Parent.Parent, options, commands[temp[index]], temp[index])
		ColorOptions(options)

	elseif input.KeyCode == Enum.KeyCode.Tab and editing == true then

		task.wait()

		if selected then
			
			script.Parent.Parent.Console.Command.Bar.Box.Text = selected
		end
	end
end)

script.Parent.Parent.Console.Command.Bar.Box.Focused:Connect(function()
	
	-- [ Variables ] --

	editing = true
end)

script.Parent.Parent.Console.Command.Bar.Box.FocusLost:Connect(function()
	
	-- [ Variables ] --
	
	editing = false
end)

-- [ Return ] --

return execute