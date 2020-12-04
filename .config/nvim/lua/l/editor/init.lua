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
  plug.add_plugin("machakann/vim-sandwich") -- Awesome for dealing with surrounding things, like parens
  plug.add_plugin("cohama/lexima.vim") -- Auto insert matching parens/quotes/stuff
  plug.add_plugin("tpope/vim-commentary") -- Commenting
  plug.add_plugin("bronson/vim-trailing-whitespace") -- Remove trailing whitespace
  plug.add_plugin("rhysd/clever-f.vim") -- Find a character with convenience
  plug.add_plugin("alvan/vim-closetag")
  plug.add_plugin("gregsexton/MatchTag") -- Highlights the matching HTML tag
  plug.add_plugin("AndrewRadev/splitjoin.vim")
  plug.add_plugin("ap/vim-buftabline")
  -- plug.add_plugin("rafcamlet/nvim-luapad")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- Space for leader, backslash for local leader
  vim.g.mapleader = ","
  vim.g.maplocalleader = ","

  vim.g.closetag_filetypes = 'html,vue'

  vim.cmd("filetype plugin on")

  -- Save undo history
  set_default_buf_opt("undofile", true)

  -- no backup
  vim.o.backup = false
  vim.o.writebackup = false
  vim.o.swapfile = false

  --  Enable hidden buffers
  vim.o.hidden = true

  -- When a file has been detected to have been changed outside of Vim and it has not been changed inside of Vim, automatically read it again.
  vim.o.autoread = true

  -- Default values for keybindings
  local opts = { noremap=true, silent=true }

  -- Use `fd` to exit insert/visual/select/terminal mode
  keybind.bind_command(edit_mode.INSERT, "jk", "<Esc>:FixWhitespace<CR>", opts)
  keybind.bind_command(edit_mode.INSERT, "kj", "<Esc>:FixWhitespace<CR>", opts)
  keybind.bind_command(edit_mode.VISUAL_SELECT, "fd", "<esc>", opts)

  -- Autosave buffers before leaving them
  autocmd.bind("BufLeave *", function()
      vim.cmd(":wa")
    end)

  autocmd.bind("TextYankPost *", function()
    return vim.highlight.on_yank({
        higroup = "Search",
        timeout = 100
      })
  end)

  autocmd.bind("BufReadPost * ", function()
      vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif]])
    end)


  -- More convenient buffers
  keybind.bind_command(edit_mode.NORMAL, "<S-J>", ":bp<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<S-K>", ":bn<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>w", ":bd<CR>", opts)

  -- Move a selection block up and down
  -- keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-k>", ":m'<-2<CR>gv=gv", opts)
  -- keybind.bind_command(edit_mode.VISUAL_SELECT, "<C-j>", ":m'>+1<CR>gv=gv", opts)

  -- Move a single line up and down
  -- keybind.bind_command(edit_mode.NORMAL, "<C-k>", ":m-2=<CR>==", opts)
  -- keybind.bind_command(edit_mode.NORMAL, "<C-j>", ":m+1<CR>==", opts)

  -- duplicate selection to upper and down without polluting the register
  keybind.bind_command(edit_mode.VISUAL_SELECT, "<S-J>", ":t'><cr>", opts)
  keybind.bind_command(edit_mode.VISUAL_SELECT, "<S-K>", ":t .-1<cr>", opts)

  -- Paste in visual mode without polluting the register
  keybind.bind_command(edit_mode.VISUAL_SELECT, "p", "\"_dP", opts)

  -- Switch CWD to the directory of the open buffer
  keybind.bind_command(edit_mode.NORMAL, "<leader>cd", ": cd %:p:h<cr>:pwd<cr>", { noremap=true })

  -- Default indentation rules
  set_default_buf_opt("tabstop", 4)
  set_default_buf_opt("softtabstop", 4)
  set_default_buf_opt("shiftwidth", 4)
  set_default_buf_opt("expandtab", true) -- Use spaces instead of tabs
  set_default_buf_opt("autoindent", true)
  set_default_buf_opt("smartindent", true)

  -- Copy/Paste/Cut
  vim.o.clipboard = "unnamed,unnamedplus"
  vim.o.guicursor = ""

  -- A shortcut command for :lua print(vim.inspect(...)) (:Li for Lua Inspect)
  vim.api.nvim_command("command! -nargs=+ Li :lua print(vim.inspect(<args>))")

  -- Use triple braces for folding
  set_default_win_opt("foldmethod", "marker")

  -- clever-f config
  vim.g.clever_f_across_no_line = 1
  vim.g.clever_f_smart_case = 1
  vim.g.clever_f_smart_case = 1

  -- buftabline config
  vim.g.buftabline_numbers = 2
  vim.g.buftabline_show = 1

  layer_man.init_config()
end

return layer
