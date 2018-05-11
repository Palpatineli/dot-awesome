-- @module: Client Buttons
local awful = require("awful")
local join = require("gears").table.join
local modkey = require("environ").modkey

local client_buttons = join(
    awful.button({}, 1, function (c) client.focus = c; c:raise() end),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

return client_buttons
