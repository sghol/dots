-- ==================
-- options
-- ==================-
-- File handling --
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.wrap = false
vim.opt.guicursor = ""
vim.opt.laststatus = 3

-- scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- find
vim.opt.path:append("**")
vim.opt.wildmenu = true -- better completion

-- Indentation --
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true

-- Completion --
vim.opt.completeopt = { "menuone", "noselect" }

-- Window management --
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false

-- text-code
vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.termbidi = true
vim.opt.arabicshape = true

-- statusline
vim.o.statusline = "%#StatusLineNormalMode#%{mode()}%#StatusLine# %f  %=  %y  %l:%L "

-- color
vim.opt.background = "dark"
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#FCE094", fg = "#000000" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "#14161B", fg = "#9b9ea4" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#E0E2EA", fg = "#2c2e33", bold = true })

-- color for statusline mode
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#14161B", fg = "#E0E2EA" })
vim.api.nvim_set_hl(0, "StatusLineNormalMode", { bg = "#E0E2EA", fg = "#14161B", bold = true })
vim.api.nvim_set_hl(0, "StatusLineInsertMode", { bg = "#b4f6c0", fg = "#14161B", bold = true })
vim.api.nvim_set_hl(0, "StatusLineVisualMode", { bg = "#A6DBFF", fg = "#14161B", bold = true })
vim.api.nvim_set_hl(0, "StatusLineTerminalMode", { bg = "#FCE094", fg = "#14161B", bold = true })
vim.api.nvim_set_hl(0, "StatusLineFilePath", { bg = "#14161B", fg = "#E0E2EA" })
vim.api.nvim_set_hl(0, "StatusLineBranch", { bg = "#14161B", fg = "#b4f6c0" })

-- ======================
-- Status & Tab line
-- ======================
-- git branch (cached; refreshed on enter / dir change)
vim._git_branch = ""
local function refresh_git()
	local out =
		vim.fn.systemlist("git -C " .. vim.fn.shellescape(vim.fn.getcwd()) .. " branch --show-current 2>/dev/null")
	vim._git_branch = (out[1] and out[1] ~= "") and out[1] or ""
end
refresh_git()
vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, { callback = refresh_git })

local mode_group = {
	n = "%#StatusLineNormalMode#",
	i = "%#StatusLineInsertMode#",
	v = "%#StatusLineVisualMode#",
	V = "%#StatusLineVisualMode#",
	["\22"] = "%#StatusLineVisualMode#",
	t = "%#StatusLineTerminalMode#",
}
local mode_name = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	t = "TERMINAL",
	R = "REPLACE",
	c = "COMMAND",
}

vim.my_statusline = function()
	local m = vim.fn.mode():sub(1, 1)
	local mode = mode_group[m] or "%#StatusLineNormalMode#"
	local name = mode_name[m] or m:upper()
	local branch = vim._git_branch ~= "" and ("| %#StatusLineBranch#" .. vim._git_branch .. "%#StatusLine#") or ""
	local filePath = "%#StatusLineFilePath# %f %#StatusLine#"
	return mode .. " " .. name .. filePath .. branch .. " %=  %y %c | %l/%L "
end
vim.o.statusline = "%!v:lua.vim.my_statusline()"

-- tabline: filename + [+] for not saved file
vim.my_tabline = function()
	local out, cur = {}, vim.fn.tabpagenr()
	for i = 1, vim.fn.tabpagenr("$") do
		local buf = vim.fn.tabpagebuflist(i)[vim.fn.tabpagewinnr(i)]
		local name = vim.fn.fnamemodify(vim.fn.bufname(buf), ":t")
		if name ~= "" then
			local hl = (i == cur) and "%#TabLineSel#" or "%#TabLine#"
			local mod = vim.fn.getbufvar(buf, "&modified") == 1 and " [+]" or ""
			out[#out + 1] = hl .. "%" .. i .. "T " .. name .. mod .. " %T"
		end
	end
	return table.concat(out) .. "%#TabLineFill#"
end
vim.o.tabline = "%!v:lua.vim.my_tabline()"

-- ======================
-- COMMANDS / FUNCTIONS
-- ======================
-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 150 })
	end,
})

