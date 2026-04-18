local vim = vim

vim.cmd('colorscheme catppuccin')

vim.lsp.enable({ 'lua_ls', 'clangd', 'ts_ls', "pyright", "rust_analyzer" })
vim.diagnostic.config({ virtual_text = true })

vim.pack.add({
    'https://github.com/chomosuke/typst-preview.nvim',
    'https://github.com/junegunn/fzf',
    'https://github.com/junegunn/fzf.vim',
    'https://github.com/lukas-reineke/indent-blankline.nvim'
})

require("ibl").setup()

local g = vim.g
g.mapleader = " "
g.maplocalleader = " "
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_winsize = 25
g.netrw_keepdir = 0
-- g.clipboard = nil
vim.g.clipboard = {
    name = 'xsel',
    copy = {
        ['+'] = 'xsel --clipboard --input',
        ['*'] = 'xsel --primary --input',
    },
    paste = {
        ['+'] = 'xsel --clipboard --output',
        ['*'] = 'xsel --primary --output',
    },
    cache_enabled = true,
}

local set = vim.opt
set.number = true
set.relativenumber = true
set.mouse = "a"
set.cursorline = true
set.autoindent = true
set.smartindent = true
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 4
set.smarttab = true
set.breakindent = true
set.swapfile = false
set.undofile = true
set.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
set.completeopt = "menu,menuone,noselect,popup"
set.pumheight = 10
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.incsearch = true
set.linebreak = true
set.wrap = true
set.laststatus = 2
set.wildmenu = true

local set_km = vim.keymap.set
set_km("n", ";", ":")
set_km("n", "<C-j>", ":resize +2<CR>")
set_km("n", "<C-k>", ":resize -2<CR>")
set_km("n", "<C-h>", ":vertical resize -2<CR>")
set_km("n", "<C-l>", ":vertical resize +2<CR>")
set_km("v", "<", "<gv")
set_km("v", ">", ">gv")
set_km('n', 'zl', '5zl')
set_km('n', 'zh', '5zh')
set_km("n", "<leader>tn", ":tabnew<CR>")
set_km("n", "<leader>tx", ":tabclose<CR>")
set_km("n", "<leader>bn", ":bNext<CR>")
set_km("n", "<leader>bp", ":bprevious<CR>")
set_km("n", "<A-j>", ":m .+1<CR>==")
set_km("n", "<A-k>", ":m .-2<CR>==")
set_km("v", "<A-j>", ":m '>+1<CR>gv=gv")
set_km("v", "<A-k>", ":m '<-2<CR>gv=gv")
set_km("n", "<leader>fm", function()
    local ft = vim.bo.filetype
    if ft == "python" then
        vim.cmd("!black %")
        vim.cmd("edit")
    else
        vim.lsp.buf.format()
    end
end
)
set_km("n", "<leader>ff", ":Files <CR>")
set_km("n", "<leader>fg", ":Rg <CR>")
set_km("n", "<leader>fb", ":Buffers <CR>")
vim.keymap.set("n", "<leader>ud", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[T]oggle [D]iagnostics" })

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    callback = function()
        local map = vim.keymap.set
        map('n', '-', 'k', { buffer = true })
    end
})
