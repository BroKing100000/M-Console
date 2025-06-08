local Stats = game:GetService("Stats")

-- [ Variables ] --

local rate = 1
local monitoring = {}
local customInfos = 0
local actualInfos = 0
local customErrors = 0
local actualErrors = 0
local customWarnings = 0
local actualWarnings = 0

-- [ Functions ] --

local MemoryGraph = function(frame: Frame, usage: number)
   
    if #frame:GetChildren() == 23 then
        
        -- [ Loop ] --

        for i = 0, 18 do
            
            frame[tostring(i)].Size = frame[tostring(i + 1)].Size
        end

        frame["19"].Size = UDim2.new(0.05, 0, math.clamp(usage, 0, 1), 0)

    else

        -- [ Children ] --

        local clone = frame.Template:Clone() :: Frame
        clone.Visible = true
        clone.Name = #frame:GetChildren() - 3
        clone.Size = UDim2.new(0.05, 0, math.clamp(usage, 0, 1), 0)
        clone.Parent = frame
    end
end

--[[]
Converts a <strong>number</strong> into a <string>string</strong> with comma.
It's based on how huge <strong>number</strong> was.
]]
local Comma = function(value: number)
    
    -- [ Variables ] --
	
	local formatted = value
	local k
	
	-- [ Loop ] --

	while true do  

        -- [ Variables ] --

		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')

		if k == 0 then break end
	end
	
	-- [ Return ] --

	return formatted
end

--[[
Updates all the amount of custom logs based on amount.
]]
local UpdateCustomLogs = function(frame: Frame)
    
    -- [ Children ] --

    local custom = frame.Frames.Monitoring.Reports.Custom

    custom.Infos.Label.Text = string.format("%s Infos", Comma(customInfos))
    custom.Errors.Label.Text = string.format("%s Errors", Comma(customErrors))
    custom.Warnings.Label.Text = string.format("%s Warnings", Comma(customWarnings))
end

--[[
Updates all the amount of actual logs based on amount.
]]
local UpdateActualLogs = function(frame: Frame)
    
    -- [ Children ] --

    local actual = frame.Frames.Monitoring.Reports.Actual

    actual.Infos.Label.Text = string.format("%s Infos", Comma(actualInfos))
    actual.Errors.Label.Text = string.format("%s Errors", Comma(actualErrors))
    actual.Warnings.Label.Text = string.format("%s Warnings", Comma(actualWarnings))
end

--[[
Checks the custom log and changes the amount based on it.
]]
monitoring.CustomLog = function(frame: Frame, log: StringValue)
    
    if log.Value:find("WARNING") then
        
        customWarnings += 1

    elseif log.Value:find("ERROR") then

        customErrors += 1

    else

        customInfos += 1
    end

    -- [ Calls ] --

    UpdateCustomLogs(frame)
end

--[[
Checks the actual log and changes the amount based on it.
]]
monitoring.ActualLog = function(frame: Frame, type: Enum.MessageType)
    
    if type == Enum.MessageType.MessageWarning then
        
        actualWarnings += 1

    elseif type == Enum.MessageType.MessageError then

        actualErrors += 1

    else

        actualInfos += 1
    end

    -- [ Calls ] --

    UpdateActualLogs(frame)
end

--[[
Runs a RAM usage protocol, viewing how much bytes are taken up and free.
Creates a graph of that usage.
Changes the percentage based on usage and limit.
All of it runs in a loop every tick.
All memory values are sized in gigabytes.
]]
monitoring.RamUsage = function(frame: Frame, limit: number)
    
    -- [ Loop ] --

    while true do
        
        -- [ Variables ] --

        local usage = Stats:GetTotalMemoryUsageMb() / 1024
        local ratio = usage / limit

        frame.Usage.Text = string.format("%s GB", string.format("%.3f", usage))
        frame.Percentage.Value.Size = UDim2.new(math.clamp(ratio, 0, 1), 0, 1, 0)
        frame.Percentage.Percent.Position = UDim2.new(math.clamp(ratio, 0, 1), 0, 0, 0)
        frame.Available.Text = string.format("%s GB Available", string.format("%.3f", limit - usage))
        frame.Percentage.Percent.Label.Text = string.format("%s", string.format("%.2f", math.clamp(ratio, 0, 1) * 100)) .. "%"

        -- [ Calls ] --

        MemoryGraph(frame.Graph, usage / limit)

        task.wait(rate)
    end
end

-- [ Return ] --

return monitoring