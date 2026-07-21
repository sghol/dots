vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

-- TODO: this is a todo
vim.g.colors_name = "darkland"

local black = "#000000"
local alt_black = "#252525"
local white = "#f5f5f5"
local dim_gray = "#696969"
local light_green = "#98FB98"
local yellow = "#FFFF00"
local red = "#FF4500"
local hint = "#00FFFF"

local theme = {
	-- black Indicators

	CursorLine = { bg = alt_black },
	CursorColumn = { link = "CursorLine" },
	ColorColumn = { link = "CursorLine" },

	StatusLine = { bg = dim_gray },
	Directory = { fg = hint },

	-- mini statusliine
	MiniStatuslineModeNormal = { fg = black, bg = white },
	MiniStatuslineModeInsert = { fg = black, bg = light_green },
	MiniStatuslineModeVisual = { fg = black, bg = yellow },
	MiniStatuslineModeCommand = { fg = white, bg = red },

	-- todo
	Todo = { bg = red },

	-- Normal aka white
	Normal = { fg = white },
	NormalNC = { link = "Normal" },
	MsgArea = { link = "Normal" },
	MsgSeparator = { link = "Normal" },
	ModeMsg = { link = "Normal" },
	NormalFloat = { link = "Normal" },

	-- Text
	Identifier = { link = "Normal" },
	Constant = { link = "Normal" },
	Function = { link = "Normal" },
	Conceal = { link = "Normal" },
	Operator = { link = "Normal" },
	NonText = { link = "Normal" },
	MoreMsg = { link = "Normal" },
	Title = { link = "Normal" },
	Question = { link = "Normal" },
	Variable = { link = "Normal" },
	Typedef = { link = "Normal" },
	Label = { link = "Normal" },
	Macro = { link = "Normal" },
	Delimiter = { link = "Normal" },
	PreProc = { link = "Normal" },

	-- Statement
	Keyword = { fg = white, bold = true },
	Statement = { link = "Keyword" },
	Type = { link = "Keyword" },
	Structure = { link = "Keyword" },
	StorageClass = { link = "Keyword" },
	Conditional = { link = "Keyword" },
	Repeat = { link = "Keyword" },
	Include = { link = "Keyword" },
	Tag = { link = "Keyword" },
	SpecialKey = { link = "Keyword" },
	Exception = { link = "Keyword" },

	-- Number
	Number = { link = "Normal" },
	Define = { link = "Normal" },
	Boolean = { link = "Normal" },
	Float = { link = "Normal" },
	Debug = { link = "Normal" },

	-- comment
	Comment = { fg = light_green },
	SpecialComment = { link = "Comment" },

	-- Comma
	Special = { fg = white },
	LineNr = { link = "Normal" },
	Whitespace = { link = "Normal" },
	EndOfBuffer = { link = "Normal" },
	PreCondit = { link = "Normal" },

	-- String
	String = { fg = white },
	Character = { link = "String" },
	SpecialChar = { link = "String" },

	-- red
	CursorLineNr = { fg = red, bold = true },
	SpellCap = { sp = red, undercurl = true },
	MatchParen = { fg = red },

	-- Search
	Search = { fg = black, bg = yellow },
	IncSearch = { link = "Search" },
	Substitute = { link = "Search" },

	-- Error
	Error = { fg = red },
	ErrorMsg = { link = "Error" },
	WarningMsg = { link = "Error" },
	SpellBad = { sp = red, undercurl = true },

	-- Visual
	Visual = { bg = dim_gray },
	Pmenu = { fg = white, bg = alt_black },
	PmenuSel = { fg = black, bg = white },
	YankHighlight = { bg = yellow, fg = black },

	-- Python
	pythonOperator = { link = "Normal" },
	pythonExceptions = { link = "Normal" },
	pythonFunction = { link = "Normal" },
	pythonBuiltin = { link = "Normal" },

	-- Lua
	luaTable = { link = "Normal" },

	-- LSP
	DiagnosticWarn = { fg = yellow },
	DiagnosticHint = { fg = hint },
	FloatBorder = { fg = white },
	DiagnosticUnnecessary = { fg = white },
	-- error
	DiagnosticFloatingError = { fg = red },
	DiagnosticUnderlineError = { sp = red },
	DiagnosticSignError = { link = "Error" },
	DiagnosticVirtualTextError = { link = "Error" },

	-- Treesitter
	["@variable"] = { link = "Normal" },
	["@variable.memeber"] = { link = "Normal" },
	["@property"] = { link = "Normal" },
	["@function.builtin"] = { link = "Normal" },
	["@punctuation.bracket"] = { link = "Special" },
	["@punctuation.delimiter"] = { link = "Special" },
}

for group, hl in pairs(theme) do
	vim.api.nvim_set_hl(0, group, hl)
end
