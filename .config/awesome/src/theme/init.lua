--------------------------------------------------
--  ██████╗██████╗ ██╗   ██╗██╗     ██╗ █████╗  --
-- ██╔════╝██╔══██╗╚██╗ ██╔╝██║     ██║██╔══██╗ --
-- ██║     ██████╔╝ ╚████╔╝ ██║     ██║███████║ --
-- ██║     ██╔══██╗  ╚██╔╝  ██║     ██║██╔══██║ --
-- ╚██████╗██║  ██║   ██║   ███████╗██║██║  ██║ --
--  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝╚═╝  ╚═╝ --
--------------------------------------------------
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

Theme_path = awful.util.getdir("config") .. "/src/theme/"
Theme = {}

dofile(Theme_path .. "theme_variables.lua")

Theme.awesome_icon = Theme_path .. "../assets/icons/ArchLogo.png"
Theme.awesome_subicon = Theme_path .. "../assets/icons/ArchLogo.png"


beautiful.init(Theme)
