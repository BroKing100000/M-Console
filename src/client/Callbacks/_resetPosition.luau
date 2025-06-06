-- [ Children ] --

local console = script.Parent.Parent.Console

-- [ Return ] --

--[[
Resets position of M-Console window.
]]
return function()
	
	console.Position = UDim2.new(0.25, 0, 0.25, 0)
end