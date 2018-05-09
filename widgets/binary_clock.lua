-- BINARY CLOCK WIDGET
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")
local date   = os.date
local ipairs = ipairs
local math   = math


local binaryclock = {}

function binaryclock.get_bin(input, length)
    local remain, result, idx = input, {}, 1
    while remain > 0 do
        local temp = math.floor(remain / 2)
        result[idx] = remain - temp * 2
        remain = temp
        idx = idx + 1
    end
    for idx2 = idx,length do
        result[idx2] = 0
    end
    return result
end

function binaryclock.get_dots()
    local date_struct, result, idx = date("*t"), {}, 1
    for _, parts in ipairs({{"min", 6}, {"hour", 5}, {"wday", 3}, {"day", 5}, {"month", 4}}) do
        local temp = date_struct[parts[1]]
        if (parts[1] == "wday") then
            temp = temp -1
        end
        local bins = binaryclock.get_bin(temp, parts[2])
        for _, bit in ipairs(bins) do
            result[idx] = bit
            idx = idx + 1
        end
    end
    return result
end

local function factory(args)
    local local_args = args or {}
    binaryclock.show_sec = local_args.show_sec or false
    binaryclock.widget_height = beautiful.wibox_height
    binaryclock.color_active = gears.color(beautiful.widget_blue)
    binaryclock.color_inactive = gears.color(beautiful.widget_gray)
    binaryclock.coords = {}
    binaryclock.dotsize = 0
    binaryclock.week_names = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"}
    binaryclock.show_tooltip = function()
        local date_st = date("*t")
        local title = string.format("%04d-%02d-%02d", date_st.year, date_st.month, date_st.day)
        local text = string.format("%s %02d:%02d", binaryclock.week_names[date_st.wday + 1], date_st.hour, date_st.min)
        binaryclock.tooltip = naughty.notify{title=title, text=text, timeout=5, hover_timeout=0.5, width=80,}
    end

    binaryclock.widget = wibox.widget {
        fit = function(_, _, _, _)
            local step = math.max(math.floor(binaryclock.widget_height / 9), 1)
            local dotsize = math.floor((binaryclock.widget_height - step * 3) / 2) --dot size
            local coords = {}
            local height = step * 3 + binaryclock.dotsize * 2
            local width = step * 17 + dotsize * 16
            step = step + dotsize  -- here it becomes the spacing + dotsize
            -- create the coordinate arrays
            local x = width - step  -- minutes
            local y = height - step
            for idx = 1,6 do
                x = x - step
                coords[idx] = {x, y}
            end
            y = y - step  -- hours
            x = x + step * 6
            for idx = 7,11 do
                x = x - step
                coords[idx] = {x, y}
            end
            x = x - step
            -- day of week
            for idx = 12,14 do
                x = x - step
                coords[idx] = {x, y}
            end
            y = y + step  -- day of month
            for idx = 15,19 do
                x = x - step
                coords[idx] = {x, y}
            end
            x = x + step * 4  -- month
            y = y - step
            for idx = 20,23 do
                x = x - step
                coords[idx] = {x, y}
            end
            binaryclock.coords = coords
            binaryclock.dotsize = dotsize
            return width, height
        end,
        draw = function(_, _, cr, _, _)
            local dotsize, coords = binaryclock.dotsize, binaryclock.coords
            local color_active, color_inactive = binaryclock.color_active, binaryclock.color_inactive
            local dots = binaryclock.get_dots()
            for idx, bit in ipairs(dots) do
                local xy = coords[idx]
                if (bit == 1) then
                    cr:set_source(color_active)
                else
                    cr:set_source(color_inactive)
                end
                cr:rectangle(xy[1], xy[2], dotsize, dotsize)
                cr:fill()
            end
        end,
        layout = wibox.widget.base.make_widget
    }
    binaryclock.timer = gears.timer { timeout = binaryclock.show_sec and 1 or 20, autostart = true,
        callback = function() binaryclock.widget:emit_signal("widget::redraw_needed") end} --register timer
    binaryclock.widget:connect_signal("mouse::enter", function() binaryclock.show_tooltip() end)
    binaryclock.widget:connect_signal("mouse::leave", function() naughty.destroy(binaryclock.tooltip) end)
    return binaryclock
end

return factory
