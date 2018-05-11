-- @module mymenu: create menus
local mymenu = {}
local env = require("environ")
local menu = require("awful.menu")
local menubar = require("menubar")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Try load Debian menu entries
local has_deb, debian = pcall(require, "debian.menu")
local has_freedesktop, freedesktop = pcall(require, "freedesktop")

function mymenu.mainmenu()  -- construct main menu from freedesktop or debian menu
    myawesomemenu = {
       { "hotkeys", function() return false, hotkeys_popup.show_help end},
       { "manual", env.terminal .. " -e man awesome" },
       { "edit config", env.editor_cmd .. " " .. awesome.conffile },
       { "restart", awesome.restart },
       { "quit", function() awesome.quit() end}
    }
    local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
    local menu_terminal = { "open terminal", env.terminal }
    if has_freedesktop then
        mymainmenu = freedesktop.menu.build({
            before = { menu_awesome },
            after =  { menu_terminal }
        })
    else
        mymainmenu = menu({
            items = { menu_awesome, { "Debian", debian.menu.Debian_menu.Debian },
                      menu_terminal }
        })
    end
    menubar.utils.terminal = env.terminal
    return mymainmenu
end
return mymenu
