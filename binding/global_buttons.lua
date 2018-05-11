-- @module: Global Buttons
local awful = require("awful")
local mymainmenu = require("main.menu").mainmenu()
local join = require("gears").table.join

local global_buttons = join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)

return global_buttons
