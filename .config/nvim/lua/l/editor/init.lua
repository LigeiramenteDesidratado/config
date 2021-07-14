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

local function set_spell()
  vim.api.nvim_win_set_option(0, "spell", true)
  vim.api.nvim_buf_set_option(0, "spelllang", "en_us,pt_br")
end

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("machakann/vim-sandwich") -- Awesome for dealing with surrounding things, like parens
  plug.add_plugin("windwp/nvim-autopairs") -- Auto insert matching parens/quotes/stuff
  plug.add_plugin("tomtom/tcomment_vim") -- Commenting
  plug.add_plugin("bronson/vim-trailing-whitespace") -- Remove trailing whitespace
  plug.add_plugin("rhysd/clever-f.vim") -- Find a character with convenience
  plug.add_plugin("andymass/vim-matchup")
  plug.add_plugin("AndrewRadev/splitjoin.vim")
  plug.add_plugin("ap/vim-buftabline")
  plug.add_plugin("gfanto/fzf-lsp.nvim")
  plug.add_plugin("ray-x/lsp_signature.nvim")

end

--- Configures vim and plugins for this layer
function layer.init_config()

  require'fzf_lsp'.setup()

  vim.g.vue_pre_processors = {}

  -- Space for leader, backslash for local leader
  vim.g.mapleader = ","

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

  -- Enable mouse support
  vim.o.mouse = "a"
  vim.o.mousemodel='popup'


  -- Default values for keybindings
  local opts = { noremap=true, silent=true }

  -- Use `fd` to exit insert/visual/select/terminal mode
  keybind.bind_command(edit_mode.INSERT, "jk", "<Esc>:FixWhitespace<CR>", opts)
  keybind.bind_command(edit_mode.INSERT, "kj", "<Esc>:FixWhitespace<CR>", opts)
  keybind.bind_command(edit_mode.VISUAL_SELECT, "fd", "<esc>", opts)
  -- keybind.bind_command(edit_mode.NORMAL, "<leader>tt", ":lua require('lspsaga.floaterm').open_float_terminal() <CR>", opts)
  -- keybind.bind_command(edit_mode.TERMINAL, "<leader>tt", "<C-\\><C-n>:lua require('lspsaga.floaterm').close_float_terminal() <CR>", opts)

  keybind.bind_command(edit_mode.TERMINAL, "jk", "<C-\\><C-n>", opts)
  -- keybind.bind_command(edit_mode.TERMINAL, "<C-w>k", "<C-\\><C-n><C-w>k", opts)
  -- keybind.bind_command(edit_mode.TERMINAL, "<C-w>j", "<C-\\><C-n><C-w>j", opts)
  -- keybind.bind_command(edit_mode.TERMINAL, "<C-w>l", "<C-\\><C-n><C-w>l", opts)
  -- keybind.bind_command(edit_mode.TERMINAL, "<C-w>h", "<C-\\><C-n><C-w>h", opts)

  -- Autosave buffers before leaving them
  -- autocmd.bind("BufLeave *", function()
  --     vim.cmd(":wa")
  --   end)

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
  keybind.bind_command(edit_mode.VISUAL_SELECT, "p", '"_dP', opts)
  keybind.bind_command(edit_mode.VISUAL_SELECT, "P", '"_dP', opts)

  -- Switch CWD to the directory of the open buffer
  keybind.bind_command(edit_mode.NORMAL, "<leader>cd", ": cd %:p:h<cr>:pwd<cr>", { noremap=true })

  -- code action
  -- keybind.bind_command(edit_mode.NORMAL, "<leader>ca", ":lua require('lspsaga.codeaction').code_action()<cr>", { noremap=true })
  -- nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>


  -- Default indentation rules
  vim.o.tabstop = 2
  vim.o.softtabstop = 0
  vim.o.expandtab = true
  vim.o.shiftwidth = 2
  vim.cmd("set smarttab")

  vim.o.fileformats="unix,dos,mac"

  -- Copy/Paste/Cut
  vim.o.clipboard = "unnamed,unnamedplus"
  vim.o.guicursor = ""

  -- A shortcut command for :lua print(vim.inspect(...)) (:Li for Lua Inspect)
  vim.api.nvim_command("command! -nargs=+ Li :lua print(vim.inspect(<args>))")

  -- Use triple braces for folding
  set_default_win_opt("foldmethod", "marker")

  -- Show file name and path on dwm's bar
  vim.o.title = true

  -- clever-f config
  vim.g.clever_f_across_no_line = 1
  vim.g.clever_f_smart_case = 1
  vim.g.clever_f_smart_case = 1

  -- vim-matchup
  vim.g.matchup_matchparen_offscreen = {['method']= 'popup'}

  -- buftabline config
  vim.g.buftabline_numbers = 2
  vim.g.buftabline_show = 1

  autocmd.bind_filetype("tex,markdown", set_spell)
  keybind.bind_command(edit_mode.INSERT, "<C-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u", { noremap=true })
  autocmd.bind_colorscheme(function()
    vim.cmd("highlight SpellBad ctermfg=131 ctermbg=none guifg=#af5f5f guibg=none")
    vim.cmd("highlight Conceal ctermfg=117 ctermbg=none guifg=#87d7ff guibg=none")
  end)

  local remap = vim.api.nvim_set_keymap
  local npairs = require('nvim-autopairs')

  local opts_expr = { noremap=true, silent=true, expr=true }
  -- skip it, if you use another global object
  _G.MUtils= {}
  vim.g.completion_confirm_key = ""
  MUtils.completion_confirm=function()
      if vim.fn.pumvisible() ~= 0  then
          if vim.fn.complete_info()["selected"] ~= -1 then
              vim.fn["compe#confirm"]()
              return npairs.esc("<c-y>")
          else
              vim.defer_fn(function()
                  vim.fn["compe#confirm"]("<cr>")
              end, 20)
          return npairs.esc("<c-n>")
      end
  else
      return npairs.check_break_line_char()
  end
  end

  keybind.bind_command(edit_mode.INSERT, '<CR>','v:lua.MUtils.completion_confirm()', opts_expr)

  cfg = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

    hint_enable = false, -- virtual hint enable
    hint_prefix = "",  -- Panda for parameter
    hint_scheme = "String",
    use_lspsaga = false,  -- set to true if you want to use lspsaga popup
    handler_opts = {
      border = "none"   -- double, single, shadow, none
    },
    decorator = {"`", "`"}  -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help

  }
  require'lsp_signature'.on_attach(cfg)


  npairs.setup()

  -- local saga = require 'lspsaga'
  -- saga.init_lsp_saga()

  -- Define lexima rule to latex filetype
  -- vim.fn["lexima#add_rule"]({["char"] = '$', ["input"] = '$ ', ["input_after"] = ' $', ["filetype"] = {'latex', 'tex'}})
  -- vim.fn["lexima#add_rule"]({["char"] = '2$', ["input"] = '$$ ', ["input_after"] = ' $$', ["filetype"] = {'latex', 'tex'}})

  layer_man.init_config()
end

return layer
