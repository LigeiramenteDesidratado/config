--- Language server protocol support, courtesy of Neovim
-- @module l.lsp

local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("neovim/nvim-lspconfig")
  plug.add_plugin("nvim-lua/completion-nvim")
  -- plug.add_plugin("nvim-treesitter/completion-treesitter")
  -- plug.add_plugin("m-pilia/vim-ccls")
end

local function user_stop_all_clients()
  local clients = vim.lsp.get_active_clients()

  if #clients > 0 then
    vim.lsp.stop_client(clients)
    for _, v in pairs(clients) do
      print("Stopped LSP client " .. v.name)
    end
  else
    print("No LSP clients are running")
  end
end

local function user_attach_client()
  local filetype = vim.bo[0].filetype

  local server = layer.filetype_servers[filetype]
  if server ~= nil then
    print("Attaching LSP client " .. server.name .. " to buffer")
    server.manager.try_add()
  else
    print("No LSP client registered for filetype " .. filetype)
  end
end

--- Configures vim and plugins for this layer
function layer.init_config()

  keybind.bind_function(edit_mode.NORMAL, "<leader>ls", user_stop_all_clients, nil)
  keybind.bind_function(edit_mode.NORMAL, "<leader>la", user_attach_client, nil)

  -- Default values for keybindings
  local opts = { noremap=true, silent=true }
  local opts_expr = { noremap=true, silent=true, expr=true }

  autocmd.bind_complete_done(function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      update_in_insert = false,
      signs = {
        priority = 20
      },
    }
  )

  -- Jumping to places
  autocmd.bind_filetype("*", function()
      local server = layer.filetype_servers[vim.bo.ft]
      if server ~= nil then

        keybind.buf_bind_command(edit_mode.NORMAL, "<leader>gd", ":lua vim.lsp.buf.declaration()<CR>", opts)
        keybind.buf_bind_command(edit_mode.NORMAL, "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
        keybind.buf_bind_command(edit_mode.NORMAL, "<leader>ge", ":lua vim.lsp.buf.definition()<CR>", opts)
        keybind.buf_bind_command(edit_mode.NORMAL, "<leader>d", ":lua vim.lsp.buf.hover()<CR>", opts)
      end
    end)

  keybind.bind_command(edit_mode.NORMAL, "<leader>gr", ":lua vim.lsp.buf.references()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>ld", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>e", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<C-[>", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<C-]>", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>,", ":noh<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>lo", ":messages<CR>", opts)
  keybind.bind_command(edit_mode.INSERT, "<C-c>", "<Esc>ci(i<bs>", opts)

  -- completion
  -- Changing Completion Confirm key
  vim.o.completeopt = "menuone,noinsert,noselect"
  vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
  vim.api.nvim_set_var("completion_enable_in_comemnt", 1)
  vim.api.nvim_set_var("completion_trigger_on_delete", 1)
  vim.g.completion_confirm_key = "<C-y>"

  keybind.bind_command(edit_mode.INSERT, "<C-j>", "pumvisible() ? '<C-n>' : '<Down>'", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-k>", "pumvisible() ? '<C-p>' : '<Up>'", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-l>", "pumvisible() ? '<C-y>' : '<Right>'", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-space>", "completion#trigger_completion()", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-h>", "<Left>", opts)

end

--- Maps filetypes to their server definitions
--
-- <br>
-- Eg: `["rust"] = nvim_lsp.rls`
--
-- <br>
-- See `nvim_lsp` for what a server definition looks like
layer.filetype_servers = {}

--- Register an LSP server
--
-- @param server An LSP server definition (in the format expected by `nvim_lsp`)
-- @param config The config for the server (in the format expected by `nvim_lsp`)
function layer.register_server(server, config)

  local completion = require("completion") -- From completion-nvim

  config = config or {}
  config.on_attach = completion.on_attach
  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  server.setup(config)

  for _, v in pairs(config.filetypes) do
    layer.filetype_servers[v] = server
  end
end

return layer
