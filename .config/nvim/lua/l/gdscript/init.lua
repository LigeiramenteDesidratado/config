--- Gdscript layer
-- @module l.gdscript

local file = require("c.file")
local autocmd = require("c.autocmd")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  autocmd.bind("BufRead,BufNewFile *.gd", function()
    vim.bo.filetype = "gd"
  end)

  lsp.register_server(nvim_lsp.gdscript, {})

end

return layer
