-- ==================
-- options
-- ==================-
-- File handling --
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.wrap = false
vim.opt.guicursor = ""
vim.g.netrw_banner = 0
vim.opt.laststatus = 3

-- scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true

-- Search --
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

-- color
vim.opt.background = "dark"
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#FCE094", fg = "#07080D" })

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
		javascript = "prettier --write",
		typescript = "prettier --write",
		html = "prettier --write",
		json = "prettier --write",
		css = "prettier --write",
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
vim.keymap.set("n", "<Leader>b", ":buffers<CR>", opts)
vim.keymap.set("n", "<Leader>r", ":so $MYVIMRC<CR>", opts)
vim.keymap.set("n", "<leader>/", ":set hlsearch!<CR>", opts)
vim.keymap.set("n", "<Leader><BS>", "<C-^>", opts)
vim.keymap.set("n", "<Leader>=", format_file, opts)
vim.keymap.set("n", "<Leader>E", vim.diagnostic.setqflist)
vim.keymap.set("n", "<F6>", spell_check, opts)

-- terminal
vim.keymap.set("n", "<C-CR>", ":term<CR>A", opts)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

-- window move
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

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

-- Center me
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- mini pick
vim.keymap.set("n", "<Leader>ff", ":Pick files<CR>", opts)
vim.keymap.set("n", "<Leader>fg", ":Pick grep_live<CR>", opts)
vim.keymap.set("n", "<Leader><Leader>", ":Pick buffers<CR>", opts)

vim.keymap.set("n", "<Leader>e", ":Oil<CR>", opts)

-- ==================
-- Plugins
-- ==================
-- Install packages
vim.pack.add({
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.statusline",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/mg979/vim-visual-multi",
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/olivercederborg/poimandres.nvim",
})

-- Load plugins
require("mini.pick").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("oil").setup()
require("neoscroll").setup()

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
