-- Leader
vim.g.mapleader = "\\<Space>"
vim.g.maplocalleader = " "

-- =========
-- Options / Keymaps / Autocmds
-- =========
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- =========
-- lazy.nvim bootstrap
-- =========
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(require("plugins"), {
  checker = { enabled = true },
  change_detection = { notify = false },
})
