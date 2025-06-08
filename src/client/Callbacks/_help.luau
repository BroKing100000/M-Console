local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

-- [ Children ] --

local modules = ReplicatedStorage:WaitForChild("Modules")

-- [ Modules ] --

local console = require(modules:WaitForChild("Console"))

-- [ Return ] --

--[[
Prints bunch of logs which provide information about M-Console.
]]
return function()
	
	-- [ Variables ] --
	
	local chatVersion = TextChatService.ChatVersion
	
	console.Log("M-Console v.1.3.0 by @BroKing100000")
	console.Log("")
	console.Log("-- UPDATE LOG (06/08/2025) --")
	console.Log("")
	console.Log("> Updated settings - More themes.")
	console.Log("> Commands are now held in [Callbacks] folder.")
	console.Log("> New frame: Possibility to view system monitoring.")
	console.Log("> Added possibility to clone text containing HTTP link.")
	console.Log("> Added possibility to select between commands using arrow keys.")
	console.Log("> Updated [Console] module - Now accept any args in any amounts.")
	console.Log("")
	console.Log("-- PURPOSE --")
	console.Log("")
	console.Log("Used to display custom and actual logs.")
	console.Log("Actual logs are coming from built-in roblox output.")
	console.Log("Custom logs are coming from [Console] module.")
	console.Log("As well running commands through it.")
	console.Log("And view some of system's performance.")
	console.Log("")
	console.Log("-- COMMANDS --")
	console.Log("")
	console.Log("Inside M-Console there's built-in command bar.")
	console.Log("It's used to run custom commands.")
	console.Log("To begin, enter the [_] (Underscope) character in input field.")
	console.Log("Start entering the command you want to use.")
	console.Log("You can use the list to view possible commands.")
	console.Log("Use arrow keys to navigate through commands.")
	console.Log("Press [Tab] key or click on command to autofill it.")
	console.Log("Some commands require aditional arguments to run it.")
	console.Log("If it does, then right after entering command you need to input [-] (Minus).")
	console.Warn("If command does not require arguments you don't need typing that.")
	console.Log("If you do not understand how it works then look at the examples instead.")
	console.Log("Common example you can see by typing [_log] command.")
	console.Log("")
	console.Log("-- TRIGGERING --")
	console.Log("")
	console.Log("To open M-Console as default being used [=] (Equals) key.")
	console.Log("You can type in chat '/mconsole' too.")
	console.Warn("It works only in new version of chat.")
	
	if chatVersion == Enum.ChatVersion.TextChatService then
		
		console.Log("This experience use new version of chat. So it's all good.")
		
	else
		
		console.Warn("This experience use deprecated version of chat. That command won't work.")
	end
	
	console.Log("")
	console.Log("-- DRAGGING & SCALING --")
	console.Log("")
	console.Log("To drag window hold title bar and move it with your mouse/finger.")
	console.Log("To scale window hold triangle at the bottom and move it with your mouse/finger.")
	console.Log("Resetting position and size are built-in commands.")
	console.Log("Those are: [_resetSize] and [_resetPosition].")
	console.Log("")
	console.Log("-- DEVELOPMENT PACKAGE --")
	console.Log("")
	console.Log("M-Console is an open-source place.")
	console.Log("You can download a copy of M-Console place on Roblox.")
	console.Log("As alternative you can use GitHub source.")
	console.Log("https://www.roblox.com/games/16980596494")
	console.Log("https://github.com/BroKing100000/M-Console")
	console.Warn("GitHub source is unstable!")
	console.Log("It's because my git is connected to that repository.")
	console.Log("I commit changes every day after developing any progress.")
	console.Log("You might see the pre-release of next update out there.")
	console.Log("But things might be glitchy and not how you expected them to be.")
	console.Log("I suggest to use Roblox source for stability.")
	console.Log("To install from Roblox place you have to open ServerStorage and read the instructions.")
	console.Log("Tutorial on how to add your own commands you can find in [Commands] module.")
	console.Log("")
	console.Log("-- FEEDBACK --")
	console.Log("")
	console.Log("For any other questions message @BroKing100000 on Roblox.")
end