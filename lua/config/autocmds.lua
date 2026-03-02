-- filetype拡張（.ltx と .ino）
vim.filetype.add({
  extension = {
    ltx = "tex",
    ino = "cpp",
  },
})

-- JS/TSだけ2スペ
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

-- LaTeX: latexmk -pvc を terminal で（旧 run を踏襲）
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function(ev)
    vim.keymap.set("n", "run", function()
      local file = vim.fn.expand("%:p")
      vim.cmd("botright split | resize 15 | terminal latexmk -pvc " .. vim.fn.shellescape(file))
    end, { buffer = ev.buf, silent = true })
  end,
})

-- Treesitter を Neovim側で有効化（nvim-treesitter READMEの方針に寄せる）
-- 必要なftだけ列挙（増やしてよい）
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "lua", "python", "javascript", "typescript", "toml", "markdown", "tex" },
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
    vim.bo[ev.buf].indentexpr = "v:lua.vim.treesitter.indentexpr()"
  end,
})