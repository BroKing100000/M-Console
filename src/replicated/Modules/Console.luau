local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [ Children ] --

local logs = ReplicatedStorage.Logs

-- [ Variables ] --

local console = {}

local deprecated = {

	{
		"log",

		function(args: string?)

            -- [ Children ] --

			local value = Instance.new("StringValue")
			value.Name = tostring(#logs:GetChildren() + 1)
			value.Value = tostring(args)
			value.Parent = logs
		end,
	},

	{
		"error",

		function(args: string?)

             -- [ Children ] --

			local value = Instance.new("StringValue")
			value.Name = tostring(#logs:GetChildren() + 1)
			value.Value = "ERROR: " .. tostring(args)
			value.Parent = logs
		end,
	},

	{
		"warn",

		function(args: string?)

             -- [ Children ] --

			local value = Instance.new("StringValue")
			value.Name = tostring(#logs:GetChildren() + 1)
			value.Value = "WARNING: " .. tostring(args)
			value.Parent = logs
		end,
	},
}

-- [ Functions ] --

--[[
Returns a <strong>String</strong> which contain the provided directory and start.
]]
local Value = function(directory: {}, start: string?)

	-- [ Variables ] --

	local combined = start or ""

	-- [ Loop ] --

	for _, value in pairs(directory) do
		
		-- [ Variables ] --

		combined = combined .. value
	end
	
	-- [ Return ] --

	return combined
end

--[[
Creates a new log.
]]
local Create = function(directory: {}, start: string?)

    -- [ Children ] --
	
	local value = Instance.new("StringValue")
	value.Name = tostring(#logs:GetChildren() + 1)
	value.Value = Value(directory, start)
	value.Parent = logs
end

--[[
Adds a <strong>Log</strong> into logs with provided text.
]]
console.Log = function(...)

	-- [ Variables ] --
	
	local directory = {...}

    -- [ Calls ] --
	
	Create(directory)
end

--[[
Adds an <strong>Error</strong> into logs with provided text.
]]
console.Error = function(...)

	-- [ Variables ] --
	
	local directory = {...}
	
    -- [ Calls ] --

	Create(directory, "ERROR: ")
end

--[[
Adds a <strong>Warn</strong> into logs with provided text.
]]
console.Warn = function(...)

	-- [ Variables ] --
	
	local directory = {...}
	
    -- [ Calls ] --

	Create(directory, "WARNING: ")
end

-- [ Loop ] --

--[[
Inserting all deprecated functions.
This is done to prevent them from displaying.
]]
for _, element in pairs(deprecated) do
	
	console[element[1]] = element[2]
end

-- [ Return ] --

return console