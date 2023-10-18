local plugins = {
    { "nyoom-engineering/oxocarbon.nvim", lazy = false },
    { 'rockerBOO/boo-colorscheme-nvim' },
    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.fn["mkdp#util#install"]()
        end,
    },


    { "caenrique/swap-buffers.nvim" },
    { "huyvohcmc/atlas.vim" },

    { 'brenoprata10/nvim-highlight-colors' },
    { "nvim-lua/plenary.nvim" },

    {
        'stevearc/oil.nvim',
    },
    { 'mg979/vim-visual-multi' },

    {
        "NvChad/nvterm",
        config = function()
            require("nvterm").setup()
        end,
    },
    -- colorscheme

    -- file tree
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require("nvim-tree").setup()
        end,
    },
    {
        "https://git.sr.ht/~nedia/auto-save.nvim",
        event = { "BufReadPre" },
        opts = {
            events = { 'InsertLeave', 'BufLeave', "TextChanged" },
            silent = true,
            exclude_ft = { 'neo-tree' },
        },
    },
    { 'akinsho/toggleterm.nvim', version = "*", config = true },

    {
        "https://git.sr.ht/~havi/telescope-toggleterm.nvim",
        event = "TermOpen",
        requires = {
            "akinsho/nvim-toggleterm.lua",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension "toggleterm"
        end,
    },
    -- icons, for UI related plugins
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end,
    },

    -- syntax highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require "plugins.configs.treesitter"
        end,
    },

    -- buffer + tab line
    {
        "akinsho/bufferline.nvim",
        lazy = false,
        config = function()
            require "plugins.configs.bufferline"
        end,
    },

    -- statusline

    {
        "echasnovski/mini.statusline",
        lazy = false,
        config = function()
            require("mini.statusline").setup { set_vim_settings = false }
        end,
    },

    -- we use cmp plugin only when in insert mode
    -- so lets lazyload it at InsertEnter event, to know all the events check h-events
    -- completion , now all of these plugins are dependent on cmp, we load them after cmp
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- cmp sources
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",

            -- snippets
            --list of default snippets
            "rafamadriz/friendly-snippets",
            { 'folke/which-key.nvim', opts = {} },
            -- snippets engine
            {
                "L3MON4D3/LuaSnip",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },

            -- autopairs , autocompletes ()[] etc
            -- {
            --     "windwp/nvim-autopairs",
            --     config = function()
            --         require("nvim-autopairs").setup()
            --
            --         --  cmp integration
            --         local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            --         local cmp = require "cmp"
            --         cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
            --     end,
            -- },
        },
        config = function()
            require "plugins.configs.cmp"
        end,
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonInstall" },
        opts = {
            ensure_installed = {
                "clangd",
                "clang-format",
            }
        },
        config = function()
            require("mason").setup()
        end,
    },

    -- lsp
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require "plugins.configs.lspconfig"
            require "lspconfig"
        end,
        dependencies = {
            -- formatting , linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                event = "VeryLazy",
                config = function()
                    require "plugins.configs.null"
                end,
            },
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',

        },

    },

    -- indent lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("indent_blankline").setup()
        end,
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },

    -- files finder etc
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            require "plugins.configs.telescope"
        end,
    },

    -- git status on signcolumn etc
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },
    -- comment plugin
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },
}

require("lazy").setup(plugins, require "plugins.configs.lazy")


local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    ---
    on_attach = my_on_attach,
    ---
}
require("oil").setup()
require('nvim-highlight-colors').setup {}
