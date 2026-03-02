local map = vim.keymap.set

vim.g.mapleader = ','
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { silent = true })
map("n", "Y", "y$")
map({ "n", "x" }, "j", "gj")
map({ "n", "x" }, "k", "gk")

-- 旧: <C-o> を潰していたので，代替を leader に逃がす
map("n", "<leader>o", "o<Esc>")

-- ファイラ（旧 fi を踏襲）
map("n", "fi", "<cmd>Neotree reveal toggle right<CR>", { silent = true })

-- 手動フォーマット（旧 Alt-t 相当）
map({ "n", "v" }, "<M-t>", function()
  require("conform").format({ lsp_fallback = true, timeout_ms = 1000 })
end, { silent = true })

-- C/C++: コンパイル＆実行（terminal split）
map("n", "<M-r>", function()
  local file = vim.fn.expand("%:p")
  local out = vim.fn.expand("%:p:r")
  local cmd = ("g++ %s -Wall -std=c++20 -O2 -o %s && %s"):format(
    vim.fn.shellescape(file),
    vim.fn.shellescape(out),
    vim.fn.shellescape(out)
  )
  vim.cmd("botright split | resize 15 | terminal " .. cmd)
end, { silent = true })
