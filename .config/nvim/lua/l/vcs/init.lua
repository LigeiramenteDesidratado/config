--- The version control layer
-- @module l.vcs

local layer = {}

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("mhinz/vim-signify") -- VCS diffs in the gutter
end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- Signify config - use a nice little colored line for add/changes
  vim.g.signify_sign_add = "▏"
  vim.g.signify_sign_change = "▏"
  keybind.bind_command(edit_mode.NORMAL, "gs", ":SignifyHunkDiff<CR>", { noremap = true })

end

return layer
