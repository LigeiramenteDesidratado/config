-- @module l.TeX

local layer = {}

local plug = require("c.plug")

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("lervag/vimtex")
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local nvim_lsp = require("lspconfig")

  -- vim.g.completion_chain_complete_list = {
  --   ["tex"] = {
  --     {["complete_items"] = {"lsp", "vimtex"}},
  --   }
  -- }

  -- require'completion'.addCompletionSource('vimtex', layer.complete_item)

  vim.g.vimtex_view_method = 'zathura'
  vim.g.tex_flavor = 'latex'
  vim.g.vimtex_quickfix_mode = 0

  -- This is a feature where LaTeX code is replaced or made invisible when your cursor is not on that line
  -- I don't know why using meta-accessors doesn't work
  -- vim.o.conceallevel=2
  vim.cmd("set conceallevel=2")
  vim.g.tex_conceal = 'abdmg'

  lsp.register_server(nvim_lsp.texlab)
end

-- function layer.get_completion_items(prefix)

--   local item = vim.api.nvim_call_function('vimtex#complete#omnifunc',{0, prefix})

--   return item
-- end

-- layer.complete_item = {
--   item = layer.get_completion_items
-- }


return layer
