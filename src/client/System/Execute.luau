local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [ Children ] --

local modules = ReplicatedStorage:WaitForChild("Modules")

-- [ Modules ] --

local console = require(modules:WaitForChild("Console"))

local commands = require(script.Parent.Parent.Commands)

-- [ Variables ] --

local main = {}

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

--[[
Creates a list of available commands with provided text.
]]
main.CommandInput = function(gui: ScreenGui, text: string)
	
    -- [ Variables ] --

	text = string.lower(text)
	
	-- [ Children ] --
	
	local options = gui.Console.Options
	
	if text ~= "" then
		
		options.Visible = true
		options.Command.Visible = false
		options.Choices.Visible = false
		
		-- [ Calls ] --
		
		ClearList(options.List)
		
		if text:find("	") then
			
			-- [ Variables ] --
			
			local split = string.split(text, '	') -- Tab key.
			local combined = ''
			
			-- [ Loop ] --
			
			for i = 1, #split do

                -- [ Variables ] --
				
				combined = combined .. split[i]
			end
			
			-- [ Loop ] --
			
			for _, command in pairs(commands) do
				
				if command.Title:find(combined) then

                    -- [ Variables ] --
					
					combined = command.Title
					
					if command.Args ~= "N/A" then

                        -- [ Variables ] --
						
						combined = combined .. "-"
					end
				end
			end
			
			gui.Console.Command.Bar.Box.Text = combined
		end
		
		-- [ Loop ] --
		
		for _, command in pairs(commands) do
			
			if command.Title:find(text) or text:find(command.Title) then

                -- [ Children ] --
				
				local clone = options.List.Template:Clone()
				clone.Name = command.Title
				clone.Text = command.Title
				clone.Visible = true
				clone.Parent = options.List
				
				-- [ Connections ] --
				
				clone.Activated:Connect(function()
					
					gui.Console.Command.Bar.Box.Text = command.Title
				end)
				
				if text:find(command.Title) then
					
					options.Command.Visible = true
					
					options.Command.Title.Text = command.Title
					options.Command.Description.Text = command.Description
					options.Command.Args.Text = "Args: " .. command.Args
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
		end
		
	else
		
		options.Visible = false
	end
end

--[[
Fires a command when input ended or run button clicked.
If command does exist eventually.
]]
main.InputEnded = function(gui: ScreenGui, text: string)
	
	if text == "" then return end
	
	console.log(">" .. text)
	
	-- [ Variables ] --
	
	local split = string.split(text, '-')
	
	if commands[split[1]] then

		if not script.Parent.Parent.Callbacks:FindFirstChild(split[1]) then

			console.error(string.format("Command module [%s] not found.", split[1]))

            -- [ Return ] --

			return
		end
		
		-- [ Modules ] --

		local Execute = require(script.Parent.Parent.Callbacks[split[1]])
		
		-- [ Calls ] --
		
		Execute(text)
		
		gui.Console.Command.Bar.Box.Text = ""

	else

		console.error(string.format("Command [%s] is invalid or does not exist.", text))
	end
end

-- [ Return ] --

return main