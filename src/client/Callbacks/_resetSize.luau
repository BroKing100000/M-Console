-- [ Children ] --

local console = script.Parent.Parent.Console

-- [ Return ] --

--[[
Resets size of M-Console window.
]]
return function()
	
	console.Size = UDim2.new(0.5, 0, 0.5, 0)
end