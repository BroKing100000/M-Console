-- [ Types ] --

type settings = {

    TRIGGER_KEY: Enum.KeyCode,
    INPUT_KEY: Enum.KeyCode,
    THEME: string,
    FONT: Font,
    Apply: () -> ()
}

-- [ Variables ] --

local settings = {
	
	TRIGGER_KEY = Enum.KeyCode.Equals, -- Open/Close M-Console when this key is pressed.
	INPUT_KEY = Enum.KeyCode.Return, -- Run a command when this key is pressed.
	THEME = "Default", -- Theme of M-Console.
	FONT = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), -- Font of any text in M-Console.
	MAKE_ANY_TEXT_SELECTABLE = false, -- Makes any text in both consoles being selectable. Or disables that.

	-- Do not edit anything below if you don't know what you're doing.

	--[[
	Applies all settings of M-Console.
	]]
	Apply = function(console: Frame)
		
		-- [ Loop ] --
		
		for _, instance in console:GetDescendants() do
			
			self.Theme(instance)
			
			if instance:IsA("TextLabel") or instance:IsA("TextButton") or instance:IsA("TextBox") then
				
				if instance.Parent.Name ~= "Fonts" then
					
					instance.FontFace = self.FONT
				end
			end
		end
		
		self.Theme(console)
		
		console.Frames.Settings.Trigger.Button.Text = tostring(self.TRIGGER_KEY)
		console.Frames.Settings.Font.Button.Text = self.FormatFont(self.FONT.Family)
	end,
}

local themes = {

	Default = {

		Base = Color3.fromRGB(50, 50, 50),
		Bar = Color3.fromRGB(19, 133, 255),
	},
	
	Strawberry = {

		Base = Color3.fromRGB(59, 29, 29),
		Bar = Color3.fromRGB(255, 73, 73),
	},
	
	["Solid Black"] = {
		
		Base = Color3.fromRGB(0, 0, 0),
		Bar = Color3.fromRGB(175, 175, 175),
	},
	
	["Purple Nebula"] = {

		Base = Color3.fromRGB(16, 0, 50),
		Bar = Color3.fromRGB(170, 0, 255),
	},
	
	Kimbie = {
		
		Base = Color3.fromRGB(34, 26, 15),
		Bar = Color3.fromRGB(255, 251, 124),
	},
	
	Forest = {
		
		Base = Color3.fromRGB(35, 50, 42),
		Bar = Color3.fromRGB(0, 255, 81),
	},
}

-- [ Self ] --

self = setmetatable(settings, {})

-- [ Functions ] --

--[[
Changes the color of UI elements depending on <strong>Theme</strong>.
]]
self.Theme = function(instance: Instance)

    -- [ Variables ] --
	
	local color: Color3? = themes[self.THEME][instance:GetAttribute("ThemeParameter")]
	
	if color then
		
		instance.BackgroundColor3 = color
	end
end

--[[
Formats font text.
Converts from asset id and .json into a font name and returns <strong>String</strong>.
]]
self.FormatFont = function(family: string)

    -- [ Variables ] --
	
	local split = string.split(family, '/')
	local formatted = string.split(split[5], ".json")

    -- [ Return ] --
	
	return formatted[1]
end

-- [ Return ] --

return settings