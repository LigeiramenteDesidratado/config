--- Language server protocol support, courtesy of Neovim
-- @module l.lsp

local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("neovim/nvim-lsp")
  plug.add_plugin("haorenW1025/completion-nvim")
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

-- --- Get the LSP status line part for vim-airline
-- function layer._get_airline_part()
--   local clients = vim.lsp.buf_get_clients()
--   local client_names = {}
--   for _, v in pairs(clients) do
--     table.insert(client_names, v.name)
--   end

--   if #client_names > 0 then
--     local sections = { "LSP:", table.concat(client_names, ", ") }

--     local error_count = vim.lsp.util.buf_diagnostics_count("Error")
--     if error_count ~= nil and error_count > 0 then table.insert(sections, "E: " .. error_count) end

--     local warn_count = vim.lsp.util.buf_diagnostics_count("Warning")
--     if error_count ~= nil and warn_count > 0 then table.insert(sections, "W: " .. warn_count) end

--     local info_count = vim.lsp.util.buf_diagnostics_count("Information")
--     if error_count ~= nil and info_count > 0 then table.insert(sections, "I: " .. info_count) end

--     local hint_count = vim.lsp.util.buf_diagnostics_count("Hint")
--     if error_count ~= nil and hint_count > 0 then table.insert(sections, "H: " .. hint_count) end

--     return table.concat(sections, " ")
--   else
--     return ""
--   end
-- end

--- Configures vim and plugins for this layer
function layer.init_config()
  vim.api.nvim_set_var("completion_enable_in_comemnt", 1)

  vim.o.completeopt = "menuone,noinsert,noselect"
  -- TODO: Fix this?
  if plug.has_plugin("ultisnips") then
    vim.g.completion_enable_snippet = "UltiSnips"
  end
  vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
  -- Bind leader keys
  keybind.set_group_name("<leader>l", "LSP")
  keybind.bind_function(edit_mode.NORMAL, "<leader>ls", user_stop_all_clients, nil, "Stop all LSP clients")
  keybind.bind_function(edit_mode.NORMAL, "<leader>la", user_attach_client, nil, "Attach LSP client to buffer")

  -- Tabbing
  keybind.bind_command(edit_mode.INSERT, "<C-j>", "pumvisible() ? '<C-n>' : '<Down>'", { noremap = true, expr = true })
  keybind.bind_command(edit_mode.INSERT, "<C-k>", "pumvisible() ? '<C-p>' : '<Up>'", { noremap = true, expr = true })
-- inoremap <expr><C-l> pumvisible() ? "\<C-y>" : "<Right>"
  keybind.bind_command(edit_mode.INSERT, "<C-l>", "pumvisible() ? '<C-y>' : '<Right>'", { noremap = true, expr = true })
  keybind.bind_command(edit_mode.INSERT, "<C-space>", "completion#trigger_completion()", { noremap = true, expr = true, silent = true })
  keybind.bind_command(edit_mode.INSERT, "<C-h>", "<Left>", { noremap = true })
  keybind.bind_command(edit_mode.INSERT, "<C-i>", "<Esc>ci(i<bs>", { noremap = true })
  autocmd.bind_complete_done(function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end)


  -- Default values for keybindings
  local opts = { noremap=true, silent=true }

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

  keybind.bind_command(edit_mode.NORMAL, "<leader>gr", ":lua vim.lsp.buf.references()<CR>", opts, "Find references")
  keybind.bind_command(edit_mode.NORMAL, "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts, "Rename")
  keybind.bind_command(edit_mode.NORMAL, "<leader>ld", ":lua vim.lsp.buf.document_symbol()<CR>", opts, "Document symbol list")

  keybind.bind_command(edit_mode.NORMAL, "<leader>,", ":noh<CR>", opts, "Document symbol list")

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
