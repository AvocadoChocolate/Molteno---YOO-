---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

local coverArm = require("cover-arm")
local coverSock = require("cover-sock")

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------
local xInset, yInset = display.contentWidth / 20, display.contentHeight / 20


function scene:create( event )
    local sceneGroup = self.view
	isRecord = nil
	local bg = display.newRect(0,0,display.contentWidth,display.contentHeight)
	bg.anchorX = 0
	bg.anchorY = 0
	sceneGroup:insert(bg)
	
	local yooTitle = display.newImage("images/yoo-title-pos-1.png")
	yooTitle.anchorX = 0
	yooTitle.anchorY = 0
	yooTitle.x = xInset * 2
	yooTitle.y = yInset 
	yooTitle:scale(xInset*16/yooTitle.contentWidth, xInset*16/yooTitle.contentWidth)
	sceneGroup:insert(yooTitle)
	

	local cover = display.newImage("images/cover-background.png")
	cover.anchorX = 0
	cover.anchorY = 0
	cover.x = xInset*2.5
	cover.y = yInset*5	
	local scaleX = xInset*15/cover.contentWidth
	cover:scale(scaleX, scaleX)	
	sceneGroup:insert(cover)
	
	
	local localInsetX, localInsetY = cover.contentWidth/20, cover.contentHeight/20
	
	local sheet_Foot = graphics.newImageSheet("images/cover-sock.png",coverSock:getSheet())

	local sequences_foot= {
		{
			name="foot",
			start=1,
			count=2,
			time= 500,
			loopCount = 0,
			loopDirection = "forward"
		}
	}
	local movingFoot = display.newSprite(sheet_Foot,sequences_foot)
	movingFoot.anchorX = 0
	movingFoot.anchorY = 0
	movingFoot.x = cover.x + localInsetX * 5.85 -- working magic number
	movingFoot.y = cover.y + localInsetY * 12.9-- working magic number
	movingFoot:scale(scaleX,scaleX)
	sceneGroup:insert(movingFoot)
	movingFoot:play()
	
	
	
	
	local sheetOptionsArm =
	{
		width = 75,
		height = 78,
		numFrames = 2
	}
	local sheet_Arm = graphics.newImageSheet("images/cover-arm.png",sheetOptionsArm)
	local sequences_Arm = {
		{
			name="normalArm",
			start=1,
			count=2,
			time= 500,
			loopCount = 0,
			loopDirection = "forward"
		}
	}
	
	local movingArm = display.newSprite(sheet_Arm,sequences_Arm)
	
	
	--local aniArm = display.newImage("images/cover-arm-pos-1.png")
	movingArm.anchorX = 0
	movingArm.anchorY = 0
	movingArm.x = cover.x + localInsetX * 5.8 -- working magic number
	movingArm.y = cover.y + localInsetY * 3.7-- working magic number
	movingArm:scale(scaleX,scaleX)
	sceneGroup:insert(movingArm)
	movingArm:play()
	
	local gradient = display.newRect(0, display.contentHeight - yInset*2, display.contentWidth, yInset*2)
	gradient.anchorX = 0
	gradient.anchorY = 0
	
	local gradientColor = {
		type="gradient",
		color1={0,150/255,14/255}, color2={1,1,1}, direction="up"
	}
	
	gradient:setFillColor(gradientColor)
	sceneGroup:insert(gradient)
	
	local function gotoRead(event)
		isRecord = false
		audio.stop()
		transition.to(sceneGroup, {time = 500, y = 0, onComplete=function() transition.to(menuGroup, {500, x = 0}) end})
		composer.gotoScene("scene1", {time=500,effect="crossFade"})		
		return true
	end
	local function gotoRecord(event)
		isRecord = true
		audio.stop()
		transition.to(sceneGroup, {time = 500, y = 0, onComplete=function() transition.to(menuGroup, {500, x = 0}) end})
		composer.gotoScene("scene1", {time=500,effect="fade"})		
		return true
	end
	
	local readBtn = display.newImage("images/read-button.png")
	readBtn.anchorX = 0
	readBtn.anchorY = 0
	readBtn.x = xInset * 3
	readBtn.y = display.contentHeight - yInset * 4
	readBtn:scale(scaleX*5/6,scaleX*5/6)
	readBtn:addEventListener("tap", gotoRead)
	sceneGroup:insert(readBtn)
	
	local recordBtn = display.newImage("images/record-voice-button.png")
	recordBtn.anchorX = 0
	recordBtn.anchorY = 0
	recordBtn.x = display.contentWidth - xInset * 6
	recordBtn.y = display.contentHeight - yInset * 3.7
	recordBtn:scale(scaleX*2/3,scaleX*2/3)
	recordBtn:addEventListener("tap", gotoRecord)
	sceneGroup:insert(recordBtn)

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
		
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        -- we obtain the object by id from the scene's object hierarchy    
        audio.play(audio.loadSound("sounds/cover.wav"))
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
