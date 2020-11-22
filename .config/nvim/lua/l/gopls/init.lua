--- Golang layer
-- @module l.gopls

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
end

--- Configures vim and plugins for this layer
function layer.init_config()

  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  lsp.register_server(nvim_lsp.gopls, {
      init_options = {
        ["completeUnimported" ]     = true,
        ["linkTarget"]              = "",
        ["completionDocumentation"] = true,
        ["deepCompletion"]          = true,
        ["staticcheck"]             = true,
      },
    }
  )

end

return layer
