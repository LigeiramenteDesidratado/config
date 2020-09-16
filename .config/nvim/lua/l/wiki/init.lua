--- Wiki layer
-- @module l.wiki

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")
local file = require("c.file")

local layer = {}

--- Registers plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("vimwiki/vimwiki")
end

local function user_new_scratchpad()
  local scratchpad_name = vim.fn.input("Scratchpad name: ")

  local wiki_path = vim.g.vimwiki_list[1].path:gsub("~", file.get_home_dir())
  local scratchpad_exists = file.is_readable(wiki_path .. "/scratchpad/" .. scratchpad_name .. ".wiki")

  if not scratchpad_exists then
    -- Open up the wiki index, find the = Scratchpads = heading, and add a new entry under it
    vim.cmd("VimwikiIndex")
    local heading_line = vim.fn.search("^= Scratchpads =$")
    if heading_line == 0 then -- Check if the heading doesn't exist, and create it if so
      local num_lines = vim.api.nvim_buf_line_count(0)
      vim.api.nvim_buf_set_lines(0, num_lines, num_lines, true, {"", "= Scratchpads ="})
      heading_line = num_lines + 2
    end

    -- Add a link under the heading
    vim.api.nvim_buf_set_lines(0, heading_line, heading_line, true, {"    - [[scratchpad/" .. scratchpad_name .. "]]"})

    -- Save the updated index
    vim.cmd("write")
  end

  -- Open our new scratchpad
  vim.cmd("VimwikiGoto scratchpad/" .. scratchpad_name)
end

--- Configures vim and plugins for this layer
function layer.init_config()
  -- VimWiki comes with its own default keybindings all under <leader>w
  keybind.set_group_name("<leader>w", "Wiki")

  -- Use the default wiki path, with some options
  vim.g.vimwiki_list = {
    {
      path = "~/vimwiki",
      auto_toc = 1,
    }
  }

  keybind.bind_function(edit_mode.NORMAL, "<leader>bS", user_new_scratchpad, { noremap = true })
end

return layer
