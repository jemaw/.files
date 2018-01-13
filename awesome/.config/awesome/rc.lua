
--[[
                                   
     modified
     Dremora Awesome WM config 2.0 
     github.com/copycat-killer     
                                   
--]]

-- {{{ Required libraries
local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local handTiler     = require("hand-tiler")
--local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
local function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
     findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

run_once("urxvtd")
run_once("unclutter -root")
-- }}}

-- {{{ Variable definitions
-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/dremod/theme.lua")

-- common
local modkey     = "Mod4"
local altkey     = "Mod1"
local terminal   = "urxvt" or "xterm"
local terminal2   = "termite" or "st"
local editor     = os.getenv("EDITOR") or "nano" or "vi"

-- user defined
local browser    = "firefox"
local launcher   = "rofi -show run"
-- local tagnames   = { "ƀ", "Ƅ", "Ɗ", "ƈ", "ƙ" }
local tagnames   = { "one","two","three","four","five"}

local tag_icon 		= "◊"
local tag_icon_active = "◆"
-- table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
}

-- lain
lain.layout.termfair.nmaster        = 3
lain.layout.termfair.ncol           = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol    = 1
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

local function move_or_swap(c, amount, direction)
    return function (c)
        if awful.client.floating.get(c) or awful.layout.getname(awful.layout.get(s)) == "floating" then
            if direction == "down" then
                awful.client.moveresize(  0,  amount,   0,   0)
            elseif direction == "up" then
                awful.client.moveresize(  0, -amount,   0,   0)
            elseif direction == "right" then
                awful.client.moveresize( amount,   0,   0,   0)
            elseif direction == "left" then
                awful.client.moveresize(-amount,   0,   0,   0)
            end
        else 
            awful.client.swap.bydirection(direction)
        end
    end
end
-- }}}

-- {{{ Menu
local mymainmenu = awful.menu.new({
    { "email", "thunderbird"},
    { "files", "thunar"},
    { "gtk", "lxappearance"},
    { "chromium", "chromium"},
    { "firefox", "firefox"},
})
-- }}}

