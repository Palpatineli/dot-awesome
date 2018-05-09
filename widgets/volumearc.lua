-------------------------------------------------
-- Volume Arc Widget for Awesome Window Manager
-- Shows the current volume level
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volumearc-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local GET_VOLUME_CMD = 'amixer sget Master'
local INC_VOLUME_CMD = 'amixer sset Master 5%+'
local DEC_VOLUME_CMD = 'amixer sset Master 5%-'
local TOG_VOLUME_CMD = 'amixer sset Master toggle'

local text = wibox.widget { id = "txt", font = "DejaVuSansMono NF 5", widget = wibox.widget.textbox }
local mirroed_text = wibox.container.background(wibox.container.mirror(text, { horizontal = true }))

local volumearc = wibox.widget {
    mirroed_text,
    max_value = 1,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 17,
    forced_width = 17,
    bg = "#ffffff11",
    paddings = 2,
    widget = wibox.container.arcchart
}

local volumearc_widget = wibox.container.mirror(volumearc, { horizontal = true })

local update_graphic = function(widget, stdout, _, _, _)
    local mute = string.match(stdout, "%[(o%D%D?)%]")
    local volume = string.match(stdout, "(%d?%d?%d)%%")
    volume = tonumber(string.format("% 3d", volume))

    widget.value = volume / 100;
    if mute == "off" then
        widget.colors = { beautiful.widget_red }
        text.colors = { beautiful.widget_red }
        text.text = "██"
    else
        widget.colors = { beautiful.widget_main_color }
        text.colors = { beautiful.widget_main_color }
        text.text = volume
    end
end

volumearc:connect_signal("button::press", function(_, _, _, button)
    if (button == 4) then awful.spawn(INC_VOLUME_CMD, false)
    elseif (button == 5) then awful.spawn(DEC_VOLUME_CMD, false)
    elseif (button == 1) then awful.spawn(TOG_VOLUME_CMD, false)
    end

    spawn.easy_async(GET_VOLUME_CMD, function(stdout, stderr, exitreason, exitcode)
        update_graphic(volumearc, stdout, stderr, exitreason, exitcode)
    end)
end)

watch(GET_VOLUME_CMD, 1, update_graphic, volumearc)

return volumearc_widget
