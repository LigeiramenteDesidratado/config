--- The styling layer
-- @module l.style

local layer = {}

local plug = require("c.plug")
local autocmd = require("c.autocmd")

-- The startup window doesn't seem to pick up on vim.o changes >.<
local function set_default_win_opt(name, value)
  vim.o[name] = value
  autocmd.bind_vim_enter(function()
    vim.wo[name] = value
  end)
end

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("kristijanhusak/vim-hybrid-material") -- Colorscheme
  plug.add_plugin("morhetz/gruvbox")
  plug.add_plugin("artanikin/vim-synthwave84")
  plug.add_plugin("tomasr/molokai")
  plug.add_plugin("aloussase/cyberunk")
  plug.add_plugin("bluz71/vim-moonfly-colors")
  plug.add_plugin("nvim-treesitter/nvim-treesitter")
  plug.add_plugin("voldikss/vim-floaterm") -- "scratchpad" terminal
  -- plug.add_plugin("bluz71/vim-moonfly-statusline")
  -- plug.add_plugin("https://gitlab.com/CraftedCart/vim-indent-guides") -- Indent guides
  -- plug.add_plugin("danilamihailov/beacon.nvim") -- "scratchpad" terminal
end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- Colors
  vim.o.termguicolors = true
  autocmd.bind_colorscheme(function()
    -- Diff highlights
    vim.cmd("highlight DiffAdd ctermfg=193 ctermbg=none guifg=#66CC6C guibg=none")
    vim.cmd("highlight DiffChange ctermfg=189 ctermbg=none guifg=#B166CC guibg=none")
    vim.cmd("highlight DiffDelete ctermfg=167 ctermbg=none guifg=#CC6666 guibg=none")

    -- LSP highlights
    -- TODO: find appropriate ctermfg colors
    vim.cmd("highlight LspDiagnosticsError ctermfg=167 ctermbg=none guifg=#EB4917 guibg=none")
    vim.cmd("highlight LspDiagnosticsWarning ctermfg=167 ctermbg=none guifg=#EBA217 guibg=none")
    vim.cmd("highlight LspDiagnosticsInformation ctermfg=167 ctermbg=none guifg=#17D6EB guibg=none")
    vim.cmd("highlight LspDiagnosticsHint ctermfg=167 ctermbg=none guifg=#17EB7A guibg=none")
    -- TODO: LspReferenceText
    -- TODO: LspReferenceRead
    -- TODO: LspReferenceWrite

  end)

  -- Display obssesion in status line
  vim.g.moonflyWithObessionGeometricCharacters = 1

  vim.api.nvim_command("colorscheme moonfly")
  vim.g.gruvbox_italic = 1
  vim.g.gruvbox_contrast_dark = 'soft'

  -- floaterm config
  vim.g.floaterm_position = 'center'
  vim.g.floaterm_keymap_toggle = ',s'
  vim.g.floaterm_keymap_new = ',t'
  vim.g.floaterm_keymap_next = ',n'
  vim.g.floaterm_winblend = 10
  vim.g.floaterm_background = '#121212'


  -- Shorten updatetime from the default 4000 for quicker CursorHold updates
  -- Used for stuff like the VCS gutter updates
  vim.o.updatetime = 750

  -- Allow hidden buffers
  vim.o.hidden = true

  -- Line numbers and relative line numbers
  -- set_default_win_opt("number", true)
  -- set_default_win_opt("relativenumber", true)

  -- Highlight the cursor line (insert mode only)
  autocmd.bind("InsertEnter,InsertLeave *", function()
    vim.cmd("set cul!")
  end)

  -- Incremental search and incremental find/replace
  vim.o.incsearch = true
  vim.o.inccommand = "nosplit"

  -- Better display for messages
  vim.o.cmdheight = 2

  -- Use case-insensitive search if the entire search query is lowercase
  vim.o.ignorecase = true

  -- Shows the effects of a command incrementally, as you type.
  vim.o.smartcase = true

  -- Highlight while searching
  vim.o.hlsearch = true

  -- Faster redrawing
  vim.o.lazyredraw = true

  -- Open splits on the right
  vim.o.splitright = true

  -- Fix backspace indent
  vim.o.backspace = "indent,eol,start"

  -- Show tabs and trailing whitespace
  -- set_default_win_opt("list", true)
  -- set_default_win_opt("listchars", "tab:│ ,eol: ,trail:·")
  -- Statusline Modifications
  local statusline = "%#Folded#"
  statusline = statusline .. " [%#ShowMarksHLl#%t%#Folded#]"
  statusline = statusline .. " [%#ShowMarksHLl#%Y%#Folded#]"
  -- statusline = statusline .. " [%#ShowMarksHLl#%{Fugitivestatusline()}%#Folded#]"
  statusline = statusline .. " %m%r%h%w"
  statusline = statusline .. "%="
  statusline = statusline .. " [%#ShowMarksHLl#%{&fileencoding?&fileencoding:&encoding}%#Folded#]"
  statusline = statusline .. " [%#ShowMarksHLl#%{&fileformat}%#Folded#]"
  statusline = statusline .. " [ROW:%#ShowMarksHLl#%-3l%#Folded#]"
  statusline = statusline .. " [COL:%#ShowMarksHLl#%-2c%#Folded#]"
  statusline = statusline .. " [%#ShowMarksHLl#%-3p%#Folded#%%] "

  vim.o.statusline = statusline

  -- Scroll 12 lines/columns before the edges of a window
  vim.o.scrolloff = 12
  vim.o.sidescrolloff = 12

  -- Show partial commands in the bottom right
  vim.o.showcmd = true

  -- Enable mouse support
  vim.o.mouse = "a"

  -- 200ms timeout before which-key kicks in
  vim.g.timeoutlen = 200

  -- Reposition the which-key float slightly
  vim.g.which_key_floating_opts = { row = 1, col = -3, width = 3 }

  -- Always show the sign column
  set_default_win_opt("signcolumn", "yes")

  vim.g.indent_guides_exclude_noft = 1
  vim.g.indent_guides_default_mapping = 0
  autocmd.bind("VimEnter,Colorscheme *", function()
    vim.cmd("hi IndentGuidesEven ctermbg=0 guibg=#2E3032")
    vim.cmd("hi IndentGuidesOdd ctermbg=0 guibg=#2E3032")
  end)

  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",     -- one of "all", "language", or a list of languages
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
    indent = {
      enable = true
    },
  }

  -- Transparency on the popup menus/windows
  vim.o.pumblend = 10
  vim.o.winblend = 10

end

return layer
