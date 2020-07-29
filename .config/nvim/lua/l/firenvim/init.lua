--- Filenvim support, for nvim in the browser!
-- @module l.firenvim

local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  -- TODO: Not sure if this is right?
  plug.add_plugin("glacambre/firenvim", { ["do"] = "call firenvim#install(0)" })
end

--- Configures vim and plugins for this layer
function layer.init_config()
end

return layer

