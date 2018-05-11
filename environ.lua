local environ = {}

-- This is used later as the default terminal and editor to run.
environ.terminal = "alacritty"
environ.editor = os.getenv("EDITOR") or "editor"
environ.editor_cmd = environ.terminal .. " -e " .. environ.editor
environ.modkey = "Mod4"

return environ
