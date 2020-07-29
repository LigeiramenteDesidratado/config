--- Web layer
-- @module l.web

local plug = require("c.plug")
local autocmd = require("c.autocmd")
local file = require("c.file")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}

local function on_filetype_web()
  vim.api.nvim_buf_set_option(0, "shiftwidth", 2)
  vim.api.nvim_buf_set_option(0, "tabstop", 2)
  vim.api.nvim_buf_set_option(0, "softtabstop", 4)

  keybind.bind_command(edit_mode.INSERT, "<tab>", "emmet#expandAbbrIntelligent('<tab>')", { expr = true })
end

local function activate_emmet()
  vim.cmd("EmmetInstall")
end

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("mattn/emmet-vim") -- Nifty completion stuffs
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local nvim_lsp = require("nvim_lsp")

  lsp.register_server(nvim_lsp.html)

  autocmd.bind_filetype("html", on_filetype_web)
  autocmd.bind_filetype("css", on_filetype_web)
  autocmd.bind_filetype("scss", on_filetype_web)
  autocmd.bind_filetype("javascript", on_filetype_web)
  autocmd.bind_filetype("html.handlebars", on_filetype_web)

  -- Emmet config
  vim.g.user_emmet_install_global = 0
  autocmd.bind_filetype("html", activate_emmet)
  autocmd.bind_filetype("css", activate_emmet)
  autocmd.bind_filetype("scss", activate_emmet)
  autocmd.bind_filetype("html.handlebars", activate_emmet)

  -- Ignore the black hole
  file.add_to_wildignore("node_modules")
end

return layer