-- {{{ Wibox
local markup     = lain.util.markup
local separators = lain.util.separators
local white      = beautiful.fg_focus
local gray       = "#858585"

-- Textclock
-- local mytextclock = wibox.widget.textclock(markup(gray, " %a")
-- .. markup(white, " %d ") .. markup(gray, "%b ") ..  markup(white, "%H:%M "))
-- local mytextclock = wibox.widget.textclock("<span font='Misc Tamsyn 5'> </span>%H:%M ")
local mytextclock = wibox.widget.textclock(markup(gray, " %a")
.. markup(white, " %d ") .. markup(gray, "%b ") ..  markup(white, "%H:%M "))
mytextclock.font = beautiful.font

-- Calendar
lain.widget.calendar({
    cal = "/usr/bin/cal --color=always",
    attach_to = {mytextclock},
    followtag =  true ,
    notification_preset = {
        font = beautiful.font,
        fg   = white,
        bg   = beautiful.bg_normal
}})

-- MPD
local mpdwidget = lain.widget.mpd({
    settings = function()
        mpd_notification_preset.fg = white
        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup(gray, artist) .. markup(white, title))
    end
})

-- ALSA volume bar
-- local volume = lain.widgets.alsabar({
--     ticks = true, width = 67,
--     notification_preset = { font = beautiful.font }
-- })
-- local volumebg = wibox.container.background(volume.bar, "#585858", gears.shape.rectangle)
-- local volumebg = wibox.container.background(volume.bar, beautiful.fg_normal, gears.shape.rectangle)
-- local volumewidget = wibox.container.margin(volumebg, 7, 7, 5, 5)

-- ALSA volume
local volume = lain.widget.alsa({
    --togglechannel = "IEC958,3",
    settings = function()
        header = " Vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end

        widget:set_markup(markup(gray, header) .. markup(white, vlevel))
    end
})

-- Weather
local myweather = lain.widget.weather({
    city_id = 2867714, -- muenchyen
    notification_preset = { fg = white }
})

-- Separators
local first     = wibox.widget.textbox('<span font="Misc Tamsyn 4"> </span>')
local arrl_pre  = separators.arrow_right("alpha", "#1A1A1A")
local arrl_post = separators.arrow_right("#1A1A1A", "alpha")

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Quake application
    s.quake = lain.util.quake({ app = terminal })

    -- Wallpaper
    -- set_wallpaper(s)

    -- Tags
    awful.tag(tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            first,
            s.mylayoutbox,
            first,
            first,
            first,
            s.mytaglist,
            -- arrl_pre,
            -- arrl_post,
            s.mypromptbox,
            -- first,
            first,
            first,
            first,
            first,
            first,
            first,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            first,
            first,
            first,
            -- mpd.widget,
            --mail.widget,
            volume.widget,
            first,
            mytextclock,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

    -- Take a screenshot
    -- https://github.com/copycat-killer/dots/blob/master/bin/screenshot
    awful.key({ altkey }, "p", function() os.execute("screenshot") end),

    -- Hotkeys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    -- Tag browsing
    awful.key({ modkey }, ",",   awful.tag.viewprev       ),
    awful.key({ modkey }, ".",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- movement
    awful.key({ modkey,"Shift" }, "j", move_or_swap(c,20,"down")),
    awful.key({ modkey,"Shift" }, "k", move_or_swap(c,20,"up")),
    awful.key({ modkey,"Shift" }, "h", move_or_swap(c,20,"left")),
    awful.key({ modkey,"Shift" }, "l", move_or_swap(c,20,"right")),

	-- resize
	awful.key({ modkey }, "Next",  function (c) awful.client.moveresize( 0,  0, -40, -40) end), 
	awful.key({ modkey }, "Prior", function (c) awful.client.moveresize( 0, 0,  40,  40) end),  

	awful.key({ altkey }, "j", function (c) awful.client.moveresize( 0,   0,   0,   20) end),  
	awful.key({ altkey }, "k", function (c) awful.client.moveresize( 0,   0,   0,   -20) end),  
	awful.key({ altkey }, "l", function (c) awful.client.moveresize( 0,   0,   20,   0) end),  
	awful.key({ altkey }, "h", function (c) awful.client.moveresize( 0,   0,  -20,   0) end),  

	awful.key({ altkey,"Shift" }, "j", function (c) awful.client.moveresize( 0,   0,   0,   40) end),  
	awful.key({ altkey,"Shift"}, "k", function (c) awful.client.moveresize( 0,   0,   0,   -40) end),  
	awful.key({ altkey,"Shift" }, "l", function (c) awful.client.moveresize( 0,   0,   40,   0) end),  
	awful.key({ altkey,"Shift" }, "h", function (c) awful.client.moveresize( 0,   0,  -40,   0) end),  

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
        end
    end),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(1) end),
    awful.key({ altkey, "Control" }, "=", function () lain.util.useless_gaps_resize(-1) end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal2) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ altkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ altkey, "Control"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ altkey, "Control"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Widgets popups
    awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end),
    -- awful.key({ altkey, }, "h", function () fshome.show(7) end),
    awful.key({ altkey, }, "w", function () myweather.show(7) end),

    -- ALSA volume control
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer set %s 1%%+", volume.channel))
            volume.update()
        end),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer set %s 1%%-", volume.channel))
            volume.update()
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer set %s toggle", volume.togglechannel or volume.channel))
            volume.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", volume.channel))
            volume.update()
        end),

    -- MPD control
    awful.key({ }, "XF86AudioNext",
        function ()
            awful.spawn.with_shell("cmus-remote --next || mpc next || ncmpc next || pms next")
            mpdwidget.update()
        end),
    awful.key({ }, "XF86AudioPrev",
        function ()
            awful.spawn.with_shell("cmus-remote --prev || mpc prev || ncmpc prev || pms prev")
            mpdwidget.update()
        end),
    awful.key({ }, "XF86AudioPlay",
        function ()
            awful.spawn.with_shell("cmus-remote --pause || mpc toggle || ncmpc toggle || pms toggle")
            mpdwidget.update()
        end),
    --]]

    -- Copy primary to clipboard
    awful.key({ modkey }, "c", function () os.execute("xsel | xsel -b") end),

    -- User programs
    awful.key({ modkey }, "q", function () awful.spawn(browser) end),
    awful.key({ modkey }, "e", function () awful.spawn(gui_editor) end),

    -- Default
    -- Prompt
    awful.key({ modkey, "Shift" }, "r", function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "r", function () awful.spawn(launcher) end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
)

clientkeys = awful.util.table.join(

    -- teleporting
	awful.key({ modkey },  "[",     function (c) handTiler.tp(c, 'right-top')    end),
    awful.key({ modkey },  "p",     function (c) handTiler.tp(c, 'left-top')     end),
    awful.key({ modkey },  ";",     function (c) handTiler.tp(c, 'left-bottom')  end),
    awful.key({ modkey },  "'",     function (c) handTiler.tp(c, 'right-bottom') end),
    awful.key({ modkey },  "\\",    function (c) handTiler.tp(c, 'middle')       end),
    -- awful.key({ modkey },  "\\",    function (c) awful.placement.centered(c.focus)     end),


    awful.key({ altkey, "Shift"   }, "m",      lain.util.magnify_client                         ),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ altkey }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = true } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized_horizontal = true,
                         maximized_vertical = true } },
    { rule = { class = "Steam"},
          properties = { floating = true},},
    { rule = { name = "TeamSpeak*"},
          properties = { floating = true},}
}
-- }}}

-- {{{ Signals
for s in screen do
    s.padding = beautiful.padding
end

dynamic_tagging = function() 
	for s = 1, screen.count() do
		-- get a list of all tags 
		local atags = awful.tag.gettags(s)
		-- set the standard icon
		for i, t in ipairs(atags) do
			t.name = tag_icon
		end

		-- get a list of all running clients
		local clist = client.get(s)
		for i, c in ipairs(clist) do
			-- get the tags on which the client is displayed
			local ctags = c:tags()
			for i, t in ipairs(ctags) do
				-- set active icon
				t.name = tag_icon_active
			end
		end
	end
end 

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- dynamic_tagging()
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized then
            c.border_width = 0
        -- no borders if only 1 client visible
        elseif #awful.client.visible(mouse.screen) > 1 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- }}}

-- vim: fdm=marker
