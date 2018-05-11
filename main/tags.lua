-- @module: tags
local tags = {}
local layouts = require("awful").layout.layouts
tags.names = {"", "", "", "", "", "", "", "", "", ""}
tags.layouts = {
    layouts[10],  -- maximized
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[2],  -- tiled left
    layouts[8]   -- spiral
}
return tags
