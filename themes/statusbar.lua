-- @module: statusbar
local statusbar = {}

local awful = require("awful")
local common = require("awful.widget.common")
local wibar = require("awful.wibar")
local wibox = require("wibox")
local beautiful = require("beautiful")

local weather = require("widgets.weather")
local volume = require("widgets.volume")
local battery = require("widgets.battery")
local tasklist_buttons = require("binding.tasklist_buttons")

local mymainmenu = require("main.menu").mainmenu()
-- local mylauncher = awful.widget.launcher{image = beautiful.awesome_icon, menu = mymainmenu}

local margin = wibox.container.margin

function list_update(w, buttons, label, data, objects)
    common.list_update(w, buttons, label, data, objects)
    w:set_max_widget_size(beautiful.tasklist_width)
end

local text_clock = wibox.widget.textclock()

function statusbar.get(s)
    s.mywibox = wibar{position = "top", s = s, height = beautiful.wibox_height or 20,
                      bg = beautiful.widget_transparent,
                      fg = beautiful.widget_fg
    }
    s.mytasklist = awful.widget.tasklist(
        s,awful.widget.tasklist.filter.currenttags,
        tasklist_buttons, nil, list_update, wibox.layout.flex.horizontal()
    )
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            margin(s.mytaglist, 5),
            s.mypromptbox,
        },
        margin(s.mytasklist, 5, 5), -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            margin(text_clock, 5),
            margin(weather, 10, 10),
            margin(volume, 5),
            margin(battery, 5),
            margin(wibox.widget.systray(), 5),
            s.mylayoutbox,
        },
    }
    return s.mywibox
end

return statusbar
