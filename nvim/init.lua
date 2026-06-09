-- ─────────────────────────────────────────
-- LEADER KEY
-- ─────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ─────────────────────────────────────────
-- OPTIONS DE BASE
-- ─────────────────────────────────────────

vim.opt.number = true           -- numéros de ligne
vim.opt.relativenumber = false  -- pas de numérotation relative
vim.opt.clipboard = "unnamedplus" -- copier/coller système
vim.opt.tabstop = 4             -- taille tabulation
vim.opt.shiftwidth = 4          -- indentation
vim.opt.expandtab = true        -- espaces au lieu de tabs
vim.opt.termguicolors = true    -- couleurs 24bit
vim.opt.wrap = false            -- pas de retour à la ligne auto
vim.opt.mouse = "a"             -- souris activée

-- ─────────────────────────────────────────
-- FOND TRANSPARENT
-- ─────────────────────────────────────────
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- ─────────────────────────────────────────
-- GESTIONNAIRE DE PLUGINS
-- ─────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ─────────────────────────────────────────
-- PLUGINS
-- ─────────────────────────────────────────
require("lazy").setup({

    -- ─────────────────────────────────────────
    -- THEME
    -- ─────────────────────────────────────────
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme tokyonight-night")
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        end,
    },

    -- ─────────────────────────────────────────
    -- BARRE DE STATUT
    -- ─────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    component_separators = "|",
                    section_separators = "",
                }
            })
        end,
    },

    -- ─────────────────────────────────────────
    -- EXPLORATEUR DE FICHIERS
    -- ─────────────────────────────────────────
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup()
            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
        end,
    },

    -- ─────────────────────────────────────────
    -- TELESCOPE
    -- ─────────────────────────────────────────
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<C-p>", builtin.find_files)
            vim.keymap.set("n", "<C-f>", builtin.live_grep)
        end,
    },

    -- ─────────────────────────────────────────
    -- TREESITTER
    -- ─────────────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                ensure_installed = { "lua", "python", "bash", "json", "yaml" },
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- ─────────────────────────────────────────
    -- AUTOCOMPLETION
    -- ─────────────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },

    -- ─────────────────────────────────────────
    -- INDENTATION VISUELLE
    -- ─────────────────────────────────────────
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
    },

    -- ─────────────────────────────────────────
    -- FERMETURE AUTOMATIQUE
    -- ─────────────────────────────────────────
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

})
