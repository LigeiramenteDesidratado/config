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

  -- Colorscheme
  plug.add_plugin("tomasr/molokai")
  plug.add_plugin("aloussase/cyberunk")
  plug.add_plugin("bluz71/vim-moonfly-colors")
  -- plug.add_plugin("kristijanhusak/vim-hybrid-material")
  -- plug.add_plugin("morhetz/gruvbox")
  -- plug.add_plugin("artanikin/vim-synthwave84")
  plug.add_plugin("rockerBOO/boo-colorscheme-nvim")
  plug.add_plugin("tjdevries/colorbuddy.nvim")

  plug.add_plugin("norcalli/nvim-colorizer.lua")
  plug.add_plugin("danilamihailov/beacon.nvim")
  plug.add_plugin("voldikss/vim-floaterm") -- "scratchpad" terminal
  -- plug.add_plugin("jaxbot/semantic-highlight.vim")

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
    vim.cmd("highlight LspDiagnosticsError ctermfg=167 ctermbg=none guifg=#CC6666 guibg=none")
    vim.cmd("highlight LspDiagnosticsWarning ctermfg=167 ctermbg=none guifg=#CCA666 guibg=none")
    vim.cmd("highlight LspDiagnosticsInformation ctermfg=167 ctermbg=none guifg=#66A9CC guibg=none")
    vim.cmd("highlight LspDiagnosticsHint ctermfg=167 ctermbg=none guifg=#85CC66 guibg=none")
    -- TODO: LspReferenceText
    -- TODO: LspReferenceRead
    -- TODO: LspReferenceWrite
  end)

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
  set_default_win_opt("list", true)
  set_default_win_opt("listchars", "tab:│ ,eol: ,trail:·")

  autocmd.bind_colorscheme(function()
    vim.cmd("highlight CExtraWhitespace ctermfg=167 ctermbg=none guibg=#742B1F guifg=none")
    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE") -- Make background transparent
  end)

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

  -- Always show the sign column
  set_default_win_opt("signcolumn", "yes")

  -- Attaches to every FileType mode
  require'colorizer'.setup()

  -- Transparency on the popup menus/windows
  vim.o.pumblend = 10
  vim.o.winblend = 10

  -- Display obssesion in status line
  vim.g.moonflyWithObessionGeometricCharacters = 1
  vim.g.moonflyItalics = 1
  vim.api.nvim_command("colorscheme moonfly")
  -- require'boo-colorscheme'.use{}

  -- Change Beacon color
  vim.cmd("highlight Beacon guibg=white ctermbg=15")

end

return layer
