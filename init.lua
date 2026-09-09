-- PLUGIN CONFIGURATION
-- ================================================================================================

vim.pack.add({
	
    -- TREESITTER
    -- ----------
    { src = "https://github.com/neovim-treesitter/treesitter-parser-registry" },
    { src = "https://github.com/neovim-treesitter/nvim-treesitter" },


    -- TELESCOPE
    -- ---------
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },


    -- LUALINE
    -- -------
    { src = "https://github.com/nvim-lualine/lualine.nvim" },


    -- ONE DARK PRO (THEME)
    -- --------------------
    { src = "https://github.com/olimorris/onedarkpro.nvim" },
})


-- VIM SETTINGS
-- ================================================================================================

-- LEADER
-- ------
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- COLUMN
-- ------
vim.opt.colorcolumn = "100"


-- EDITOR
-- ------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 4
vim.opt.wrap = false


-- SEARCHING
-- ---------
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- SPLITS
-- ------
vim.opt.splitbelow = true
vim.opt.splitright = true


-- FILES
-- -----
vim.opt.undofile = true


-- UI
-- --
vim.opt.termguicolors = true


-- NATIVE COMPLETION
-- -----------------
vim.opt.completeopt = { "menuone", "noselect", "popup" }


-- DIAGNOSTICS
-- -----------
vim.diagnostic.config({
    severity_sort = true,
})


-- LSP SETTINGS
-- ================================================================================================

-- ENABLE CLANGD
-- -------------
vim.lsp.enable("clangd")


-- ENABLE NATIVE LSP COMPLETION
-- ----------------------------
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),

    callback = function(event)
        local client = assert(
            vim.lsp.get_client_by_id(event.data.client_id)
        )

        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(
                true,
                client.id,
                event.buf,
                { autotrigger = true }
            )
        end

        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
    end,
})


-- MANUALLY TRIGGER COMPLETION
-- ---------------------------
vim.keymap.set("i", "<C-Space>", function()
    vim.lsp.completion.get()
end, { desc = "LSP completion" })


-- FORMAT THE CURRENT BUFFER
-- -------------------------
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = false })
end, { desc = "Format buffer" })


-- PLUGINS SETUP
-- ================================================================================================

-- TELESCOPE CONFIG
-- ----------------
local telescope = require("telescope")

telescope.setup({
    defaults = {
        sorting_strategy = "ascending",

        layout_config = {
            prompt_position = "top",
        },

        path_display = {
            "smart",
        },
    },

    extensions = {
        file_browser = {
            hijack_netrw = true,
            grouped = true,
        },
    },
})

telescope.load_extension("file_browser")


-- LUALINE CONFIG
-- --------------
require("lualine").setup({
    options = {
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
    },
})


-- ONEDARK PRO CONFIG
-- ------------------
require("onedarkpro").setup({
    plugins = {
        all = false,
        nvim_lsp = true,
        treesitter = true,
    },

    options = {
        transparency = true,
    },
})

vim.cmd.colorscheme("vaporwave")


-- TRANSPARENCY & VISUALS
-- ================================================================================================
local function set_ui_overrides()
    -- Transparent UI
    local transparent_groups = {
        "Normal",
        "NormalNC",
        "EndOfBuffer",
        "LineNr",
        "LineNrAbove",
        "LineNrBelow",
        "CursorLineNr",
        "SignColumn",
        "FoldColumn",
        "CursorLineSign",
        "CursorLineFold",
        "WinSeparator",
        "WinBar",
        "WinBarNC",
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
        "TelescopeNormal",
        "TelescopeBorder",
        "TelescopePromptNormal",
        "TelescopePromptBorder",
        "TelescopeResultsNormal",
        "TelescopeResultsBorder",
        "TelescopePreviewNormal",
        "TelescopePreviewBorder",
    }

    for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none", update = true, })
    end

    -- Fixed 100-column guide
    vim.api.nvim_set_hl(0, "ColorColumn", {
        bg = "#1d1f23",
    })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ui_overrides", { clear = true }),
    callback = set_ui_overrides,
})

vim.cmd.colorscheme("vaporwave")

set_ui_overrides()

