--- Snippet layer
-- @module l.snippet

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}

--- Registers plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("norcalli/snippets.nvim")
end

--- Configures vim and plugins for this layer
function layer.init_config()

  vim.g.completion_enable_snippet = "snippets"
  vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}


require'snippets'.snippets = {
  -- The _global dictionary acts as a global fallback.
  -- If a key is not found for the specific filetype, then
  --  it will be lookup up in the _global dictionary.
  _global = {

    uname = function() return vim.loop.os_uname().sysname end;
    date = os.date;

    -- Equivalent to above.
    epoch = function() return os.time() end;

    -- Use the expansion to read the username dynamically.
    note = [[NOTE(${=io.popen("id -un"):read"*l"}): ]];

    -- Do the same as above, but by using $1, we can make it user input.
    -- That means that the user will be prompted at the field during expansion.
    -- You can *EITHER* specify an expression as a placeholder for a variable
    --  or a literal string/snippet using `${var:...}`, but not both.
    note = [[NOTE(${1=io.popen("id -un"):read"*l"}): ]];
  };

  tex = {
    cent = [[\begin{center}
    $0
\end{center}
]];
  beg = [[\begin{$1}
  $0
\end{$1}]];
  frac = [[\frac{$1}{$2}$0]];
  };

  ["c.doxygen"] = {
    -- Variables can be repeated, and the value of what the user puts in will be
    -- expanded at every position where the bare variable is used (i.e. $1, $2...)
    ["#if"] = [[
#if ${1:CONDITION}
$0
#endif // $1
]];

    -- Here is where we get to advanced usage. The `|...` block is a transformation
    --  which is applied to the result of the variable *at the position*.
    -- Inside of this block, the special variable `S` is defined. Its usage should be
    --  obvious based on its usage in the following snippet. If not, read #Details below.
    --
    -- This is an important note:
    --   Transformations don't apply to every position for repeated variables, only
    --   at which it is defined.
    --
    -- You'll also see at the bottom `${|S[1]:gsub("%s+", "_")}`. This is a transformation
    --  just like above, except that without a variable name, it'll just be evaluated at
    --  the end of the snippet expansion. In this example, it's using the value of variable 1
    --  and replacing whitespace with underscores.
    guard = [[
#ifndef AK_${1:header name|S.v:upper():gsub("%s+", "_")}_H_
#define AK_$1_H_

// This is a header for $1

int ${1|S.v:lower():gsub("%s+", "_")} = 123;

$0

#endif // AK_${|S[1]:gsub("%s+", "_")}_H_
]];

    -- This is also illegal because it makes no sense, adding a transformation
    --  to an expression is redundant.
    -- ["inc"] = [[#include "${=vim.fn.expand("%:t")|S.v:upper()}"]];

    -- Just do this instead.
    inc = [[#include "${=vim.fn.expand("%:t"):upper()}"]];

    -- The final important note is the use of negative number variables.
    -- Negative variables *never* ask for user input, but otherwise behave
    --  like normal variables.
    -- This can be useful for storing the value of an expression, and repeating
    --  it in multiple locations.
    -- The following snippet will ask for the user's input using `input()` *once*,
    --  but use the value in multiple places.
    user_input = [[hey? ${-1=vim.fn.input("what's up? ")} = ${-1}]];
  };
}

  local opts = { noremap=true, silent=true }
  -- <C-e> will either expand the current snippet at the word or try to jump to
  -- the next position for the snippet.
  vim.api.nvim_set_keymap("i", "<C-e>", "<cmd>lua require'snippets'.expand_or_advance(1)<CR>",  opts)

  -- <C-q> will jump backwards to the previous field.
  -- If you jump before the first field, it will cancel the snippet.
  vim.api.nvim_set_keymap("i", "<C-q>", "<cmd>lua require'snippets'.advance_snippet(-1)<CR>", opts)
end

return layer
