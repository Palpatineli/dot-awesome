-- @module: Global Keys
local awful = require("awful")
-- local menubar = require('menubar')
local hotkeys_popup = require("awful.hotkeys_popup").widget
local join = require('gears').table.join

local env = require("environ")
local modkey = env.modkey
local mainmenu = require("main.menu").mainmenu()

local global_keys = join(
    -- Functional/Media Keys
    awful.key({}, "#121", function() awful.util.spawn("amixer sset Master toggle") end),
    awful.key({}, "#122", function() awful.util.spawn("amixer sset Master 5%-") end),
    awful.key({}, "#123", function() awful.util.spawn("amixer sset Master 5%+") end),
    awful.key({}, "#232", function() awful.util.spawn("xbacklight -dec 10") end),
    awful.key({}, "#233", function() awful.util.spawn("xbacklight -inc 10") end),
    awful.key({}, "#171", function() awful.util.spawn("cmus-remote -n") end),
    awful.key({}, "#172", function() awful.util.spawn("cmus-remote -u") end),
    awful.key({}, "#173", function() awful.util.spawn("cmus-remote -r") end),
    -- Regular
    awful.key({modkey}, "s", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({modkey}, "w", function() mainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    -- Navigation: taglist
    awful.key({modkey}, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({modkey}, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    -- Navigation: panes by direction
    awful.key({modkey}, "j", function() awful.client.focus.bydirection('down') end,
              {description = "focus down by direction", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.bydirection('up') end,
              {description = "focus up by direction", group = "client"}),
    awful.key({modkey}, "h", function() awful.client.focus.bydirection('left') end,
              {description = "focus left by direction", group = "client"}),
    awful.key({modkey}, "l", function() awful.client.focus.bydirection('right') end,
              {description = "focus right by direction", group = "client"}),
    -- Navigation: go to last pane
    awful.key({modkey}, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end, {description = "go back", group = "client"}
    ),
    -- Layout manipulation: by direction
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.bydirection('down') end,
              {description = "swap with the bottom client by direction", group = "client"}),
    awful.key({modkey, "Shift"}, "k", function() awful.client.swap.bydirection('up') end,
              {description = "swap with the top client by direction", group = "client"}),
    awful.key({modkey, "Shift"}, "h", function() awful.client.swap.bydirection('left') end,
              {description = "swap with the left client by direction", group = "client"}),
    awful.key({modkey, "Shift"}, "l", function() awful.client.swap.bydirection('right') end,
              {description = "swap with the right client by direction", group = "client"}),
    awful.key({modkey, "Control"}, "j", function() awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, "Control"}, "k", function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({modkey}, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    -- Standard program
    awful.key({modkey}, "Return", function() awful.spawn(env.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({modkey}, "r", function() awful.spawn("rofi -show combi") end,
              {description = "rofi launcher", group = "launcher"}),
    --awful.key({modkey}, "l", function() awful.tag.incmwfact( 0.05) end,
    --          {description = "increase master width factor", group = "layout"}),
    --awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
    --          {description = "decrease master width factor", group = "layout"}),
    --awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1, nil, true) end,
              --{description = "increase the number of master clients", group = "layout"}),
    --awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1, nil, true) end,
              --{description = "decrease the number of master clients", group = "layout"}),
    awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({modkey}, "space", function() awful.layout.inc(1) end,
              {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),
    -- Restore Panel and focus to it
    awful.key({modkey, "Control"}, "n",
        function()
            local c = awful.client.restore()
            if c then
                client.focus = c
                c:raise()
            end
        end, {description = "restore minimized", group = "client"}
    ),
    -- Prompt
    awful.key({modkey}, "#68", function() awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({modkey}, "x",  -- Prompt: lua
        function()
            awful.prompt.run({
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
           })
        end, {description = "lua execute prompt", group = "awesome"}
    )
    --awful.key({modkey}, "p", function() menubar.show() end,
    --          {description = "show the menubar", group = "launcher"})
)
return global_keys
