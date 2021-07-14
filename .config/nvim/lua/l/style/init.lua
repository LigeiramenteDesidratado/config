--- The styling layer
-- @module l.style

local layer = {}

local plug = require("c.plug")
local autocmd = require("c.autocmd")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local terminal = require("l.style.terminal")

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
  plug.add_plugin("voldikss/vim-floaterm") -- "scratchpad" terminal
  plug.add_plugin("thedenisnikulin/vim-cyberpunk") -- cyberpunk
  plug.add_plugin("sheerun/vim-polyglot") -- cyberpunk
  plug.add_plugin("tomasr/molokai") -- molokai
  plug.add_plugin("chrisbra/csv.vim") -- molokai

end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- Colors
  -- vim.o.termguicolors = true
  autocmd.bind_colorscheme(function()
    -- Diff highlights
    vim.cmd("highlight DiffAdd ctermfg=193 ctermbg=none guifg=#66CC6C guibg=none")
    vim.cmd("highlight DiffChange ctermfg=189 ctermbg=none guifg=#B166CC guibg=none")
    vim.cmd("highlight DiffDelete ctermfg=167 ctermbg=none guifg=#CC6666 guibg=none")
    vim.cmd("hi MatchWordCur cterm=underline gui=underline")
    vim.cmd("hi MatchParenCur cterm=underline gui=underline")
    vim.cmd("hi MatchWord cterm=underline gui=underline")

    vim.cmd("highlight DiffAdd ctermfg=193 ctermbg=none guifg=#66CC6C guibg=none")
    vim.cmd("highlight DiffChange ctermfg=189 ctermbg=none guifg=#B166CC guibg=none")
    vim.cmd("highlight DiffDelete ctermfg=167 ctermbg=none guifg=#CC6666 guibg=none")

    vim.cmd("highlight LspDiagnosticsUnderlineError guifg=#EB4917 gui=undercurl")
    vim.cmd("highlight LspDiagnosticsUnderlineWarning guifg=#EBA217 gui=undercurl")
    vim.cmd("highlight LspDiagnosticsUnderlineInformation guifg=#17D6EB, gui=undercurl")
    vim.cmd("highlight LspDiagnosticsUnderlineHint guifg=#17EB7A gui=undercurl")

    -- LSP highlights
    -- TODO: find appropriate ctermfg colors
    vim.cmd("highlight LspDiagnosticsDefaultError ctermfg=167 ctermbg=none guifg=#CC6666 guibg=none")
    vim.cmd("highlight LspDiagnosticsDefaultWarning ctermfg=167 ctermbg=none guifg=#CCA666 guibg=none")
    vim.cmd("highlight LspDiagnosticsDefaultInformation ctermfg=167 ctermbg=none guifg=#66A9CC guibg=none")
    vim.cmd("highlight LspDiagnosticsDefaultHint ctermfg=167 ctermbg=none guifg=#85CC66 guibg=none")
    -- remove annoying syntax error in C files
    vim.cmd("highlight link cErrinBracket Normal")
    vim.cmd("highlight link cErrInParen Normal")

    -- Statusline colors
    -- vim.cmd("highlight HLBracketsST ctermfg=14 ctermbg=234 guifg=#85dc85  guibg=#1c1c1c")
    vim.cmd("highlight HLBracketsST cterm=NONE ctermfg=249 ctermbg=235")
    -- vim.cmd("highlight HLTextST ctermfg=14 ctermbg=234 guifg=#eeeeee  guibg=#303030")
    vim.cmd("hi! link HLTextST Normal")

    -- vim.cmd("highlight BufTabLineCurrent ctermfg=167 ctermbg=none guifg=#85CC66 guibg=none")
    vim.cmd("highlight BufTabLineCurrent cterm=NONE ctermfg=249 ctermbg=235")

    -- vim.cmd("highlight BufTabLineActive ctermfg=167 ctermbg=none guifg=#428822 guibg=none")
    vim.cmd("highlight BufTabLineActive cterm=NONE ctermfg=249 ctermbg=16")

    -- vim.cmd("highlight BufTabLineFill ctermfg=167 ctermbg=none guifg=none guibg=none")
    vim.cmd("hi! link BufTabLineFill Normal")

    -- vim.cmd("highlight BufTabLineHidden ctermfg=167 ctermbg=none guifg=none guibg=none")
    vim.cmd("hi! BufTabLineHidden cterm=NONE ctermfg=239 ctermbg=16")

  end)

  -- vim.o.termguicolors = true;

  -- floaterm config
  vim.g.floaterm_position = 'center'
  vim.g.floaterm_keymap_toggle = '<leader>tt'
  vim.g.floaterm_background = '#121212'


  -- Shorten updatetime from the default 4000 for quicker CursorHold updates
  -- Used for stuff like the VCS gutter updates
  vim.o.updatetime = 750

  -- Allow hidden buffers
  vim.o.hidden = true

  -- Highlight the cursor line (insert mode only)
  autocmd.bind("InsertEnter,InsertLeave * ", function()
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
  set_default_win_opt("listchars", "tab:│ ,eol: ,trail:-,")

  autocmd.bind_colorscheme(function()
    vim.cmd("highlight CExtraWhitespace ctermfg=167 ctermbg=none guibg=#742B1F guifg=none")
    vim.cmd("highlight Normal guibg=233 ctermbg=233") -- bg color #121212
    vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE") -- Make sign column background transparent
  end)

  -- Statusline Modifications
  local statusline = "%#HLBracketsST#"
  statusline = statusline .. " [%#HLTextST#%f%#HLBracketsST#]"
  statusline = statusline .. " [%#HLTextST#%Y%#HLBracketsST#]"
  -- statusline = statusline .. " [%#ShowMarksHLl#%{Fugitivestatusline()}%#HLBracketsST#]"
  statusline = statusline .. " %m%r%h%w"
  statusline = statusline .. "%="
  statusline = statusline .. " [%#HLTextST#%{&fileencoding?&fileencoding:&encoding}%#HLBracketsST#]"
  statusline = statusline .. " [%#HLTextST#%{&fileformat}%#HLBracketsST#]"
  statusline = statusline .. " [ROW:%#HLTextST#%-3l%#HLBracketsST#]"
  statusline = statusline .. " [COL:%#HLTextST#%-2c%#HLBracketsST#]"
  statusline = statusline .. " [%#HLTextST#%-3p%#HLBracketsST#%%] "

  vim.o.statusline = statusline

  -- Scroll 12 lines/columns before the edges of a window
  vim.o.scrolloff = 12
  vim.o.sidescrolloff = 12

  -- Show partial commands in the bottom right
  vim.o.showcmd = true

  -- 200ms timeout before which-key kicks in
  vim.g.timeoutlen = 200

  -- Always show the sign column
  set_default_win_opt("signcolumn", "yes")

  vim.api.nvim_command("colorscheme molokai")

end

return layer
