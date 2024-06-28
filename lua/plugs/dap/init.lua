local dap = require('dap')
local dapui = require('dapui')
local dap_virtual_text = require('nvim-dap-virtual-text')

--Configure DAP UI
dapui.setup()

-- Configure DAP Virtual Text
dap_virtual_text.setup()

-- Keybindings for nvim-dap
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })

-- Automatically open DAP UI when debuggin sessions
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--NOTE: Make sure to install the needed files / executables throught mason
require "plugs.dap.settings.cpptools"
require "plugs.dap.settings.netcoredbg"
require "plugs.dap.settings.godot"
require "plugs.dap.settings.bash-debug-adapter"
require "plugs.dap.settings.php-debug-adapter"
require "plugs.dap.settings.dart-debug-adapter"
require "plugs.dap.settings.chrome-debug-adapter"
require "plugs.dap.settings.firefox-debug-adapter"
require "plugs.dap.settings.java-debug"
require "plugs.dap.settings.node-debug2"
require "plugs.dap.settings.debugpy"
require "plugs.dap.settings.go-debug-adapter"
require "plugs.dap.settings.js-debug"
