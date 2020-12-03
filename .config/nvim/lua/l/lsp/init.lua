--- Language server protocol support, courtesy of Neovim
-- @module l.lsp

local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("neovim/nvim-lspconfig")
  plug.add_plugin("m-pilia/vim-ccls")
  plug.add_plugin("nvim-lua/completion-nvim")
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
  vim.api.nvim_set_var("completion_enable_in_comemnt", 1)

  vim.o.completeopt = "menuone,noinsert,noselect"

  vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

  keybind.bind_function(edit_mode.NORMAL, "<leader>ls", user_stop_all_clients, nil)
  keybind.bind_function(edit_mode.NORMAL, "<leader>la", user_attach_client, nil)

  -- Tabbing
  keybind.bind_command(edit_mode.INSERT, "<C-j>", "pumvisible() ? '<C-n>' : '<Down>'", { noremap = true, expr = true })
  keybind.bind_command(edit_mode.INSERT, "<C-k>", "pumvisible() ? '<C-p>' : '<Up>'", { noremap = true, expr = true })
-- inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "<Right>"
  keybind.bind_command(edit_mode.INSERT, "<C-l>", "pumvisible() ? '<C-y>' : '<Right>'", { noremap = true, expr = true })
  keybind.bind_command(edit_mode.INSERT, "<C-space>", "completion#trigger_completion()", { noremap = true, expr = true, silent = true })
  keybind.bind_command(edit_mode.INSERT, "<C-h>", "<Left>", { noremap = true })
  keybind.bind_command(edit_mode.INSERT, "<C-c>", "<Esc>ci(i<bs>", { noremap = true })
  -- autocmd.bind_complete_done(function()
  --   if vim.fn.pumvisible() == 0 then
  --     vim.cmd("pclose")
  --   end
  -- end)
    -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    --     vim.lsp.diagnostic.on_publish_diagnostics, {
    --         underline = true,
    --         virtual_text = false,
    --         signs = {
    --             priority = 20
    --         },
    --     }
    -- )

  -- Default values for keybindings
  local opts = { noremap=true, silent=true }
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

  keybind.bind_command(edit_mode.NORMAL, "<leader>gd", ":lua vim.lsp.buf.declaration()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>ge", ":lua vim.lsp.buf.definition()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>d", ":lua vim.lsp.buf.hover()<CR>", opts)

  keybind.bind_command(edit_mode.NORMAL, "<leader>gr", ":lua vim.lsp.buf.references()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>ld", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>e", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<C-[>", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<C-]>", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  keybind.bind_command(edit_mode.NORMAL, "<leader>,", ":noh<CR>", opts)

  -- Changing Completion Confirm key
  vim.g.completion_confirm_key = "<C-y>"

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

  config = config or {}

  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  if not config.on_attach then
    config.on_attach = require'completion'.on_attach -- From completion-nvim
  end

  server.setup(config)

  for _, v in pairs(config.filetypes) do
    layer.filetype_servers[v] = server
  end
end

return layer
