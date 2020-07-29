--- File management
-- @module l.file_man

local plug = require("c.plug")
local keybind = require("c.keybind")
local edit_mode = require("c.edit_mode")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("junegunn/fzf.vim")
end

--- Configures vim and plugins for this layer
function layer.init_config()

  vim.api.nvim_exec(
    [[
    let $FZF_DEFAULT_OPTS .= '--bind alt-k:preview-up,alt-j:preview-down --height=70% --preview="ccat --color=always {}" --preview-window=right:60%:wrap --inline-info'
    if exists('g:fzf_colors.bg')
        call remove(g:fzf_colors, 'bg')
    endif

    if stridx($FZF_DEFAULT_OPTS, '--border') == -1
        let $FZF_DEFAULT_OPTS .= ' --border'
    endif

    function! FloatingFZF()
        let width = float2nr(&columns * 0.9)
        let height = float2nr(&lines * 0.6)
        let opts = { 'relative': 'editor',
                    \ 'row': (&lines - height) / 2,
                    \ 'col': &columns,
                    \ 'width': &columns,
                    \ 'height': height }

        let win = nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
        call setwinvar(win, '&winhighlight', 'NormalFloat:Normal')
    endfunction

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
      ]],
    false
    )

  vim.g.fzf_colors = {
    ['fg']         = {'fg', 'normal'},
    ['bg']         = {'bg', 'Normal'},
    ['hl']         = {'fg', 'Comment'},
    ['fg+']        = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
    ['bg+']        = {'bg', 'CursorLine', 'CursorColumn'},
    ['hl+']        = {'fg', 'Statement'},
    ['info']       = {'fg', 'PreProc'},
    ['border']     = {'fg', 'Label'},
    ['prompt']     = {'fg', 'Conditional'},
    ['pointer']    = {'fg', 'Exception'},
    ['marker']     = {'fg', 'Keyword'},
    ['spinner']    = {'fg', 'Label'},
    ['header']     = {'fg', 'Comment'}
  }

  vim.api.nvim_command("command! -bang -nargs=* Rg " ..
            " call fzf#vim#grep( " ..
            " 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, fzf#vim#with_preview('right:50%:hidden', '?'), " ..
            " <bang>0)")


end

return layer
