---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi
local HOME = os.getenv("HOME")

local theme_name = "gruv_p"
local theme_path = string.format("%s/.config/awesome/themes/%s/", HOME, theme_name)

local palette = {
    bg       = "#fbf1c7",
    gray     = "#928374",
    fg       = "#3c3836",
    bg_h     = "#f9f5d7",
    bg_s     = "#f2e5bc",
    bg1      = "#ebdbb2",
    bg2      = "#d5c4a1",
    bg3      = "#bdae93",
    bg4      = "#a89984",
    fg0      = "#282828",
    fg1      = "#3c3836",
    fg2      = "#504945",
    fg3      = "#665c54",
    fg4      = "#7c6f64",
    red      = "#cc241d",
    red_h    = "#9d0006",
    green    = "#98971a",
    green_h  = "#79740e",
    yellow   = "#d79921",
    yellow_h = "#b57614",
    blue     = "#458588",
    blue_h   = "#076678",
    purple   = "#b16286",
    purple_h = "#8f3f71",
    cyan     = "#680d6a",
    cyan_h   = "#427b58",
    orange   = "#d65d0e",
    orange_h = "#af3a03",
    transparent = "#fbf1c711"
}

local theme = {
    font          = "DejaVuSansMono NF 9",
--
    bg_normal     = palette.bg,
    bg_focus      = palette.bg4,
    bg_urgent     = palette.red,
    bg_minimize   = palette.yellow,
--
    fg_normal     = palette.fg,
    fg_focus      = palette.bg,
    fg_urgent     = palette.bg,
    fg_minimize   = palette.fg,
--
    useless_gap   = dpi(3),
    border_width  = dpi(1),
    border_normal = palette.bg,
    border_focus  = palette.purple_h,
    border_marked = palette.red_h,
--
    widget_main_color = palette.fg,
    widget_red    = palette.red,
    widget_green  = palette.green,
    widget_yellow = palette.yellow,
    widget_blue   = palette.blue,
    widget_gray   = palette.bg2,
    widget_black  = palette.fg,
    widget_transparent = palette.transparent
}

theme.bg_systray  = theme.bg_normal

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- wibox height
theme.wibox_height = dpi(18)

-- Generate taglist squares:
theme.taglist_spacing       = dpi(5)
theme.taglist_bg_empty      = palette.bg1
theme.taglist_fg_empty      = palette.fg
theme.taglist_bg_occupied   = palette.bg3
theme.taglist_fg_occupied   = palette.fg
theme.taglist_bg_focus      = palette.fg
theme.taglist_fg_focus      = palette.bg_h
theme.taglist_bg_urgent     = palette.red_h
theme.taglist_fg_urgent     = palette.bg_h

-- Task List:
theme.tasklist_bg_normal    = palette.bg1
theme.tasklist_plain_task_name = true
theme.tasklist_spacing = dpi(5)
theme.tasklist_shape = gears.shape.rectangle


-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
local title_path = theme_path..  "titlebar/"
theme.titlebar_close_button_normal = title_path.."close_normal.png"
theme.titlebar_close_button_focus  = title_path.."close_focus.png"

theme.titlebar_minimize_button_normal = title_path.."minimize_normal.png"
theme.titlebar_minimize_button_focus  = title_path.."minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = title_path.."ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = title_path.."ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = title_path.."ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = title_path.."ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = title_path.."sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = title_path.."sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = title_path.."sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = title_path.."sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = title_path.."floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = title_path.."floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = title_path.."floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = title_path.."floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = title_path.."maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = title_path.."maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = title_path.."maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = title_path.."maximized_focus_active.png"

local theme_path = string.format("%s/.config/awesome/themes/%s/", HOME, theme_name)
theme.wallpaper = HOME.."/Pictures/wallpaper.jpg"

-- You can use your own layout icons like this:
local layout_path = theme_path.."layouts/"
theme.layout_fairh = layout_path.."fairh.png"
theme.layout_fairv = layout_path.."fairv.png"
theme.layout_floating  = layout_path.."floating.png"
theme.layout_magnifier = layout_path.."magnifier.png"
theme.layout_max = layout_path.."max.png"
theme.layout_fullscreen = layout_path.."fullscreen.png"
theme.layout_tilebottom = layout_path.."tilebottom.png"
theme.layout_tileleft   = layout_path.."tileleft.png"
theme.layout_tile = layout_path.."tile.png"
theme.layout_tiletop = layout_path.."tiletop.png"
theme.layout_spiral  = layout_path.."spiral.png"
theme.layout_dwindle = layout_path.."dwindle.png"
theme.layout_cornernw = layout_path.."cornernw.png"
theme.layout_cornerne = layout_path.."cornerne.png"
theme.layout_cornersw = layout_path.."cornersw.png"
theme.layout_cornerse = layout_path.."cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.wibox_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
