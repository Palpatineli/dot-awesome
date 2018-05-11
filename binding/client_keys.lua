-- @module: Client Keys
local awful = require("awful")
local join = require("gears").table.join
local modkey = require("environ").modkey

local function toggle(property)
    return function (c)
        c[property] = not c[property]
        c:raise()
    end
end

local client_keys = join(
    awful.key({modkey}, "f", toggle("fullscreen"),
              {description = "toggle fullscreen", group = "client"}),
    awful.key({modkey, "Shift"}, "c", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({modkey, "Control"}, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({modkey, "Control"}, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({modkey}, "o", function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({modkey}, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({modkey}, "n", function (c) c.minimized = true end ,
              {description = "minimize", group = "client"}),
    awful.key({modkey}, "m", toggle("maximized"),
              {description = "(un)maximize", group = "client"}),
    awful.key({modkey, "Control"}, "m", toggle("maximized_vertical"),
              {description = "(un)maximize vertically", group = "client"}),
    awful.key({modkey, "Shift"}, "m", toggle("maximized_horizontal"),
              {description = "(un)maximize horizontally", group = "client"})
)

return client_keys
