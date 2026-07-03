local function ensure_sshfs_setup()
  local status, sshfs = pcall(require, "remote-sshfs")
  if not status then
    vim.notify("remote-sshfs is not available", vim.log.levels.WARN)
    return nil
  end

  if vim.g.remote_sshfs_setup then
    return sshfs
  end

  local ok, err = pcall(sshfs.setup, {
    connections = {
      ssh_configs = { -- which ssh configs to parse for hosts list
        vim.fn.expand "$HOME" .. "/.ssh/config",
        "/etc/ssh/ssh_config",
        -- "/path/to/custom/ssh_config"
      },
      -- NOTE: Can define ssh_configs similarly to include all configs in a folder
      -- ssh_configs = vim.split(vim.fn.globpath(vim.fn.expand "$HOME" .. "/.ssh/configs", "*"), "\n")
      sshfs_args = {
        "-o reconnect",
        "-o ConnectTimeout=5",
      },
    },
    mounts = {
      base_dir = vim.fn.expand "$HOME" .. "/.sshfs/",
      unmount_on_exit = true,
    },
    handlers = {
      on_connect = {
        change_dir = true,
      },
      on_disconnect = {
        clean_mount_folders = false,
      },
      on_edit = {},
    },
    ui = {
      select_prompts = false, -- not yet implemented
      confirm = {
        connect = true,
        change_dir = false,
      },
    },
    log = {
      enabled = false,
      truncate = false,
      types = {
        all = false,
        util = false,
        handler = false,
        sshfs = false,
      },
    },
  })

  if not ok then
    vim.notify("Failed to initialize remote-sshfs: " .. tostring(err), vim.log.levels.ERROR)
    return nil
  end

  vim.g.remote_sshfs_setup = true
  return sshfs
end

local function call_sshfs(fn_name, ...)
  local ok, api = pcall(require, "remote-sshfs.api")
  if not ok then
    vim.notify("remote-sshfs api is not available", vim.log.levels.ERROR)
    return
  end

  local sshfs = ensure_sshfs_setup()
  if not sshfs then
    return
  end

  api[fn_name](...)
end

local function sshfs_connected()
  local ok, connections = pcall(require, "remote-sshfs.connections")
  if not ok then
    return false
  end

  return connections.is_connected and connections.is_connected()
end

vim.keymap.set("n", "<leader>sc", function()
  call_sshfs("connect")
end, { desc = "Remote sshfs connect to host" })

vim.keymap.set("n", "<leader>sd", function()
  call_sshfs("disconnect")
end, { desc = "Remote sshfs disconnect to host" })

vim.keymap.set("n", "<leader>se", function()
  call_sshfs("edit")
end, { desc = "Remote sshfs edit hosts" })

vim.keymap.set("n", "<leader>sf", function()
  if sshfs_connected() then
    call_sshfs("find_files")
  else
    require("telescope.builtin").find_files()
  end
end, { desc = "Remote sshfs find files" })

vim.keymap.set("n", "<leader>sg", function()
  if sshfs_connected() then
    call_sshfs("live_grep")
  else
    require("telescope.builtin").live_grep()
  end
end, { desc = "Remote sshfs live grep" })
