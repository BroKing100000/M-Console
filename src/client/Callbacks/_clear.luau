-- [ Children ] --

local custom = script.Parent.Parent.Console.Frames.Custom

-- [ Return ] --

--[[
Clears any custom logs from frame.
]]
return function()
	
	task.wait()
	
	-- [ Loop ] --
	
	for _, instance in custom:GetChildren() do
		
		if instance:IsA("TextLabel") then
			
			if instance.Name ~= "Template" then
				
				instance:Destroy()
			end
		end
	end
end