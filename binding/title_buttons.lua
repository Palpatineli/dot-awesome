-- @module: Title Buttons
local title_buttons = {}
local awful = require("awful")
local join = require("gears").table.join

function title_buttons.get(c)
    return join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )
end

return title_buttons
