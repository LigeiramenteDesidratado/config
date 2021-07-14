--- Language server protocol support, courtesy of Neovim
-- @module l.lsp

local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local autocmd = require("c.autocmd")
local plug = require("c.plug")

local layer = {}
local opts = { noremap=true, silent=true }
local opts_expr = { noremap=true, silent=true, expr=true }

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("neovim/nvim-lspconfig")
  plug.add_plugin("hrsh7th/nvim-compe")
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

  autocmd.bind_complete_done(function()
    if vim.fn.pumvisible() == 0 then
      vim.cmd("pclose")
    end
  end)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = false,

	  -- Enable underline, use default values
	  underline = true,
	  -- Enable virtual text, override spacing to 4
	  virtual_text = false,
	  -- virtual_text = {
		--   spacing = 1,
		--   prefix = '~',
	  -- },
	  -- Use a function to dynamically turn signs off
		  -- and on, using buffer local variables
		  signs = function(bufnr, client_id)
			  local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
			  -- No buffer local variable set, so just enable by default
			  if not ok then
				  return true
			  end

			  return result
		  end,
		  -- Disable a feature

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
        -- keybind.buf_bind_command(edit_mode.NORMAL, "<leader>d", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
		-- scroll down hover doc or scroll in definition preview
        -- keybind.buf_bind_command(edit_mode.NORMAL, "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)
		-- scroll up hover doc
		-- keybind.buf_bind_command(edit_mode.NORMAL, "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
      end
    end)

  keybind.bind_command(edit_mode.NORMAL, "<leader>gr", ":lua vim.lsp.buf.references()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
  -- nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
  -- keybind.bind_command(edit_mode.NORMAL, "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>ld", ":lua vim.lsp.buf.document_symbol()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>e", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<C-[>", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<C-]>", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  -- keybind.bind_command(edit_mode.NORMAL, "<C-[>", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
  -- keybind.bind_command(edit_mode.NORMAL, "<C-]>", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)

  keybind.bind_command(edit_mode.NORMAL, "<leader>,", ":noh<CR>", opts)
  keybind.bind_command(edit_mode.NORMAL, "<leader>lo", ":messages<CR>", opts)
  keybind.bind_command(edit_mode.INSERT, "<C-c>", "<Esc>ci(i<bs>", opts)

  -- vim.o.completeopt = "menuone,noinsert,noselect"
  vim.o.completeopt = "menu,menuone,noselect"

  keybind.bind_command(edit_mode.INSERT, "<C-j>", "pumvisible() ? '<C-n>' : '<Down>'", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-k>", "pumvisible() ? '<C-p>' : '<Up>'", opts_expr)
  -- till i figure out how to do it in lua
  -- keybind.bind_command(edit_mode.INSERT, "<C-l>", "pumvisible() ? '<C-y>' : '<Right>'", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-h>", "<Left>", opts)


  require'compe'.setup {
      enabled = true;
      autocomplete = false;
      debug = false;
      min_length = 1;
      preselect = 'enable';
      throttle_time = 80;
      source_timeout = 200;
      incomplete_delay = 400;
      max_abbr_width = 40;
      max_kind_width = 30;
      max_menu_width = 30;
      documentation = true;

      source = {
          path = true;
          buffer = false;
          calc = true;
          vsnip = false;
          nvim_lsp = true;
          nvim_lua = true;
          spell = false;
          tags = false;
          snippets_nvim = true;
          treesitter = true;
      };
  }

  keybind.bind_command(edit_mode.INSERT, "<C-Space>", "compe#complete()", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-l>", "pumvisible() ? compe#confirm('<C-l>') : '<Right>'", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-e>", "compe#close('<C-e>')", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-f>", "compe#scroll({ 'delta': +4 })", opts_expr)
  keybind.bind_command(edit_mode.INSERT, "<C-d>", "compe#scroll({ 'delta': -4 })", opts_expr)

end


local on_attach = function(client, bufnr)
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    keybind.bind_command(edit_mode.NORMAL, "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    keybind.bind_command(edit_mode.NORMAL, "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
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
  config.on_attach = on_attach
  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  server.setup(config)

  for _, v in pairs(config.filetypes) do
    layer.filetype_servers[v] = server
  end
end

return layer
