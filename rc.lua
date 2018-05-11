-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")

-- Initialize theme
local beautiful = require("beautiful")
local theme_name = "gruv_p"
beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme_name))

-- Subroutines
require("error_handling")
require("signals")

-- Keys
local global_keys = require("binding.global_keys")
local tag_keys = require("binding.tag_keys")
local global_buttons = require("binding.global_buttons")
root.keys(awful.util.table.join(global_keys, tag_keys))
root.buttons(global_buttons)

-- Layout/Rules
local layouts = require("main.layout")
local rules = require("main.rules")

awful.layout.layouts = layouts
awful.rules.rules = rules  -- Rules to apply to new clients (through the "manage" signal).

-- autostart
awful.spawn.with_shell("~/.config/awesome/autorun.sh")
