local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")

-- [ Return ] --

--[[
Inital setup for:
Window and frames managing.
Custom command.
Settings.
Fonts.
]]
return function(gui: ScreenGui, settings: ModuleScript, monitoring: ModuleScript)
   
    print("🔧 This experience use [M-Console v.1.3.0] by @BroKing100000 🔧") -- Keep the credits. Please.

     -- [ Children ] --

    local command = Instance.new("TextChatCommand")
    command.Name = "mconsole"
    command.PrimaryAlias = "/mconsole"
    command.Parent = TextChatService

    settings.Apply(gui.Console)

    -- [ Coroutines ] --

    coroutine.wrap(monitoring.RamUsage)(gui.Console.Frames.Monitoring.Memory, settings.RAM_LIMIT)

    -- [ Loop ] --

    --[[
    Generates all possible fonts from Enum into list.
    Chnages the font in M-Console window when specific font button is clicked.
    ]]
    for _, font in Enum.Font:GetEnumItems() do

        -- [ Children ] --
        
        local clone = gui.Console.Frames.Settings.Font.Fonts.Template:Clone()
        clone.Font = font
        clone.Visible = true
        clone.Text = font.Name
        clone.Name = font.Name
        clone.Parent = gui.Console.Frames.Settings.Font.Fonts

        -- [ Connections ] --
        
        clone.Activated:Connect(function()
            
            settings.FONT.Family = "rbxasset://fonts/families/" .. font.Name .. ".json"
            settings.Apply(gui.Console)
        end)
    end

    -- [ Invokes ] --

    --[[
    Prevents the custom command message from being displayed into chat.
    ]]
    TextChatService.OnIncomingMessage = function(message)
        
        if message.Text == "/mconsole" then

            -- [ Children ] --
            
            local properties = Instance.new("TextChatMessageProperties")
            properties.Text = " "

            -- [ Return ] --

            return properties
        end
    end

    -- [ Connections ] --

    --[[
    Fires when Player triggered the [mconsole] command in chat.
    It either opens or closes the M-Console.
    ]]
    command.Triggered:Connect(function()

        if gui.Console.Visible == false then

            gui.Console.Position = UDim2.new(0.25, 0, 0.25, 0)
            gui.Console.Visible = true

        else

            gui.Console.Visible = false
        end
    end)

    --[[
    Fires when Player presses a TRIGGER_KEY.
    It either open or close the M-Console.
    ]]
    UserInputService.InputBegan:Connect(function(input, processed)

        if processed then
            
            -- [ Return ] --

            return
        end

        if input.KeyCode == settings.TRIGGER_KEY then

            if gui.Console.Visible == false then

                gui.Console.Visible = true

            else

                gui.Console.Visible = false
            end
        end
    end)

    --[[
    Closes M-Console when close button is clicked.
    ]]
    gui.Console.Title.Close.Activated:Connect(function()
        
        gui.Console.Visible = false
    end)

     --[[
    Changes the key used to open M-Console.
    ]]
    gui.Console.Frames.Settings.Trigger.Button.Activated:Connect(function()
        
        gui.Console.Frames.Settings.Trigger.Button.Text = "Press key."
        
        UserInputService.InputBegan:Once(function(input)
            
            task.wait()
            
            settings.TRIGGER_KEY = input.KeyCode
            
            gui.Console.Frames.Settings.Trigger.Button.Text = tostring(input.KeyCode)
        end)
    end)

    --[[
    Changes the font of M-Console.
    ]]
    gui.Console.Frames.Settings.Font.Button.Activated:Connect(function()

        if gui.Console.Frames.Settings.Font.Fonts.Visible == false then
            
            gui.Console.Frames.Settings.Font.Fonts.Visible = true
            
        else
            
            gui.Console.Frames.Settings.Font.Fonts.Visible = false
        end
    end)

    -- [ Loop ] --

    --[[
    Opens/closes specific frames when buttons are clicked.
    ]]
    for _, button in gui.Console.Buttons:GetChildren() do

        if button:IsA("TextButton") then
            
            -- [ Connections ] --
            
            button.Activated:Connect(function()
                
                -- [ Loop ] --

                for _, frame in gui.Console.Frames:GetChildren() do

                    if frame:IsA("Frame") or frame:IsA("ScrollingFrame") then

                        if frame.Name == button.Name then

                            frame.Visible = true

                        else

                            frame.Visible = false
                        end
                    end
                end
            end)
        end
    end

    --[[
    Changes theme of M-Console window when theme buttons are clicked.
    ]]
    for _, button in gui.Console.Frames.Settings.Theme:GetChildren() do
        
        if button:IsA("TextButton") then

            -- [ Connections ] --
            
            button.Activated:Connect(function()
                
                settings.THEME = button.Name
                settings.Apply(gui.Console)
            end)
        end
    end
end