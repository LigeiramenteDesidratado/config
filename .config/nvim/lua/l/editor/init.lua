--- User-specific editor tweaks
-- @module l.editor

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local autocmd = require("c.autocmd")

local layer_man = require("l.editor.layer_man")

local layer = {}

-- The startup window doesn't seem to pick up on vim.o changes >.<
local function set_default_win_opt(name, value)
  vim.o[name] = value
  autocmd.bind_vim_enter(function()
    vim.wo[name] = value
  end)
end

-- The startup buffer doesn't seem to pick up on vim.o changes >.<
local function set_default_buf_opt(name, value)
  vim.o[name] = value
  autocmd.bind_vim_enter(function()
    vim.bo[name] = value
  end)
end

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("sheerun/vim-polyglot") -- A bunch of languages
  plug.add_plugin("machakann/vim-sandwich") -- Awesome for dealing with surrounding things, like parens
  plug.add_plugin("cohama/lexima.vim") -- Auto insert matching parens/quotes/stuff
  plug.add_plugin("tpope/vim-commentary") -- Commenting
  plug.add_plugin("bronson/vim-trailing-whitespace") -- Remove trailing whitespace
  plug.add_plugin("godlygeek/tabular") -- Line up text
  plug.add_plugin("rhysd/clever-f.vim") -- Find a character with convenience
  plug.add_plugin("gregsexton/MatchTag") -- Highlights the matching HTML tag
  plug.add_plugin("AndrewRadev/splitjoin.vim")
  plug.add_plugin("ap/vim-buftabline")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- Space for leader, backslash for local leader
  vim.g.mapleader = ","
  vim.g.maplocalleader = "\\"

  -- Required for NERDCommenter
  vim.cmd("filetype plugin on")

  -- Save undo history
  set_default_buf_opt("undofile", true)

  -- Allow a .vimrc file in a project directory with safe commands
  vim.o.exrc = true
  vim.o.secure = true

  -- Use `fd` to exit insert/visual/select/terminal mode
  keybind.bind_command(edit_mode.INSERT, "jk", "<Esc>:FixWhitespace<CR>", { noremap = true })
  keybind.bind_command(edit_mode.INSERT, "kj", "<Esc>:FixWhitespace<CR>", { noremap = true })
  keybind.bind_command(edit_mode.VISUAL_SELECT, "fd", "<esc>", { noremap = true })
  keybind.bind_command(edit_mode.TERMINAL, "fd", "<C-\\><C-n>", { noremap = true })

  -- More convenient buffers
  keybind.bind_command(edit_mode.NORMAL, "<S-J>", ":bp<CR>", { noremap = true })
  keybind.bind_command(edit_mode.NORMAL, "<S-K>", ":bn<CR>", { noremap = true })
  keybind.bind_command(edit_mode.NORMAL, "<leader>w", ":bd<CR>", { noremap = true })

  -- Move a selection block up and down
  keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-k>", ":m'<-2<CR>gv=gv", { noremap = true })
  keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-j>", ":m'>+1<CR>gv=gv", { noremap = true })

  -- Move a single line up and down
  keybind.bind_command(edit_mode.NORMAL, "<C-k>", ":m-2=<CR>==", { noremap = true })
  keybind.bind_command(edit_mode.NORMAL, "<C-j>", ":m+1<CR>==", { noremap = true })

  -- Paste in visual mode without polluting the register
  keybind.bind_command(edit_mode.VISUAL_SELECT, "p", "\"_dP", { noremap = true })

  -- -- Holding down Ctrl makes cursor movement 4x faster
  -- keybind.bind_command(edit_mode.NORMAL, "<C-h>", "4h", { noremap = true })
  -- keybind.bind_command(edit_mode.NORMAL, "<C-j>", "4j", { noremap = true })
  -- keybind.bind_command(edit_mode.NORMAL, "<C-k>", "4k", { noremap = true })
  -- keybind.bind_command(edit_mode.NORMAL, "<C-l>", "4l", { noremap = true })
  -- keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-h>", "4h", { noremap = true })
  -- keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-j>", "4j", { noremap = true })
  -- keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-k>", "4k", { noremap = true })
  -- keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-l>", "4l", { noremap = true })

  -- M-h/j/k/l to resize windows
  keybind.bind_command(edit_mode.NORMAL, "<M-h>", ":vertical resize -1<CR>", { noremap = true })
  keybind.bind_command(edit_mode.NORMAL, "<M-j>", ":resize -1<CR>", { noremap = true })
  keybind.bind_command(edit_mode.NORMAL, "<M-k>", ":resize +1<CR>", { noremap = true })
  keybind.bind_command(edit_mode.NORMAL, "<M-l>", ":vertical resize +1<CR>", { noremap = true })

  -- Default indentation rules
  set_default_buf_opt("tabstop", 4)
  set_default_buf_opt("softtabstop", 4)
  set_default_buf_opt("shiftwidth", 4)
  set_default_buf_opt("expandtab", true) -- Use spaces instead of tabs
  set_default_buf_opt("autoindent", true)
  set_default_buf_opt("smartindent", true)

  -- A shortcut command for :lua print(vim.inspect(...)) (:Li for Lua Inspect)
  vim.api.nvim_command("command! -nargs=+ Li :lua print(vim.inspect(<args>))")

  -- Use triple braces for folding
  set_default_win_opt("foldmethod", "marker")

  -- clever-f config
  vim.g.clever_f_across_no_line = 1
  vim.g.clever_f_smart_case = 1

  -- buftabline config
  vim.g.buftabline_numbers = 2
  vim.g.buftabline_show = 1

  layer_man.init_config()
end

return layer
