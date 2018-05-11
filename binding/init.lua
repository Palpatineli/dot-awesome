-- Binding, not returning anything
local binding = {}
local awful = require("awful")

local tagkeys = require("binding.tagkeys").keys
local globalkeys = require("binding.globalkeys").keys
local globalbuttons = require("binding.globalbuttons").buttons

root.keys(awful.util.table.join(globalkeys, tagkeys))
root.buttons(globalbuttons)

binding.clientkeys = require("binding.clientkeys").keys
binding.clientbuttons = require("binding.clientbuttons").buttons
binding.taglistbuttons = require("binding.taglist").buttons
binding.tasklistbuttons = require("binding.tasklist").buttons
binding.get_titlebuttons = require("binding.titlebuttons").get_buttons
return binding
