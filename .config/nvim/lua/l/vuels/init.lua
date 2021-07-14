--- vuels layer
-- @module l.vuels

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  lsp.register_server(nvim_lsp.vuels, {
        vetur = {
          format = {
            enable = true,
            defaultFormatter = {
              js = "prettier",
              ts = "prettier",
              css = "prettier",
              html = "prettier"
            },
          },
        },
    })

end

return layer

