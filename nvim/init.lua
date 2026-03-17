--- ------------------
-- options
-- -------------------
-- File handling --
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- number line
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = false
vim.opt.guicursor = ""
vim.g.netrw_banner = 0

vim.opt.showmode = true
vim.opt.cmdheight = 0
vim.opt.statusline = "[%{toupper(mode())}]  %f  %m"
vim.opt.laststatus = 0

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
vim.opt.smartindent = true
vim.opt.cindent = true

-- Completion --
vim.opt.completeopt = { "menuone", "noselect" }

-- Window management --
vim.opt.splitbelow = true
vim.opt.splitright = true

-- color
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#FCE094", fg = "#07080D" })
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })

-- ----------------------
-- COMMANDS / FUNCTIONS
-- ----------------------
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
	else
		vim.notify("No formatter for filetype: " .. ft, vim.log.levels.ERROR)
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

-- ------------------
-- Keybindings
-- ------------------

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local opts = { noremap = true, silent = true }

-- INSERT --
vim.keymap.set("i", "jk", "<Esc>", opts)

-- Buffer
vim.keymap.set("n", "<Leader>e", ":Hex<CR>", opts)
vim.keymap.set("n", "<Leader>E", ":Exp<CR>", opts)
vim.keymap.set("n", "<Leader>q", ":bd!<CR>", opts)
vim.keymap.set("n", "<Leader>w", ":wa<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":buffers<CR>", opts)
vim.keymap.set("n", "<Leader>r", ":so $MYVIMRC<CR>", opts)
vim.keymap.set("n", "<Leader>=", format_file, opts)
vim.keymap.set("n", "<leader>/", ":set hlsearch!<CR>", opts)
vim.keymap.set("n", "<F6>", spell_check, opts)

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

-- ------------------
-- Load plugins
-- ------------------
-- custom path for plugins
vim.opt.packpath:prepend(vim.fn.expand("~/.local/share/nvim/pack/plugins/"))

-- plugins load
-- vim-visual-multi loaded automatically
require("mini.pick").setup()
require("neoscroll").setup()

-- mini pick
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")

-- lsp
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
})
vim.lsp.enable({ "lua_ls", "pyright", "gopls", "ts_ls" })
vim.diagnostic.config({ virtual_text = true })
