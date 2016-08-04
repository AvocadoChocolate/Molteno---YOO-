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

-- $ is line break
sceneTxt = {
{"Lesokisi","la","ka","le","kae?","$","Le","ka","ba","le","le","ka","mo..."},
{"Yoo!"},
{"Lesokisi","la","ka","le","kae?","$","Le","ka","ba","le","le","ka","mo..."},
{"Yoo!"},
{"Lesokisi","la","ka","le","kae?","$","Le","ka","ba","le","le","ka","mo..."},
{"Yoo!"},
{"Lesokisi","la","ka.","$","Le","ka","mo!"}}

-- {scene{word{start, end}}}
txtTimings = {
{{0,0.567},{0.567,0.738},{0.738,0.871},{0.871,1.009},{1.009,1.605},{0,0},{1.605,1.739},{1.739,1.851},{1.851,1.951},{1.951,2.056},{2.076,2.182},{2.182,2.3},{2.3,2.586}},
{{0,1.28}},
{{0,0.6},{0.6,0.738},{0.738,0.871},{0.871,1.009},{1.009,1.605},{0,0},{1.605,1.739},{1.739,1.851},{1.851,1.951},{1.951,2.056},{2.076,2.182},{2.182,2.3},{2.3,2.586}},
{{0,1.123}},
{{0,0.749},{0.567,0.738},{0.738,0.871},{0.871,1.009},{1.009,1.605},{0,0},{1.605,1.739},{1.739,1.851},{1.851,1.951},{1.951,2.056},{2.076,2.182},{2.182,2.3},{2.3,2.586}},
{{0,1.332}},
{{0,0.555},{0.555,1.042},{1.042,1.394},{0,0},{1.394,1.606},{1.606,1.971},{1.971,2.429}}
}

sceneImages = {
{background="scene1-background", 
	parts={
		{x=6.2, y=2, file="Scene-1-boy-pos-2-Arm-1"},
		{x=3.4,y=3.5,file="scene-1-boy-pos-2"},
		{x=11.5,y=6.3,file="scene-1-spider-pos-1"},
		{x=2.6,y=11.8,file="Scene-1-boy-pos-2-Sock-1"},
		{x=9.15,y=3.5,file="Scene-1-flame-pos-1"}
		}},
{background="scene2-background",
	parts={
		{x=11.65,y=1.7,file="Scene-2-head-pos-1"},
		{x=7.5,y=7.35,file="Scene-2-clock-pos-1"}
	}},
{background="scene3-background",
	parts={
		{x=6.8,y=7,file="Scene-3-arm-pos-1"},
		{x=5.5,y=14,file="Scene-3-leg-pos-1"},
		{x=12.2,y=13.25,file="Scene-3-snake-pos-1"},
		{x=3.8,y=13.5,file="Scene-3-Sock-pos-1"}
	}},
{background="scene4-background",
	parts={		
		{x=9,y=9.25,file="Scene-4-Head-Pos-1"},
		{x=9.7,y=12.75,file="Scene-4-Lid-Pos-1"},
		{x=9.18,y=12.9,file="Scene-4-Arms-Pos-1"},
		{x=3.5,y=13,file="Scene-4-Sock-Pos-1"}
	}},
{background="scene5-background",
	parts={		
		{x=17.6,y=11.5,file="Scene-5-Sock-Pos-1"},		
		{x=4.45,y=10.2,file="Scene-5-Tub-water-Pos-1"},
		{x=9.25,y=12,file="Scene-5-Splash-Pos-1"},
		{x=6,y=1.3,file="Scene-5-Sister-Pos-1"}
	}},
{background="scene6-background",
	parts={
		{x=6,y=4.35,file="Scene-6-Arm-Pos-1"},
		{x=8.3,y=0.5,file="Scene-6-Head-Pos-1"},
		{x=7.15,y=15.6,file="Scene-6-Water-Pos-1"}
	}},
{background="scene7-background",
	parts={
		{x=3.3,y=3.5,file="Scene-7-Boy-Pos-1"},
		{x=8.4,y=11,file="Scene-7-Arm-and-sock-Pos-1"},
		{x=10.87,y=11.27,file="Scene-7-Baby-head-Pos-1"}		
	}}
}

quiz=
{{question="Quiz-No-1",answer="Answer-C",link=1},
{question="Quiz-No-2",answer="Answer-A",link=2},
{question="Quiz-No-3",answer="Answer-D",link=3},
{question="Quiz-No-4",answer="Answer-B",link=4}}

fadeTime = 500
maxScenes = 7
spacing = 2

-- load menu
composer.gotoScene( "menu" )
