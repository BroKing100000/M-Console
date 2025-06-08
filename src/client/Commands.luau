-- [ Return ] --

return {
	
	--[[
	
	Assign your own commands here, clone the following template:
	
	_commandName = {
		
		Title = "_commandName",
		Args = "N/A | string | number | any",
		Description = "Describe what command does.",
		Example = "_commandName-Action (Give an example how to enter this command).",
		
		--Optional feature.
		Choices = {
		
			"Choice1",
			"Choice2",
			"Choice3",
		},
	},
	
	Do not forget to create a module which returns a function.
	Name that module exactly same as title of this command.
	Module should be parented to Callbacks folder.
	
	]]
	
	_clear = {
		
		Title = "_clear",
		Args = "N/A",
		Description = "Clears any logs from custom output.",
		Example = "_clear",
	},
	
	_log = {

		Title = "_log",
		Args = "string",
		Description = "Adds a log into custom output.",
		Example = "_log-Hello, World!",
	},
	
	_error = {

		Title = "_error",
		Args = "string",
		Description = "Adds an error into custom output.",
		Example = "_error-Hello, World!",
	},
	
	_warn = {

		Title = "_warn",
		Args = "string",
		Description = "Adds a warning into custom output.",
		Example = "_warn-Hello, World!",
	},
	
	_resetPosition = {

		Title = "_resetPosition",
		Args = "N/A",
		Description = "Resets position of M-Console window.",
		Example = "_resetPosition",
	},
	
	_resetSize = {

		Title = "_resetSize",
		Args = "N/A",
		Description = "Resets size of M-Console window.",
		Example = "_resetSize",
	},
	
	_help = {

		Title = "_help",
		Args = "N/A",
		Description = "Provides more information about M-Console, such as update log, and how to use it.",
		Example = "_help",
	},
}