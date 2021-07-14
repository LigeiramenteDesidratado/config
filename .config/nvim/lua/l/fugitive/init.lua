--- The styling layer
-- @module l.style

local layer = {}

local plug = require("c.plug")

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("tpope/vim-fugitive")
end

--- Configures vim and plugins for this layer
function layer.init_config()
end

return layer
