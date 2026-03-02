return {
  -- Theme（jellybeans継続）
  {
    "nanotech/jellybeans.vim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jellybeans")
    end,
  },

  -- UI basics
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end,
  },

  -- File explorer（defx → neo-tree）
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("neo-tree").setup({
        window = { position = "right", width = 40 },
        filesystem = { follow_current_file = { enabled = true } },
      })
    end,
  },

  -- Git（gitgutter → gitsigns）
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({})
    end,
  },

  -- Comment（caw.vim → Comment.nvim）
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({})
    end,
  },

  -- Autopairs（auto-pairs → nvim-autopairs）
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Rainbow（luochen1990/rainbow → rainbow-delimiters）
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Telescope
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
    end,
  },

  -- Treesitter（README上 lazy-load非推奨なので lazy=false ＋ TSUpdate）
  { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },

  -- LSP（vim-lsp/deoplete系を廃止して builtin LSP + nvim-cmp へ）
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim", opts = {} },
  -- mason-lspconfig: lazy.nvim推奨の書き方＋インストール済みを自動 enable :contentReference[oaicite:5]{index=5}
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- Completion（deoplete/neosnippet/vsnip混在を整理して nvim-cmp + LuaSnip）
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        }),
      })

      -- Neovim 0.11系: README例のとおり capabilities を渡して vim.lsp.config/enable :contentReference[oaicite:6]{index=6}
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "lua_ls", "pyright", "clangd", "ts_ls", "texlab" } -- 必要に応じて増減

      for _, name in ipairs(servers) do
        vim.lsp.config(name, { capabilities = capabilities })
        -- mason-lspconfig が自動 enable する運用でも，明示 enable でもよい
        vim.lsp.enable(name)
      end
    end,
  },

  -- Formatter（ALEのformat部分を conform.nvim に寄せる）
  -- format_on_save / formatters_by_ft は READMEの中心 :contentReference[oaicite:7]{index=7}
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },

  -- LaTeX（vimtexは継続）
  { "lervag/vimtex", ft = { "tex" } },

  {
    "coder/claudecode.nvim",
    lazy = false,
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "~/.local/bin/claude",
    },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },

      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },

      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
