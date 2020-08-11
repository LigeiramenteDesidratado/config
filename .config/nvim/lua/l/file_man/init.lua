--- File management
-- @module l.file_man

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}
local fzfbuf, fzfwin
local opts = { nowait = true, noremap = true, silent = true }

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("junegunn/fzf.vim")
  plug.add_plugin("vifm/vifm.vim")
  plug.add_plugin('junegunn/fzf',
      { ['dir'] = '~/.fzf', ['do'] = './install --all' }
      )
end

function layer.floating_FZF()
  fzfbuf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_option(fzfbuf, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(fzfbuf, 'filetype', 'whid')

  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = width - 2
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }

  fzfwin = vim.api.nvim_open_win(fzfbuf, true, win_opts)
  vim.api.nvim_win_set_var(fzfwin, 'winhighlight', 'NormalFloat:Normal')
end

--- Configures vim and plugins for this layer
function layer.init_config()

  local dopts = vim.env["FZF_DEFAULT_OPTS"] or ""
  if not string.find(dopts, "--border") then
    vim.env["FZF_DEFAULT_OPTS"] = dopts .. " --border"
  end

  vim.g.fzf_layout = { ['window'] = 'lua require"l/file_man".floating_FZF()' }
  vim.g.fzf_colors = {
    ['fg']         = { 'fg', 'Normal'},
    ['bg']         = { 'bg', 'Normal'},
    ['hl']         = { 'fg', 'Comment'},
    ['fg+']        = { 'fg', 'CursorLine', 'CursorColumn', 'Normal'},
    ['bg+']        = { 'bg', 'CursorLine', 'CursorColumn'},
    ['hl+']        = { 'fg', 'Statement'},
    ['info']       = { 'fg', 'PreProc'},
    ['border']     = { 'fg', 'Label'},
    ['prompt']     = { 'fg', 'Conditional'},
    ['pointer']    = { 'fg', 'Exception'},
    ['marker']     = { 'fg', 'Keyword'},
    ['spinner']    = { 'fg', 'Label'},
    ['header']     = { 'fg', 'Comment'}
  }

  keybind.bind_command(edit_mode.NORMAL, ",o", ":Files<CR>", opts )
  keybind.bind_command(edit_mode.NORMAL, ",f", ":Rg<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, ",a", ":Buffers<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, ",m", ':History<CR>', opts)

  vim.api.nvim_exec("command! -bang -nargs=* Rg"..
    " call fzf#vim#grep("..
    "'rg --column --line-number --no-heading --color=always --smart-case --no-ignore-vcs --no-ignore -S -g !.git -g !node_modules -g !go.mod -g !go.sum '.shellescape(<q-args>), 1,"..
    "fzf#vim#with_preview({'options': ['--bind=alt-k:preview-up,alt-j:preview-down', '--info=inline', '--preview=\"ccat --color=always {}\"']}), <bang>0)", '')

end

return layer
