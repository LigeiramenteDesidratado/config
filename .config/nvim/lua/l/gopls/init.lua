--- Golang layer
-- @module l.gopls

local plug = require("c.plug")
local autocmd = require("c.autocmd")
local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
    -- Useful when dealing with grpc
    -- go get -u github.com/josharian/impl
    -- plug.add_plugin("rhysd/vim-go-impl")
    -- plug.add_plugin("buoto/gotests-vim")
end

-- local function on_filetype_go()

  -- vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
  -- vim.api.nvim_buf_set_option(0, "tabstop", 4)
  -- vim.api.nvim_buf_set_option(0, "softtabstop", 4)
  -- vim.api.nvim_buf_set_option(0, "expandtab", false)

-- end

-- Synchronously organise (Go) imports.
function go_organize_imports_sync(timeout_ms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result then return end
  result = result[1].result
  if not result then return end
  edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
end

--- Configures vim and plugins for this layer
function layer.init_config()

  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  -- autocmd.bind("BufNewFile,BufRead *.go", on_filetype_go)
  -- autocmd.bind("BufWritePre *.go", go_organize_imports_sync(1000))
  -- vim.api.nvim_command("au BufWritePre *.go lua go_organize_imports_sync(1000)")

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
