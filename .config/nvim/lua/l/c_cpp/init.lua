--- C/C++/Objective C layer
-- @module l.c_cpp

local layer = {}

local autocmd = require("c.autocmd")

--- Returns plugins required for this layer
function layer.register_plugins()
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  autocmd.bind("BufRead,BufNewFile *.h,*.c", function()
      vim.bo.filetype = "c.doxygen"
    end)

  vim.o.makeprg = "make"
  keybind.bind_command(edit_mode.NORMAL, "<F4>", ":make<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<F5>", ":!./x9-foi-torrado<CR>", opts)
  -- use tab instead of 4 spaces
  autocmd.bind("FileType make setlocal noexpandtab")

  lsp.register_server(nvim_lsp.ccls, {
            init_options = {
              ["cache"] = {["directory"] = "/tmp/ccls-cache"}
            }
    })
end

return layer
