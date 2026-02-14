vim.cmd.highlight("clear")
vim.g.colors_name = "darkshade"

if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

-- hi
local function hi(group, hl)
	vim.api.nvim_set_hl(0, group, hl)
end

-- Color palette
local fg = "#E1E1E1"
local bg = "#000000"
local alt_bg = "#151515"
local green = "#B4F6C0"
local red = "#984936"
local gray = "#9B9EA4"

-- Groups
hi("Defualt", { fg = fg })
hi("Mute", { fg = gray })
hi("Vibrant", { fg = green })
hi("Critical", { fg = red })
hi("Select", { bg = fg, fg = bg })

-- Normal
hi("Normal", { fg = fg, bg = bg })

-- Keyword
hi("Keyword", { fg = fg, bold = true })
hi("Statement", { link = "Keyword" })
hi("PreProc", { link = "Keyword" })
hi("Include", { link = "Keyword" })
hi("Conditional", { link = "Keyword" })
hi("Repeat", { link = "Keyword" })
hi("Label", { link = "Keyword" })
hi("Operator", { link = "Keyword" })
hi("Exception", { link = "Keyword" })

-- Search
hi("Search", { bg = green, fg = bg })
hi("CurSearch", { link = "Search" })
hi("YankHighlight", { link = "Search" })

-- Mute
hi("Comment", { link = "Mute" })
hi("NonText", { link = "Mute" })
hi("LineNr", { link = "Mute" })
hi("WinSeparator", { link = "Mute" })
hi("Question", { link = "Mute" })
hi("NonText", { link = "Mute" })

hi("Delimiter", { link = "Defualt" })

-- Vibrant
hi("String", { link = "Vibrant" })

-- Menu
hi("Pmenu", { bg = alt_bg })
hi("PmenuSel", { link = "Select" })
hi("PmenuThumb", { bg = bg })

hi("StatusLineNC", { fg = gray, bg = alt_bg })
hi("StatusLine", { fg = fg, bg = alt_bg })
hi("Visual", { link = "Select" })

-- UI
hi("Directory", { fg = fg, bold = true })

hi("CursorColumn", { bg = alt_bg })
hi("CursorLine", { bg = alt_bg })
hi("NormalFloat", { bg = alt_bg })
hi("QuickFixLine", { bg = alt_bg })

hi("FloatShadow", { bg = bg })
hi("FloatShadowThrough", { bg = bg })
hi("MatchParen", { fg = red, bold = true })

hi("Folded", { link = "Defualt" })
hi("ModeMsg", { link = "Defualt" })
hi("MoreMsg", { link = "Defualt" })

hi("RedrawDebugClear", { bg = bg })
hi("RedrawDebugComposed", { bg = bg })
hi("RedrawDebugRecompose", { bg = bg })

-- Diff
hi("DiffAdd", { link = "Vibrant" })
hi("DiffChange", { link = "Vibrant" })
hi("DiffDelete", { link = "Critical" })
hi("DiffText", { link = "Defualt" })

-- Critical
hi("Error", { link = "Critical" })
hi("ErrorMsg", { link = "Critical" })
hi("Todo", { link = "Critical" })
hi("MatchParen", { link = "Critical" })

-- Spell
hi("SpellBad", { sp = fg })
hi("SpellCap", { sp = fg })
hi("SpellLocal", { sp = fg })
hi("SpellRare", { sp = fg })

-- Diagnostic
hi("DiagnosticDeprecated", { sp = fg })
hi("DiagnosticUnderlineError", { sp = fg })
hi("DiagnosticUnderlineHint", { sp = fg })
hi("DiagnosticUnderlineInfo", { sp = fg })
hi("DiagnosticUnderlineOk", { sp = fg })
hi("DiagnosticUnderlineWarn", { sp = fg })

-- Defualt
hi("Added", { link = "Defualt" })
hi("Changed", { link = "Defualt" })
hi("Conceal", { link = "Defualt" })
hi("Constant", { link = "Defualt" })
hi("DiagnosticError", { link = "Critical" })
hi("DiagnosticHint", { link = "Defualt" })
hi("DiagnosticInfo", { link = "Defualt" })
hi("DiagnosticOk", { link = "Defualt" })
hi("DiagnosticWarn", { link = "Mute" })
hi("Function", { link = "Defualt" })
hi("Identifier", { link = "Defualt" })
hi("ModeMsg", { link = "Defualt" })
hi("MoreMsg", { link = "Defualt" })
hi("Operator", { link = "Defualt" })
hi("Question", { link = "Defualt" })
hi("Removed", { link = "Defualt" })
hi("SignColumn", { link = "Defualt" })
hi("Special", { link = "Defualt" })
hi("SpecialKey", { link = "Defualt" })
hi("Title", { link = "Defualt" })
hi("Type", { link = "Defualt" })
hi("WarningMsg", { link = "Defualt" })
hi("WinBar", { link = "Defualt" })
hi("WinBarNC", { link = "Defualt" })

-- vim-visual-multi
hi("VM_Mono", { fg = fg, bg = red }) -- Main cursor
hi("VM_Cursor", { link = "Select" }) -- Additional cursors
hi("VM_Extend", { link = "Select" }) -- Extend mode
hi("VM_Insert", { link = "Select" }) -- Insert mode

-- mini.pick
hi("MiniPickNormal", { link = "Normal" })
hi("MiniPickMatchRanges", { link = "Critical" })
hi("MiniPickMatchCurrent", { link = "Select" })
