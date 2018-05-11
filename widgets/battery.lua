-- @module Battery with Arc icons
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local mirror = wibox.container.mirror
local background = wibox.container.background

--[[ Show warning notification ]]
function show_battery_warning()
    naughty.notify{
        icon = os.getenv("HOME") .. "/.config/awesome/widgets/warning.png",
        icon_size = 100, text = "Huston, we have a problem", title = "Battery is dying",
        timeout = 5, hover_timeout = 0.5, position = "bottom_right", bg = "#F06060",
        fg = "#EEE9EF", width = 300,
    }
end

-- only text
local text = wibox.widget{id = "txt", font = "DejaVuSansMono NF 5", widget = wibox.widget.textbox}
local text_with_bg = background(mirror(text, {horizontal = true}))
-- actual widget
local batteryarc = wibox.widget {
    text_with_bg, max_value = 1, rounded_edge = true, thickness = 2, start_angle = 4.71238898, -- 2pi*3/4
    forced_height = 17, forced_width = 17, bg = beautiful.widget_transparent, paddings = 2,
    widget = wibox.container.arcchart,
    set_value = function(self, value) self.value = value end,
}

-- mirror the widget, so that chart value increases clockwise
local battery = mirror(batteryarc, { horizontal = true })

watch("acpi", 10,
    function(widget, stdout, _, _, _)
        --local batteryType
        local _, status, charge_str, _ = string.match(stdout, '(.+): (%a+), (%d?%d%d)%%,? ?.*')
        local charge = tonumber(charge_str)
        widget.value = charge / 100
        if status == 'Charging' then
            text_with_bg.bg = beautiful.widget_green
            text_with_bg.fg = beautiful.widget_black
        else
            text_with_bg.bg = beautiful.widget_transparent
            text_with_bg.fg = beautiful.widget_main_color
        end

        if charge < 15 then
            batteryarc.colors = { beautiful.widget_red }
            if status ~= 'Charging' and charge > 14 then show_battery_warning() end
        elseif charge > 15 and charge < 40 then
            batteryarc.colors = {beautiful.widget_yellow}
        else
            batteryarc.colors = {beautiful.widget_main_color}
        end
        text.text = charge
    end,
    batteryarc
)

-- Popup with battery info
-- One way of creating a pop-up notification - naughty.notify
local notification
function show_battery_status()
    awful.spawn.easy_async([[bash -c 'acpi']],
        function(stdout, _, _, _)
            notification = naughty.notify{
                text = stdout, title = "Battery status", timeout = 5, hover_timeout = 0.5, width = 200
            }
        end
    )
end

batteryarc:connect_signal("mouse::enter", function() show_battery_status() end)
batteryarc:connect_signal("mouse::leave", function() naughty.destroy(notification) end)

return battery
