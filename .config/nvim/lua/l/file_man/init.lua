--- File management
-- @module l.file_man

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}
-- local fzfbuf, fzfwin
local opts = { nowait = true, noremap = true, silent = true }

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("nvim-telescope/telescope.nvim")
  plug.add_plugin("nvim-lua/plenary.nvim")
  plug.add_plugin("nvim-lua/popup.nvim")
  plug.add_plugin("nvim-telescope/telescope-fzy-native.nvim")


  plug.add_plugin("vifm/vifm.vim")
  -- plug.add_plugin("junegunn/fzf.vim")
  -- plug.add_plugin('junegunn/fzf',
  --     { ['dir'] = '~/.fzf', ['do'] = './install --all' }
  --     )
end

-- Old fzf config
-- {{{
-- function layer.floating_FZF()
--   fzfbuf = vim.api.nvim_create_buf(false, true)

--   vim.api.nvim_buf_set_option(fzfbuf, 'bufhidden', 'wipe')
--   vim.api.nvim_buf_set_option(fzfbuf, 'filetype', 'whid')

--   local width = vim.api.nvim_get_option("columns")
--   local height = vim.api.nvim_get_option("lines")

--   local win_height = math.ceil(height * 0.8 - 4)
--   local win_width = width - 2
--   local row = math.ceil((height - win_height) / 2 - 1)
--   local col = math.ceil((width - win_width) / 2)

--   local win_opts = {
--     style = "minimal",
--     relative = "editor",
--     width = win_width,
--     height = win_height,
--     row = row,
--     col = col
--   }

--   fzfwin = vim.api.nvim_open_win(fzfbuf, true, win_opts)
--   vim.api.nvim_win_set_var(fzfwin, 'winhighlight', 'NormalFloat:Normal')
-- end
-- }}}

-- --- Configure vim and plugins for this layer
function layer.init_config()

    -- Old fzf config
-- {{{
--   local dopts = vim.env["FZF_DEFAULT_OPTS"] or ""
--   if not string.find(dopts, "--border") then
--     vim.env["FZF_DEFAULT_OPTS"] = dopts .. " --border"
--   end

--   vim.g.fzf_layout = { ['window'] = 'lua require"l/file_man".floating_FZF()' }
--   vim.g.fzf_colors = {
--     ['fg']         = { 'fg', 'Normal'},
--     ['bg']         = { 'bg', 'Normal'},
--     ['hl']         = { 'fg', 'Comment'},
--     ['fg+']        = { 'fg', 'CursorLine', 'CursorColumn', 'Normal'},
--     ['bg+']        = { 'bg', 'CursorLine', 'CursorColumn'},
--     ['hl+']        = { 'fg', 'Statement'},
--     ['info']       = { 'fg', 'PreProc'},
--     ['border']     = { 'fg', 'Label'},
--     ['prompt']     = { 'fg', 'Conditional'},
--     ['pointer']    = { 'fg', 'Exception'},
--     ['marker']     = { 'fg', 'Keyword'},
--     ['spinner']    = { 'fg', 'Label'},
--     ['header']     = { 'fg', 'Comment'}
--   }

--   keybind.bind_command(edit_mode.NORMAL, ",o", ":Files<CR>", opts )
--   keybind.bind_command(edit_mode.NORMAL, ",f", ":Rg<CR>", opts)
--   keybind.bind_command(edit_mode.NORMAL, ",a", ":Buffers<CR>", opts)
--   keybind.bind_command(edit_mode.NORMAL, ",m", ':History<CR>', opts)

--   vim.api.nvim_exec("command! -bang -nargs=* Rg"..
--     " call fzf#vim#grep("..
--     "'rg --column --line-number --no-heading --color=always --smart-case --no-ignore-vcs --no-ignore -S -g !.git -g !node_modules -g !go.mod -g !go.sum '.shellescape(<q-args>), 1,"..
--     "fzf#vim#with_preview({'options': ['--bind=alt-k:preview-up,alt-j:preview-down', '--info=inline', '--preview=\"ccat --color=always {}\"']}), <bang>0)", '')
-- }}}

  local opts = { noremap=true, silent=true }
  local builtin = require('telescope.builtin')
  keybind.bind_function(edit_mode.NORMAL, "<leader>o", builtin.find_files, opts)
  keybind.bind_function(edit_mode.NORMAL, "<leader>a", builtin.buffers, opts)
  keybind.bind_function(edit_mode.NORMAL, "<leader>m", builtin.oldFiles, opts)
  keybind.bind_function(edit_mode.NORMAL, "<leader>f", builtin.live_grep, opts)
  keybind.bind_function(edit_mode.NORMAL, "<leader>gs", builtin.git_status, opts)

  local telescope = require('telescope')

  telescope.load_extension('fzy_native')

  local sorters = require('telescope.sorters')
  local actions = require('telescope.actions')

  telescope.setup{
      defaults = {
          prompt_position = "bottom",
          prompt_prefix = ">",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          layout_strategy = "horizontal",
          layout_defaults = {
              -- TODO add builtin options.
          },
          file_sorter = sorters.get_fuzzy_file ,
          file_ignore_patterns = {},
          generic_sorter =  telescope.get_generic_fuzzy_sorter,
          shorten_path = true,
          winblend = 10,
          width = 0.75,
          preview_cutoff = 80,
          results_height = 1,
          results_width = 0.8,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},
          color_devicons = true,
          use_less = true,
          mappings = {
              i = {
                  ["<c-x>"] = actions.goto_file_selection_vsplit,
                  ["<c-o>"] = actions.goto_file_selection_tabedit,
                  ["<c-j>"] = actions.move_selection_next,
                  ["<c-k>"] = actions.move_selection_previous,
                  ["<c-l>"] = actions.goto_file_selection_edit,
                  ["<leader>w"] = actions.close,
              },
              n = {
                  ["<c-x>"] = actions.goto_file_selection_vsplit,
                  ["<A-j>"] = actions.preview_scrolling_down,
                  ["<A-k>"] = actions.preview_scrolling_up,
                  ["<c-j>"] = actions.move_selection_next,
                  ["<c-k>"] = actions.move_selection_previous,
                  ["<c-l>"] = actions.goto_file_selection_edit,
                  ["<leader>w"] = actions.close,
              },
          },
      }
  }

  -- keybind.bind_command(edit_mode.NORMAL, ",f", ":Rg<CR>", opts)
  -- keybind.bind_command(edit_mode.NORMAL, ",a", ":Buffers<CR>", opts)
  -- keybind.bind_command(edit_mode.NORMAL, ",m", ':History<CR>', opts)

end

return layer
