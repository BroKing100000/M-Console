local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

-- [ Children ] --

local modules = ReplicatedStorage:WaitForChild("Modules")

-- [ Modules ] --

local console = require(modules:WaitForChild("Console"))

-- [ Return ] --

--[[
Prints bunch of logs which provide information about M-Console.
Sorry for it being a little messy.
]]
return function()
	
	-- [ Variables ] --
	
	local chatVersion = TextChatService.ChatVersion
	
	console.Log("M-Console v.1.3.0 by @BroKing100000")
	console.Log("")
	console.Log("-- UPDATE LOG (06/06/2025) --")
	console.Log("")
	console.Log("> Improved scaling system.")
	console.Log("> Improved dragging system.")
	console.Log("> Updated [Settings] module - More themes.")
	console.Log("> Commands are now held in [CommandsCallback] folder.")
	console.Log("> Added possibility to clone text containing HTTP link.")
	console.Log("> New possibility to view tables fully through the custom logs.")
	console.Log("> New performance frame: Possibility to view system monitoring.")
	console.Log("> Added possibility to select between commands using arrow keys.")
	console.Log("> Updated [Console] module - Now accept any args any any amounts.")
	console.Log("> New module: [Init], for inital setup of some processes outside Client script.")
	console.Log("")
	console.Log("-- PURPOSE --")
	console.Log("")
	console.Log("As well running commands through it.")
	console.Log("Used to display custom and actual logs.")
	console.Log("Actual logs are coming from built-in roblox output.")
	console.Log("Custom logs are coming from [Console] module.")
	console.Log("Commands are assigned by M-Console itself and developers making their own.")
	console.Log("")
	console.Log("-- COMMANDS --")
	console.Log("")
	console.Log("Inside M-Console there's built-in command bar.")
	console.Log("It is used to run custom commands.")
	console.Log("To begin, enter the [_] (Underscope) character in input field.")
	console.Log("Start entering the command you want to use.")
	console.Log("You can use the list to view possible commands.")
	console.Log("Use arrow keys to navigate through commands.")
	console.Log("Some commands require [args] - aditional arguments to run command.")
	console.Log("Right after entering command you need to input '-'")
	console.Warn("If command does not require [args] you don't need doing that.")
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
		
		console.Warn("This experience use deprecated version of chat.")
	end
	
	console.Log("")
	console.Log("-- DRAGGING & SCALING --")
	console.Log("")
	console.Log("To drag window hold title bar and move your mouse/finger.")
	console.Log("To scale window hold triangle at the bottom and move your mouse/finger.")
	console.Log("Resetting position and size are built-in commands.")
	console.Log("It's [_resetSize] and [_resetPosition].")
	console.Log("")
	console.Log("-- DEVELOPER PACKAGE --")
	console.Log("")
	console.Log("M-Console is open-source place.")
	console.Log("For STABLE instalation of M-Console open a copy of M-Console experience.")
	console.Log("https://www.roblox.com/games/16980596494")
	console.Log("By default installation M-Console located in ServerStorage.")
	console.Log("All installation settings providded in installation script.")
	console.Log("For UNSTABLE installation of M-Console you have to enter GitHub.")
	console.Log("https://www.github.com/BroKing100000/M-Console")
	console.Warn("Unstable version provides pre-release of upcoming update.")
	console.Log("Basically it's a prototype of next update of M-Console.")
	console.Log("I'd suggest using stable version if you plan to use M-Console with reason.")
	console.Log("")
	console.Log("-- FEEDBACK --")
	console.Log("")
	console.Log("For any other questions message @BroKing100000 on Roblox.")
end