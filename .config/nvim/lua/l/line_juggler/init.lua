--- LineJugglerlayer
-- @module l.line_juggler

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("inkarkat/vim-ingo-library")
  plug.add_plugin("inkarkat/vim-LineJuggler")
  plug.add_plugin("matze/vim-move")
end

--- Configures vim and plugins for this layer
function layer.init_config()

    -- " LineJuggler
    keybind.bind_command(edit_mode.VISUAL_SELECT, "<S-h>", "<plug>(LineJugglerDupRangeUp)", { noremap = false })
    keybind.bind_command(edit_mode.VISUAL_SELECT, "<S-l>", "<Plug>(LineJugglerDupRangeDown)", { noremap = false })
    keybind.bind_command(edit_mode.NORMAL, "<A-k>", "<Plug>(LineJugglerBlankUp)", { noremap = false })
    keybind.bind_command(edit_mode.NORMAL, "<A-j>", "<Plug>(LineJugglerBlankDown)", { noremap = false })
    keybind.bind_command(edit_mode.VISUAL_SELECT, "<A-k>", "<Plug>(LineJugglerBlankUp)", { noremap = false })
    keybind.bind_command(edit_mode.VISUAL_SELECT, "<A-j>", "<Plug>(LineJugglerBlankDown)", { noremap = false })

    -- Use Ctrl as modifier key
    vim.g.move_key_modifier = 'C'

end

return layer
