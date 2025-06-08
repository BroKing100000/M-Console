local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local LogService = game:GetService("LogService")
local Players = game:GetService("Players")

-- [ Children ] --

local gui = script.Parent

local modules = ReplicatedStorage:WaitForChild("Modules")

-- [ Modules ] --

local Setup = require(script.Parent.System.Setup)

local log = require(script.Parent.System.Log)
local settings = require(script.Parent.Settings)
local execute = require(script.Parent.System.Execute)
local monitoring = require(script.Parent.System.Monitoring)

-- [ Mouse ] --

local mouse = Players.LocalPlayer:GetMouse()

-- [ Variables ] --

local held = false

-- [ Calls ] --

Setup(gui, settings, monitoring)

-- [ Connections ] --

--[[
Changes the [held] variable into true if mouse or touch inputed.
]]
UserInputService.InputBegan:Connect(function(input)
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

        -- [ Variables ] --

		held = true
	end
end)

--[[
Changes the [held] variable into false if mouse or touch ended input.
]]
UserInputService.InputEnded:Connect(function(input)
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then

        -- [ Variables ] --

		held = false
	end
end)

--[[
Crates a custom log in M-Console when a custom log is added.
]]
ReplicatedStorage.Logs.ChildAdded:Connect(function(args)
	
	if args:IsA("StringValue") then

		log.Custom(gui.Console, args)
		monitoring.CustomLog(gui.Console, args)
	end
end)

--[[
Crates an actual log in M-Console when an actual log is added.
]]
LogService.MessageOut:Connect(function(message, messageType)
	
	log.Actual(gui.Console, message, messageType)
	monitoring.ActualLog(gui.Console, messageType)
end)

--[[
Moves a M-Console window when title is held.
]]
gui.Console.Title.MouseMoved:Connect(function()
	
	if held == true then
		
		-- [ Loop ] --
		
		repeat

            -- [ Variables ] --

			local xPos = mouse.X / mouse.ViewSizeX
			local yPos = mouse.Y / mouse.ViewSizeY

			gui.Console.Position = UDim2.new(xPos, 0, yPos, 0)

			task.wait()

		until held == false
	end
end)

--[[
Changes size of M-Console when drag indicator held.
]]
gui.Console.Drag.MouseMoved:Connect(function()
	
	if held == true then
		
		-- [ Loop ] --

		repeat

            -- [ Variables ] --

			local xSize = mouse.X / mouse.ViewSizeX
			local ySize = mouse.Y / mouse.ViewSizeY

			gui.Console.Size = UDim2.new(xSize, 0, ySize, 0)

			task.wait()

		until held == false
	end
end)

--[[
Gives a command options when the text is being inputed into a bar.
]]
gui.Console.Command.Bar.Box:GetPropertyChangedSignal("Text"):Connect(function()
	
	execute.CommandInput(gui, gui.Console.Command.Bar.Box.Text)
end)

--[[
Fires a command when input is ended.
]]
gui.Console.Command.Bar.Box.InputEnded:Connect(function(input)
	
	if input.KeyCode == settings.INPUT_KEY then
		
		execute.InputEnded(gui, gui.Console.Command.Bar.Box.Text)
	end
end)

--[[
Fires a command when run button is activated.
]]
gui.Console.Command.Run.Activated:Connect(function()
	
	execute.InputEnded(gui, gui.Console.Command.Bar.Box.Text)
end)