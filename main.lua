---------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

isRecord = false
fnt = "TeachersPet"

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
local fakeTiming = 2.586 / 12
local fakeTiming2 = 2.429 / 6

-- txtTimings = {
-- {{0,0.567},{0.567,0.738},{0.738,0.871},{0.871,1.009},{1.009,1.605},{0,0},{1.605,1.739},{1.739,1.851},{1.851,1.951},{1.951,2.056},{2.076,2.182},{2.182,2.3},{2.3,2.586}},
-- {{0,1.28}},
-- {{0,0.6},{0.6,0.738},{0.738,0.871},{0.871,1.009},{1.009,1.605},{0,0},{1.605,1.739},{1.739,1.851},{1.851,1.951},{1.951,2.056},{2.076,2.182},{2.182,2.3},{2.3,2.586}},
-- {{0,1.123}},
-- {{0,0.749},{0.567,0.738},{0.738,0.871},{0.871,1.009},{1.009,1.605},{0,0},{1.605,1.739},{1.739,1.851},{1.851,1.951},{1.951,2.056},{2.076,2.182},{2.182,2.3},{2.3,2.586}},
-- {{0,1.332}},
-- {{0,0.555},{0.555,1.042},{1.042,1.394},{0,0},{1.394,1.606},{1.606,1.971},{1.971,2.429}}
-- }


-- fake timings
txtTimings = {
	{{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,0},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming}},
	{{0,1.28}},
	{{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,0},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming}},
	{{0,1.28}},
	{{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,0},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming},{0,fakeTiming}},
	{{0,1.28}},
	{{0,fakeTiming2},{0,fakeTiming2},{0,fakeTiming2},{0,0},{0,fakeTiming2},{0,fakeTiming2},{0,fakeTiming2}}
	
}

sceneImages = {
{background="Scene1-background_e_e", 
	parts={
		{x=6.2, y=2, file="Scene-1-boy-pos-2-Arm-1_e_e"},
		{x=3.4,y=3.5,file="Scene-1-boy-pos-2_e_e"},
		{x=11.5,y=6.3,file="Scene-1-spider-pos-1_e_e"},
		{x=2.6,y=11.8,file="Scene-1-boy-pos-2-Sock-1_e_e"},
		{x=9.15,y=3.5,file="Scene-1-flame-pos-1_e_e"}
		}},
{background="scene2-background_e_e",
	parts={
		{x=11.65,y=1.7,file="Scene-2-head-pos-1_e_e"},
		{x=7.5,y=7.35,file="Scene-2-clock-pos-1_e_e"}
	}},
{background="scene3-background_e_e",
	parts={
		{x=6.8,y=7,file="Scene-3-arm-pos-1_e_e"},
		{x=5.5,y=14,file="Scene-3-leg-pos-1_e_e"},
		{x=12.2,y=13.25,file="Scene-3-snake-pos-1_e_e"},
		{x=3.8,y=13.5,file="Scene-3-Sock-pos-1_e_e"}
	}},
{background="scene4-background_e_e",
	parts={		
		{x=9,y=9.25,file="Scene-4-Head-Pos-1_e_e"},
		{x=9.7,y=12.75,file="Scene-4-Lid-Pos-1_e_e"},
		{x=9.18,y=12.9,file="Scene-4-Arms-Pos-1_e_e"},
		{x=3.5,y=13,file="Scene-4-Sock-Pos-1_e_e"}
	}},
{background="scene5-background_e_e",
	parts={		
		{x=17.6,y=11.5,file="Scene-5-Sock-Pos-1_e_e"},		
		{x=4.45,y=10.2,file="Scene-5-Tub-water-Pos-1_e_e"},
		{x=9.25,y=12,file="Scene-5-Splash-Pos-1_e_e"},
		{x=6,y=1.3,file="Scene-5-Sister-Pos-1_e_e"}
	}},
{background="scene6-background_e_e",
	parts={
		{x=6,y=4.35,file="Scene-6-Arm-Pos-1_e_e"},
		{x=8.3,y=0.5,file="Scene-6-Head-Pos-1_e_e"},
		{x=7.15,y=15.6,file="Scene-6-Water-Pos-1_e_e"}
	}},
{background="scene7-background_e_e",
	parts={
		{x=3.3,y=3.5,file="Scene-7-Boy-Pos-1_e_e"},
		{x=8.4,y=11,file="Scene-7-Arm-and-sock-Pos-1_e_e"},
		{x=10.87,y=11.27,file="Scene-7-Baby-head-Pos-1_e_e"}		
	}}
}

quiz=
{{question="Quiz-No-1_e",answer="Answer-C_e",link=1},
{question="Quiz-No-2_e",answer="Answer-A_e",link=2},
{question="Quiz-No-3_e",answer="Answer-D_e",link=3},
{question="Quiz-No-4_e",answer="Answer-B_e",link=4}}

fadeTime = 500
maxScenes = 7
spacing = 2

-- load menu
composer.gotoScene( "quiz")
