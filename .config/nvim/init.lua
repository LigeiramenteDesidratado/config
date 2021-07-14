local reload = require("c.reload")
reload.unload_user_modules()

local log = require("c.log")
log.init()

local layer = require("c.layer")
local keybind = require("c.keybind")
local autocmd = require("c.autocmd")

keybind.register_plugins()
autocmd.init()

layer.add_layer("l.editor")
layer.add_layer("l.style")
layer.add_layer("l.file_man")
layer.add_layer("l.vcs")
layer.add_layer("l.lsp")
layer.add_layer("l.rust")
-- layer.add_layer("l.lua")
layer.add_layer("l.c_cpp")
layer.add_layer("l.line_juggler")
layer.add_layer("l.typescript")
layer.add_layer("l.gopls")
-- layer.add_layer("l.vuels")
layer.add_layer("l.vls")
layer.add_layer("l.gdscript")
layer.add_layer("l.notes")
layer.add_layer("l.fugitive")
layer.add_layer("l.TeX")
-- layer.add_layer("l.treesitter")
layer.add_layer("l.snippet")
-- layer.add_layer("l.build")
-- layer.add_layer("l.python")
layer.add_layer("l.web")
layer.finish_layer_registration()

keybind.post_init()
