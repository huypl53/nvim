-- Grep helpers and keymaps
-- Mappings prompt for a pattern, optionally a file/glob list, run the search,
-- and send results either to the quickfix list or the location list.

local keymap = vim.keymap

-- Remember last pattern to make repeated searches faster
local last_pattern = ''

local function prompt_pattern(prompt)
  last_pattern = vim.fn.input(prompt or 'Pattern: ', last_pattern)
  return last_pattern
end

local function run_grep(opts)
  local pattern = prompt_pattern(opts.prompt)
  if pattern == nil or pattern == '' then
    return
  end

  -- Escape the delimiter so `/` in the pattern won't break the command
  local safe_pattern = vim.fn.escape(pattern, '/')

  -- Determine files to search
  local files = opts.files or '%'
  if opts.ask_files then
    local input = vim.fn.input(opts.files_prompt or 'Files/glob: ', opts.default_files or files)
    if input ~= nil and input ~= '' then
      files = input
    end
  end

  local grep_cmd = opts.to_loclist and 'lvimgrep' or 'vimgrep'
  local open_cmd = opts.to_loclist and 'lopen' or 'copen'

  local ok, err = pcall(vim.cmd, string.format('%s /%s/j %s', grep_cmd, safe_pattern, files))
  if not ok then
    vim.notify('grep failed: ' .. err, vim.log.levels.ERROR)
    return
  end

  vim.cmd(open_cmd)
end

-- Quickfix: grep current buffer with prompted pattern
keymap.set('n', '<leader>gq', function()
  run_grep({ prompt = 'Grep (quickfix) › ', to_loclist = false })
end, { desc = 'Grep current buffer -> quickfix' })

-- Location list: grep current buffer with prompted pattern
keymap.set('n', '<leader>gl', function()
  run_grep({ prompt = 'Grep (location list) › ', to_loclist = true })
end, { desc = 'Grep current buffer -> location list' })

-- Quickfix: grep prompted files/glob list
keymap.set('n', '<leader>gQ', function()
  run_grep({
    prompt = 'Grep files (quickfix) › ',
    files_prompt = 'Files/glob (space-separated) › ',
    default_files = '**/*',
    ask_files = true,
    to_loclist = false,
  })
end, { desc = 'Grep files/glob -> quickfix' })

-- Location list: grep prompted files/glob list
keymap.set('n', '<leader>gL', function()
  run_grep({
    prompt = 'Grep files (location list) › ',
    files_prompt = 'Files/glob (space-separated) › ',
    default_files = '**/*',
    ask_files = true,
    to_loclist = true,
  })
end, { desc = 'Grep files/glob -> location list' })
