
--[[
                                   
     modified
     Dremora Awesome WM config 2.0 
     github.com/copycat-killer     
                                   
     icons from powerarrow dark theme
--]]

local theme                                     = {}

local xresources = require("beautiful").xresources
local theme_assets = require("beautiful.theme_assets")
local xrdb = xresources.get_current_theme()

theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/dremod"
theme.wallpaper                                 = theme.dir .. "/wall.png"

theme.delta = 10
theme.padding = 00
theme.useless_gap = 8

-- theme.font                                      = "Misc Tamsyn 10.5"
-- theme.taglist_font                              = "Misc Tamsyn 10.5"
theme.font                                      = "Terminus 9"
theme.taglist_font                              = "Terminus 9"
theme.fg_normal                                 = "#747474"
theme.fg_focus                                  = "#DDDCFF"
theme.bg_normal                                 = xrdb.background
theme.bg_focus                                  = xrdb.background
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = 4 --"2"
theme.border_normal                             = xrdb.background --"#2F2F2F"
-- theme.border_focus                              = "#4F4F4F"
-- theme.border_focus                              = "#6F6F6F"
theme.border_focus                              = "#12abe2"
-- theme.border_focus                              = xrdb.color8
-- theme.border_focus                              = "#FFFFFF" --xrdb.color0
theme.titlebar_bg_focus                         = "#292929"
theme.taglist_fg_focus                          = "#dddcff"
theme.taglist_bg_focus                          = xrdb.background --"#00000000" --

theme.menu_height                               = 16
theme.menu_width                                = 130
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"

theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"

theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"

theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true


theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

-- recolor icons
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

return theme
