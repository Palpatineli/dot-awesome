-- @module: Tag Keys
local awful = require("awful")
local join = require("gears").table.join
local modkey = require("environ").modkey

local tag_keys = {}
for i = 1, 10 do
    tag_keys = join(tag_keys,
        awful.key({modkey}, "#" .. i + 9,  -- View tag
            function ()
                local tag = awful.screen.focused().tags[i]
                if tag then tag:view_only() end
            end, {description = "view tag #"..i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key({modkey, "Control"}, "#" .. i + 9,
            function ()
                local tag = awful.screen.focused().tags[i]
                if tag then awful.tag.viewtoggle(tag) end
            end, {description = "toggle tag #" .. i, group = "tag"}
        ),
        awful.key({modkey, "Shift"}, "#" .. i + 9,  -- Move client to tag
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then client.focus:move_to_tag(tag) end
                end
            end, {description = "move focused client to tag #"..i, group = "tag"}
        ),
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9,  -- Toggle tag on focused client
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then client.focus:toggle_tag(tag) end
                end
            end, {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

return tag_keys
