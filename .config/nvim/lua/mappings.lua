local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim" -- path where its going to be installed
local map = vim.keymap.set

vim.opt.rtp:prepend(lazypath)
require "plugins"


map("n", "<Esc>", "<cmd> :noh <CR>")
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>") -- Open file explorer

map("n", "<leader>x", "<cmd> :bd! <CR>")       -- Close  current buffer

-- Move group of lines
map('v', "J", ":m '>+1<CR>gv=gv")
map('v', "K", ":m '<-2<CR>gv=gv")

-- Copy to System Clipboard
map('n', "<leader>y", "\"+y")
map('v', "<leader>y", "\"+y")

-- bufferline
map("n", "<Tab>", "<cmd> BufferLineCycleNext <CR>")
map("n", "<S-Tab>", "<cmd> BufferLineCyclePrev <CR>")
map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
map('n', '<leader>n', 'o<Esc>', { noremap = true, silent = true })
map('n', '<leader>N', 'O<Esc>', { noremap = true, silent = true })


-- Replacing current word with some text
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- map("n", "<leader>k",  vim.lsp.buf.hover)
-- require('lsp_signature').toggle_float_win()
-- comment.nvim
map("n", "<leader>/", function() require("Comment.api").toggle.linewise.current() end)
map("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>")

-- Telescope
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>")
map("n", "<leader>rr", function() require("telescope.builtin").registers() end)
map("n", "<leader>ls", function() require("telescope.builtin").lsp_document_symbols() end)
map("n", "<leader>lr", function() require("telescope.builtin").lsp_references() end)
map("n", "<leader>f", vim.lsp.buf.format)


-- GitSigns
map("n", "<leader>ghd", "<cmd> Gitsigns diffthis <CR>" )



-- <leader>tth --> Toggle Horizontal Terminal
-- <leader>ttv --> Toggle Vertical Terminal
--
function getTerminal(position)
    local current_directory = vim.fn.expand("%:p:h") -- Get the full path of the current file
    local command = string.format("cd %s ; clear", current_directory)
    require("nvterm.terminal").send(command, position)
end

map('n', '<leader>t', ':lua getTerminal("horizontal")<CR>', { noremap = true, silent = true })
map('n', '<leader>v', ':lua getTerminal("vertical")<CR>', { noremap = true, silent = true })

-- Allow Navigate Windows from terminal mode
map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })

-- Resize Buffers
map("n", "<C-A-k>", ":resize +1<CR>", { noremap = true, silent = true })
map("n", "<C-A-j>", ":resize -3<CR>", { noremap = true, silent = true })
map("n", "<C-A-h>", ":vertical resize -3<CR>", { noremap = true, silent = true })
map("n", "<C-A-l>", ":vertical resize +1<CR>", { noremap = true, silent = true })


-- Stay in indent mode
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- To Move through windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Map F5 to run cpp files
map('n', '<F5>', ':lua runCppFile()<CR>', { noremap = true, silent = true })

-- Function to run current CPP file in a horizontal terminal
function runCppFile()
    local current_file = vim.fn.expand("%:p") -- Get the full path of the current file
    local command = string.format("clear; g++ --std=c++17 %s -o a.out && ./a.out; rm a.out", current_file)
    require("nvterm.terminal").send(command, "horizontal")
end

--     nnoremap <A-h> <cmd>lua require('swap-buffers').swap_buffers('h')<CR>
--     nnoremap <A-l> <cmd>lua require('swap-buffers').swap_buffers('l')<CR>

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
