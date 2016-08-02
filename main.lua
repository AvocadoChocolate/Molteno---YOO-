---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"
isRecord = false
-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)
fnt = "TeachersPet"

-- Add any system wide event handlers, location, key events, system resume/suspend, memory, etc.

sceneTxt = {
{"Lesokisi","la","ka","le","kae?","$","Le","ka","ba","le","le","ka","mo","..."},
{"Yoo!"},
{"Lesokisi","la","ka","le","kae?","$","Le","ka","ba","le","le","ka","mo","..."},
{"Yoo!"},
{"Lesokisi","la","ka","le","kae?","$","Le","ka","ba","le","le","ka","mo","..."},
{"Yoo!"},
{"Lesokisi","la","ka.","$","Le","ka","mo!"}}

sceneTime = {
{}
}

fadeTime = 500
maxScenes = 7
spacing = 2


-- load menu
composer.gotoScene( "scene2" )
