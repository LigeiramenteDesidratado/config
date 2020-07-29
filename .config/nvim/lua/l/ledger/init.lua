--- Ledger layer for personal finances
-- @module l.ledger

local plug = require("c.plug")

local layer = {}

--- Registers plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("ledger/vim-ledger")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  vim.g.ledger_maxwidth = 120
end

return layer
