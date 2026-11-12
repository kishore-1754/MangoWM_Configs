 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#111418',
    base01 = '#1d2024',
    base02 = '#272a2f',
    base03 = '#8b919b',
    base04 = '#c1c7d2',
    base05 = '#e1e2e8',
    base06 = '#e1e2e8',
    base07 = '#e1e2e8',
    base08 = '#ffb4ab',
    base09 = '#f1afff',
    base0A = '#b1c9e6',
    base0B = '#9ccaff',
    base0C = '#f1afff',
    base0D = '#9ccaff',
    base0E = '#b1c9e6',
    base0F = '#d0e4ff',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#e1e2e8',          bg = '#111418' })
  hi('TelescopeBorder',         { fg = '#8b919b',             bg = '#111418' })
  hi('TelescopePromptNormal',   { fg = '#e1e2e8',          bg = '#111418' })
  hi('TelescopePromptBorder',   { fg = '#8b919b',             bg = '#111418' })
  hi('TelescopePromptPrefix',   { fg = '#9ccaff',             bg = '#111418' })
  hi('TelescopePromptCounter',  { fg = '#c1c7d2',  bg = '#111418' })
  hi('TelescopePromptTitle',    { fg = '#111418',             bg = '#9ccaff' })
  hi('TelescopePreviewTitle',   { fg = '#111418',             bg = '#b1c9e6' })
  hi('TelescopeResultsTitle',   { fg = '#111418',             bg = '#f1afff' })
  hi('TelescopeSelection',      { fg = '#e1e2e8',          bg = '#272a2f' })
  hi('TelescopeSelectionCaret', { fg = '#9ccaff',             bg = '#272a2f' })
  hi('TelescopeMatching',       { fg = '#9ccaff',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#e1e2e8',          bg = '#111418' })
  hi('MiniPickBorder',         { fg = '#8b919b',             bg = '#111418' })
  hi('MiniPickPrompt',   { fg = '#e1e2e8',          bg = '#111418' })
  hi('MiniPickPromptPrefix',   { fg = '#9ccaff',             bg = '#111418' })
  hi('MiniPickBorderText',    { fg = '#111418',             bg = '#9ccaff' })
  hi('MiniPickMatchCurrent',      { fg = '#e1e2e8',          bg = '#272a2f' })
  hi('MiniPickPromptCaret', { fg = '#9ccaff',             bg = '#272a2f' })
  hi('MiniPickMatchRanges',       { fg = '#9ccaff',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
