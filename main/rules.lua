-- @module: rules
local awful = require("awful")
local beautiful = require("beautiful")
local client_keys = require("binding.client_keys")
local client_buttons = require("binding.client_buttons")

local rules = {
    {
        rule = {},  -- All clients will match this rule
        properties = {border_width = beautiful.border_width, border_color = beautiful.border_normal,
                      focus = awful.client.focus.filter, raise = true, keys = client_keys,
                      buttons = client_buttons, screen = awful.screen.preferred,
                      placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                      size_hints_honor = false}
    },
    -- Floating clients.
    {
        rule_any = {
            instance = {"DTA", "copyq"},  -- Firefox addon DownThemAll. Includes session name in class.
            class = {"Arandr", "Gpick", "Kruler", "MessageWin", "Sxiv", "Wpa_gui", "pinentry", "veromix",
                     "xtightvncviewer"},  -- kalarm.
            name = {"Event Tester"},  -- xev
            role = {"AlarmWindow", "pop-up"}  -- Thunderbird's calendar. or Google Chrome's (detached) Developer Tools.
        },
        properties = { floating = true }
    },
    -- Add titlebars to normal clients and dialogs
    {rule_any = {type = {"dialog"}}, properties = {titlebars_enabled = true}},
    -- Set Firefox to always map on the tag named "2" on screen 1.
    {rule = {class = "Firefox"}, properties = {screen = 1, tag = screen[1].tags[1]}},
    {rule = {class = "ImageJ"}, properties = {floating = true}},
}

return rules
