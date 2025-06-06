local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- [ Children ] --

local modules = ReplicatedStorage:WaitForChild("Modules")

-- [ Modules ] --

local console = require(modules:WaitForChild("Console"))

-- [ Return ] --

--[[
Creates a log into custom output.
]]
return function(text: string)

	-- [ Variables ] --

	local split = string.split(text, '-')

	if split[2] then

		-- [ Variables ] --

		local combined = ''

		-- [ Loop ] --

		for i = 2, #split do

			-- [ Variables ] --

			combined = combined .. split[i]
			
			if split[i + 1] then
				
				-- [ Variables ] --

				combined = combined .. "-"
			end
		end

		console.Log(combined)

	else

		console.Error("Argument missing: string.")
	end
end