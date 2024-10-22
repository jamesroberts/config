function async_run_command(command, input, callback)
  local stdout = ""
  local stderr = ""

  local function on_stdout(_, data)
    if data then
      stdout = stdout .. table.concat(data, "\n")
    end
  end

  local function on_stderr(_, data)
    if data then
      stderr = stderr .. table.concat(data, "\n")
    end
  end

  local function on_exit(_, exit_code)
    if exit_code ~= 0 then
      callback(nil, stderr)
    else
      callback(stdout, nil)
    end
  end

  local job_id = vim.fn.jobstart(command, {
    on_stdout = on_stdout,
    on_stderr = on_stderr,
    on_exit = on_exit,
    stdin = "pipe"
  })

  if job_id <= 0 then
    callback(nil, "Failed to start job")
    return
  end

  vim.fn.chansend(job_id, input)
  vim.fn.chanclose(job_id, "stdin")
end

local function insert_at_cursor(text)
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1] - 1, cursor[2]

  vim.schedule(function()
    if text then
      local lines = vim.split(text, "\n")
      vim.api.nvim_buf_set_text(bufnr, row, col, row, col, lines)
    end
  end)
end

function get_user_input(on_submit)
  vim.ui.input({ prompt = 'prompt: ' }, function(input)
    if input ~= nil then
      on_submit(input)
    end
  end)
end

function get_visual_pos()
  local mode = vim.api.nvim_get_mode().mode

  -- get visual selection and current cursor position (1-indexed)
  local _, srow, scol = unpack(vim.fn.getpos 'v')
  local _, erow, ecol = unpack(vim.fn.getpos '.')

  -- normalize start + end such that start_pos < end_pos and converts to 0-index
  srow, scol, erow, ecol = srow - 1, scol - 1, erow - 1, ecol - 1
  if srow > erow then
    srow, erow = erow, srow
  end

  if scol > ecol then
    scol, ecol = ecol, scol
  end

  -- in visual block and visual line mode, we expect first column of srow and last column of erow
  if mode == 'V' or mode == '\22' or mode == 'n' then
    scol, ecol = 0, -1
  else
    ecol = ecol + 1
  end

  return srow, scol, erow, ecol
end

local function get_visual_text(srow, scol, erow, ecol)
  -- handling + cleanup for visual selection
  local mode = vim.api.nvim_get_mode().mode
  local visual_selection
  local replace_mode = not (mode == 'n')

  if replace_mode then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', false, true, true), 'nx', false)
    visual_selection = table.concat(vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {}), '\n')
  end

  local debug = false
  if not debug and replace_mode then
    vim.api.nvim_buf_set_text(0, srow, scol, erow, ecol, {})
  end

  return visual_selection
end


vim.keymap.set({'n', 'v'}, '<leader>xx', function()
  local command = "python ~/llm.py"
  local srow, scol, erow, ecol = get_visual_pos()
  local input = get_visual_text(srow, scol, erow, ecol)
  async_run_command(command, input, function(result, error)
    if error then
        local lines = vim.split(error, '\n')
        vim.cmd 'undojoin'
        vim.api.nvim_buf_set_text(0, srow, scol, srow, scol, lines)
    else
        local lines = vim.split(result, '\n')
        vim.cmd 'undojoin'
        vim.api.nvim_buf_set_text(0, srow, scol, srow, scol, lines)
    end

  end)
end, { noremap = true, silent = true })

return {}
