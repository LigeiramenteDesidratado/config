--- Keybind management
-- @module c.keybind

local keybind = {}

keybind._leader_info = {}

function keybind.register_plugins()
end

function keybind.post_init()
  -- Register the leader key info dict
  vim.g.c_keybind_leader_info = keybind._leader_info
end

--- Map a key sequence to a Vim command
--
-- @param mode An edit mode from `c.edit_mode`
-- @tparam string keys The keys to press (eg: `<leader>feR`)
-- @tparam string command The Vim command to bind to the key sequence (eg: `:source $MYVIMRC<CR>`)
-- @tparam table options See `https://neovim.io/doc/user/api.html#nvim_set_keymap()` (eg: `{ noremap = true }`)
function keybind.bind_command(mode, keys, command, options)
  options = options or {}

  vim.api.nvim_set_keymap(mode.map_prefix, keys, command, options)
end

--- Map a key sequence to a Vim command
--
-- @param mode An edit mode from `c.edit_mode`
-- @tparam string keys The keys to press (eg: `<leader>feR`)
-- @tparam string command The Vim command to bind to the key sequence (eg: `:source $MYVIMRC<CR>`)
-- @tparam table options See `https://neovim.io/doc/user/api.html#nvim_set_keymap()` (eg: `{ noremap = true }`)
function keybind.buf_bind_command(mode, keys, command, options)
  options = options or {}

  vim.api.nvim_buf_set_keymap(0, mode.map_prefix, keys, command, options)
end

keybind._bound_funcs = {}

--- Map a key sequence to a Lua function
--
-- @param mode An edit mode from `c.edit_mode`
-- @tparam string keys The keys to press (eg: `<leader>feR`)
-- @tparam function func The Lua function to bind to the key sequence
-- @tparam table options See `https://neovim.io/doc/user/api.html#nvim_set_keymap()` (eg: `{ noremap = true }`)
function keybind.bind_function(mode, keys, func, options)
  options = options or {}
  options.noremap = true

  local func_name = "bind_" .. mode.map_prefix .. "_" .. keys

  local func_name_escaped = func_name
  -- Escape Lua things
  func_name_escaped = func_name_escaped:gsub("'", "\\'")
  func_name_escaped = func_name_escaped:gsub('"', '\\"')
  func_name_escaped = func_name_escaped:gsub("\\[", "\\[")
  func_name_escaped = func_name_escaped:gsub("\\]", "\\]")

  -- Escape VimScript things
  -- We only escape `<` - I couldn't be bothered to deal with how <lt>/<gt> have angle brackets in themselves
  -- And this works well-enough anyways
  func_name_escaped = func_name_escaped:gsub("<", "<lt>")

  keybind._bound_funcs[func_name] = func

  local lua_command = ":lua require('c.keybind')._bound_funcs['" .. func_name_escaped .. "']()<CR>"
  -- Prefix with <C-o> if this is an insert-mode mapping
  if mode.map_prefix == "i" then
    lua_command = "<C-o>" .. lua_command
  end

  vim.api.nvim_set_keymap(mode.map_prefix, keys, lua_command, options)
end

return keybind
