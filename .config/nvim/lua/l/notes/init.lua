--- Notes
-- @module l.notes

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("godlygeek/tabular") -- Line up text
  plug.add_plugin("plasticboy/vim-markdown")

  plug.add_plugin("alok/notational-fzf-vim")
  plug.add_plugin('junegunn/fzf',
      { ['dir'] = '~/.fzf', ['do'] = './install --all' }
      )
end

--- Configures vim and plugins for this layer
function layer.init_config()

  vim.g.nv_use_ignore_files = 0

  -- Define my note location
  vim.g.nv_search_paths = {'~/Notes/Notes'}
  keybind.bind_command(edit_mode.NORMAL, "<leader>.", ":NV<CR>", { noremap = true, silent = true })

  -- Use filetype name as fenced code block languages for syntax highlighting
  vim.g.markdown_fenced_languages = {'go=go', 'coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml'}

  -- Disable annoying folding
  vim.g.vim_markdown_folding_disabled = 1

  -- enable LaTeX math
  -- vim.g.vim_markdown_math = 1
end

return layer
