---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

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
	
	local aniFoot = display.newImage("images/cover-sock-and-foot-pos-1.png")
	aniFoot.anchorX = 0
	aniFoot.anchorY = 0	
	aniFoot.x = cover.x + localInsetX * 5.85 -- working magic number
	aniFoot.y = cover.y + localInsetY * 12.9 -- working magic number
	aniFoot:scale(scaleX,scaleX)
	sceneGroup:insert(aniFoot)	
	
	local aniArm = display.newImage("images/cover-arm-pos-1.png")
	aniArm.anchorX = 0
	aniArm.anchorY = 0
	aniArm.x = cover.x + localInsetX * 5.8 -- working magic number
	aniArm.y = cover.y + localInsetY * 3.7-- working magic number
	aniArm:scale(scaleX,scaleX)
	sceneGroup:insert(aniArm)	
	
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
		transition.to(sceneGroup, {time = 500, y = 0, onComplete=function() transition.to(menuGroup, {500, x = 0}) end})
		composer.gotoScene("scene1", {time=500,effect="crossFade"})		
		return true
	end
	local function gotoRecord(event)
		isRecord = true
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
	recordBtn.y = display.contentHeight - yInset * 4
	recordBtn:scale(scaleX*5/6,scaleX*5/6)
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