-- file specific configs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "html", "css" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
		vim.bo.softtabstop = 2
	end,
})

-- code formatting
local function format_file()
	-- use cli tools to format the file
	local ft = vim.bo.filetype
	local formatters = {
		python = "black --quiet",
		lua = "stylua",
		go = "go fmt",
		sql = "pg_format -f 2 -u 2 -o",
		javascript = "prettier --write --print-width 99",
		typescript = "prettier --write",
		html = "prettier --write",
		css = "prettier --write",
		json = "prettier --write",
		sh = "shfmt -i 2 -ci -s -w",
		bash = "shfmt -i 2 -ci -s -w",
	}
	local fmt = formatters[ft]
	if fmt then
		vim.cmd("silent !" .. fmt .. " %")
		vim.cmd("edit!")
	end
end

-- Spell check
local function spell_check()
	vim.opt.spell = not vim.o.spell
	if vim.o.spell then
		vim.opt.spelllang = "en_us"
		vim.notify("Spell check ON", vim.log.levels.INFO)
	else
		vim.notify("Spell check OFF", vim.log.levels.INFO)
	end
end

-- highlight words same as word under cursor
local hlsearch_enabled = vim.o.hlsearch
local function hi_under_cursor()
	if hlsearch_enabled then
		vim.cmd("set nohlsearch")
	else
		local word = vim.fn.expand("<cword>")
		vim.cmd("let @/='\\V" .. word .. "'")
		vim.cmd("set hlsearch")
	end
	-- update state
	hlsearch_enabled = vim.o.hlsearch
end

-- Toggle a persistent terminal at the bottom
local term_buf = nil
local term_win = nil
local function toggle_terminal()
	-- Terminal window currently visible -> just hide it
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_hide(term_win)
		term_win = nil
		return
	end
	-- Terminal buffer exists but window is closed -> reopen it
	if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
		vim.cmd("split | resize 20")
		vim.api.nvim_win_set_buf(0, term_buf)
		term_win = vim.api.nvim_get_current_win()
	else
		-- No terminal yet -> create one
		vim.cmd("split | resize 20 | terminal")
		term_buf = vim.api.nvim_get_current_buf()
		-- vim.bo[term_buf].buflisted = false
		term_win = vim.api.nvim_get_current_win()
	end

	vim.cmd("startinsert")
end

-- fzf open picker in current working directory
local function fzf_files_in_cwd()
	require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h") })
end

-- ==================
-- Keybindings
-- ==================
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local opts = { noremap = true, silent = true }

-- INSERT --
vim.keymap.set("i", "jk", "<Esc>", opts)

-- buffer
vim.keymap.set("n", "<Leader>q", ":bd!<CR>", opts)
vim.keymap.set("n", "<Leader>w", ":wa<CR>", opts)
vim.keymap.set("n", "<Leader><Tab>", ":b#<CR>", opts)

-- tab
vim.keymap.set("n", "<A-1>", "1gt<CR>", opts)
vim.keymap.set("n", "<A-2>", "2gt<CR>", opts)
vim.keymap.set("n", "<A-3>", "3gt<CR>", opts)

-- higligh search and words under cursor
vim.keymap.set("n", "<F8>", hi_under_cursor, opts)

-- reload nvim config
vim.keymap.set("n", "<Leader>R", ":so $MYVIMRC<CR>", opts)

-- custom scripts keys
vim.keymap.set("n", "<Leader>=", format_file, opts)
vim.keymap.set("n", "<Leader>E", vim.diagnostic.setqflist)
vim.keymap.set("n", "<F6>", spell_check, opts)

