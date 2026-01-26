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
vim.cmd.colorscheme("darkshade")
-- stop treesitter
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.treesitter.stop()
	end,
})

-- ----------------------
-- COMMANDS / FUNCTIONS
-- ----------------------
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 150 })
	end,
})

local function format_file()
	local ft = vim.bo.filetype

	if ft == "python" then
		vim.cmd("silent !black --quiet %")
	elseif ft == "lua" then
		vim.cmd("silent !stylua %")
    elseif ft == "go" then
        vim.cmd("silent !go fmt %")
	else
		vim.notify("No formatter for filetype: " .. ft, vim.log.levels.ERROR)
	end
	vim.cmd("edit!")
end
-- ------------------
-- Keybindings
-- ------------------

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
opts = { noremap = true, silent = true }

-- INSERT --
vim.keymap.set("i", "jk", "<Esc>", opts)

-- Buffer
vim.keymap.set("n", "<Leader>e", ":Hex<CR>", opts)
vim.keymap.set("n", "<Leader>q", ":bd!<CR>", opts)
vim.keymap.set("n", "<Leader>w", ":wa<CR>", opts)
vim.keymap.set("n", "<Leader>b", ":buffers<CR>", opts)
vim.keymap.set("n", "<Leader>r", ":so $MYVIMRC<CR>", opts)
vim.keymap.set("n", "<Leader>=", format_file, opts)
vim.keymap.set('n', '<leader>/', ':set hlsearch!<CR>')

-- Select
vim.keymap.set({ "n", "v" }, "<Leader>;", "V", opts)
vim.keymap.set({ "n", "v" }, "<Leader>a", "ggVG", opts)

-- Duplicated line
vim.keymap.set("n", "<A-.>", ":copy .<CR>", opts)
vim.keymap.set("v", "<A-.>", ":copy . -1<CR>gv", opts)
vim.keymap.set("i", "<A-.>", "<C-o>:copy .<CR>", opts)

-- Move cursor at beginning and end of the line
vim.keymap.set({"n", "v"}, "<A-l>", "$")
vim.keymap.set({"n", "v"}, "<A-h>", "^")
vim.keymap.set("i", "<A-l>", "<C-o>$")
vim.keymap.set("i", "<A-h>", "<C-o>^")

-- Newline while in insert mode
vim.keymap.set({"i", "n"}, "<A-[>", "<Esc>O", opt)
vim.keymap.set({"i", "n"}, "<A-]>", "<Esc>o", opt)

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
vim.keymap.set("n", "<C-f>", "<C-f>zz", opts)
vim.keymap.set("n", "<C-b>", "<C-b>zz", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "*", "*zzzv", opts)
vim.keymap.set("n", "#", "#zzzv", opts)
