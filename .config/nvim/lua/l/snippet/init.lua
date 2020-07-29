--- Snippet layer
-- @module l.snippet

local plug = require("c.plug")

local layer = {}

--- Registers plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("SirVer/ultisnips")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- We change the default <Tab> keybind since that conflicts with tabbing to autocomplete
  -- e for expand
  vim.g.UltiSnipsExpandTrigger = "<C-e>"
end

return layer
