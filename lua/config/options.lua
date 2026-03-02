local opt = vim.opt

opt.title = true
opt.number = true
opt.list = true
opt.cursorline = true
opt.showmatch = true
opt.matchtime = 1

-- インデント
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- UI
opt.laststatus = 2
opt.showtabline = 2
opt.pumheight = 8
opt.background = "dark"
opt.display = "lastline"

-- 文字コード
opt.fileencodings = { "utf-8", "euc-jp", "cp932" }
opt.matchpairs:append({ "「:」", "『:』", "（:）", "【:】", "《:》", "〈:〉", "［:］" })

-- クリップボード（Neovimでは通常 unnamedplus が欲しい）
opt.clipboard = "unnamedplus"

-- Swap/Backup/Undo を stdpath に寄せて「ONで安全」にする
local state = vim.fn.stdpath("state")
vim.fn.mkdir(state .. "/undo", "p")
vim.fn.mkdir(state .. "/swap", "p")
vim.fn.mkdir(state .. "/backup", "p")
opt.undofile = true
opt.undodir = state .. "/undo"
opt.swapfile = true
opt.directory = state .. "/swap//"
opt.backup = true
opt.backupdir = state .. "/backup//"

-- python provider を固定したい場合だけ（不要ならこの3行ごと消す）
local py = vim.fn.exepath("python3")
if py ~= "" then
  vim.g.python3_host_prog = py
end

vim.opt.ambiwidth = "single"
vim.opt.list = true
vim.opt.listchars = {

  tab = ">-",
  trail = ".",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}
vim.opt.fillchars = {
  eob = " ",
  fold = "-",
  foldopen = "v",
  foldclose = ">",
  foldsep = "|",
}