-- terminal keymaps
vim.keymap.set({ "n" }, "<Leader>T", ":tabnew<CR>:terminal<CR>GA", opts)
vim.keymap.set({ "n", "t" }, "<C-CR>", toggle_terminal, opts)
vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", opts)

-- Select
vim.keymap.set({ "n", "v" }, "<Leader>;", "V", opts)
vim.keymap.set({ "n", "v" }, "<Leader>a", "ggVG", opts)

-- Duplicated line
vim.keymap.set("n", "<A-.>", ":copy .<CR>", opts)
vim.keymap.set("v", "<A-.>", ":copy . -1<CR>gv", opts)
vim.keymap.set("i", "<A-.>", "<C-o>:copy .<CR>", opts)

-- Newline while in insert mode
vim.keymap.set({ "i", "n" }, "<A-[>", "<Esc>O", opts)
vim.keymap.set({ "i", "n" }, "<A-]>", "<Esc>o", opts)

-- Move line up/down
vim.keymap.set("n", "<A-j>", ":move .+1<CR>==", opts)
vim.keymap.set("n", "<A-k>", ":move .-2<CR>==", opts)
vim.keymap.set("i", "<A-j>", "<Esc>:move .+1<CR>==gi", opts)
vim.keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi", opts)
vim.keymap.set("v", "<A-j>", ":move '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<A-k>", ":move '<-2<CR>gv=gv", opts)

-- Copy / Past
vim.keymap.set("n", "<Leader>Y", '"+y$', opts)
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', opts)
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', opts)
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+P', opts)
vim.keymap.set({ "n", "v" }, "<Leader>d", '"_d', opts)
vim.keymap.set({ "n", "v" }, "<Leader>dd", '"_dd', opts)

-- center me
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- mini pick
vim.keymap.set("n", "<Leader>f", ":FzfLua files<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":FzfLua buffers<CR>", opts)
vim.keymap.set("n", "<Leader>/", ":FzfLua lines<CR>", opts)
vim.keymap.set("n", "<Leader>.", fzf_files_in_cwd, opts)
vim.keymap.set("n", "<Leader>g", ":FzfLua live_grep<CR>", opts)
vim.keymap.set("n", "<Leader>G", ":FzfLua global<CR>", opts)
vim.keymap.set("n", "<Leader>r", ":FzfLua lsp_references<CR>", opts)
vim.keymap.set("n", "<Leader>D", ":FzfLua diagnostics_document<CR>", opts)

vim.keymap.set("n", "<Leader>e", ":Oil<CR>", opts)

-- ==================
-- Plugins
-- ==================
-- Install packages
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/mg979/vim-visual-multi",
	"https://github.com/brianaung/yasl.nvim",
})

-- Load plugins
require("nvim-web-devicons").setup()
require("neoscroll").setup()
require("oil").setup()
-- require("yasl").setup()
-- require("yasl").setup({
-- 	components = {
-- 		"mode",
-- 		" ",
-- 		"%F",
-- 		" ",
-- 		"branch",
-- 		" ",
-- 		"diagnostics",
-- 		" ",
-- 		"filetype",
-- 		" ",
-- 		"[%-8.(%l, %c%V%) %P]",
-- 		" ",
-- 	},
-- })
require("fzf-lua").setup({ { "ivy", "hide" } })

-- ==================
-- LSP
-- ==================
-- Lua
vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
}

-- Python
vim.lsp.config["pyright"] = {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "requirements.txt" },
}

-- Go
vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.mod", "go.work" },
}

-- Javascipt / TypeScript
vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript", "typescript" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}

-- PHP
vim.lsp.config["intelephense"] = {
	cmd = { "intelephense", "--stdio" },
	filetypes = { "php" },
	root_markers = { ".git", "composer.json" },
}

-- C / C++
vim.lsp.config["clangd"] = {
	cmd = { "clangd" },
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
}
-- lsp enable
vim.lsp.enable({ "lua_ls", "pyright", "gopls", "ts_ls", "intelephense", "clangd" })
vim.diagnostic.config({ virtual_text = true })
