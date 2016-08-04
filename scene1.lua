---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

local curScene = tonumber(sceneName:sub(6,6))

---------------------------------------------------------------------------------
local xInset, yInset = display.contentWidth / 20, display.contentHeight / 20

local sceneImg = sceneImages[curScene]
local sceneParts = sceneImg.parts
local timings = txtTimings[curScene]

local prevBtn = display.newImage("images/Previous-Page-arrow.png")
local nextBtn = display.newImage("images/Next-Page-arrow.png")
local recordBtn = display.newImage("images/record-voice-button.png")

local isPlaying = true
local isFinished = false
local isRecording = false
local sentenceTable = {}

local r

local curWord = 1

local recordingPath = system.pathForFile(sceneName.."-recording.wav", system.DocumentsDirectory)

local function showPrevNext(event)
	if (curScene == 1) then
		transition.fadeIn(nextBtn, {time=fadeTime})
	-- elseif (curScene == maxScenes) then
		-- transition.fadeIn(prevBtn, {time=fadeTime})
	else
		transition.fadeIn(prevBtn, {time=fadeTime})
		transition.fadeIn(nextBtn, {time=fadeTime})
	end
	return true
end

local function clearHighlight()
	local curSceneText = sceneTxt[curScene]
	for i=1,#curSceneText do
		if (curSceneText[i] ~= "$") then
			local oldWord = sentenceTable[i]
			oldWord:setFillColor(0,0,0)
		end
	end
end

local function highlightWords(event)
	if (isPlaying) then
		 if (curWord == 1) then
			clearHighlight()
		 end
		local curSceneText = sceneTxt[curScene]
		if (curSceneText[curWord] == "$") then
			curWord = curWord + 1
		end	
		
		local word = sentenceTable[curWord]
		word:setFillColor(0,150/255,14/255)
		local timingsPW = timings[curWord]
		local delayTime = (timingsPW[2] - timingsPW[1])*1000
		if (curWord < #curSceneText) then
			timer.performWithDelay(delayTime, function() 
										curWord = curWord + 1
										highlightWords()
										end)
		else
			timer.performWithDelay(delayTime, function() 
										--local oldWord = sentenceTable[#curSceneText]
										--oldWord:setFillColor(0,0,0)
										if (isRecording) then
											r:stopRecording()
										end
										end)
		end	
	else
	end
	return true
end

function scene:create( event )
	local sceneGroup = self.view
	local bg = display.newRect(0,0,display.contentWidth,display.contentHeight)
	bg.anchorX = 0
	bg.anchorY = 0
	sceneGroup:insert(bg)
	
	local image = display.newImage("images/"..sceneName.."/"..sceneImg.background..".png")
	image.anchorX = 0
	image.anchorY = 0
	image.x = xInset*1.5
	image.y = yInset*2.5	
	local scaleX = xInset*17/image.contentWidth
	image:scale(scaleX, scaleX)	
	sceneGroup:insert(image)
	
	local localInsetX, localInsetY = image.contentWidth/20, image.contentHeight/20
	
	for i=1,#sceneParts do			
		local aniPart = display.newImage("images/"..sceneName.."/"..sceneParts[i].file..".png")
		aniPart.anchorX = 0
		aniPart.anchorY = 0
		aniPart.x = image.x + localInsetX * sceneParts[i].x
		aniPart.y = image.y + localInsetY * sceneParts[i].y
		aniPart:scale(scaleX,scaleX)
		sceneGroup:insert(aniPart)
	end
	
	local gradient = display.newRect(0, display.contentHeight - yInset*2, display.contentWidth, yInset*2)
	gradient.anchorX = 0
	gradient.anchorY = 0
	
	local gradientColor = {
		type="gradient",
		color1={0,150/255,14/255}, color2={1,1,1}, direction="up"
	}
	
	gradient:setFillColor(gradientColor)
	sceneGroup:insert(gradient)
	
	local function gotoHome(event)
		transition.to(sceneGroup,{time= 500, onComplete=function() transition.to(sceneGroup, {time= 500}) end})
		composer.gotoScene("menu", {time=500, effect="crossFade"})
		return true
	end
	
	local homeBtn = display.newImage("images/home.png")
	homeBtn.anchorX = 0
	homeBtn.anchorY = 0
	homeBtn.x = xInset *0.5
	homeBtn.y = yInset /2
	homeBtn:scale(scaleX*3,scaleX*3)
	homeBtn:addEventListener("tap",gotoHome)
	sceneGroup:insert(homeBtn)	
	
	local function record(event)
		isRecording = true
		print ("recording")
		curWord = 1
		highlightWords()
		r = media.newRecording(recordingPath)
		r:startRecording()
	end
	
	recordBtn.anchorX = 0
	recordBtn.anchorY = 0
	recordBtn.x = display.contentWidth - xInset * 4
	recordBtn.y = yInset/2
	recordBtn:scale(scaleX*1.25,scaleX*1.25)
	recordBtn.isVisible = false
	recordBtn:addEventListener("tap",record)
	sceneGroup:insert(recordBtn)	
	
	local function gotoNext(event)
		transition.to(sceneGroup,{time= 500, y = 0, onComplete=function() transition.to(sceneGroup, {time= 500, y = 0}) end})
		local nxt = curScene+1
		if (nxt == maxScenes+1)then
			composer.gotoScene("quiz", {time=500,effect="crossFade"})
		else		
			composer.gotoScene("scene"..tostring(nxt), {time=500, effect="crossFade"})
		end
		return true
	end
	
	local function gotoPrev(event)
		transition.to(sceneGroup,{time= 500, onComplete=function() transition.to(sceneGroup, {time= 500}) end})
		local prv = curScene-1
		composer.gotoScene("scene"..tostring(prv), {time=500, effect="crossFade"})
		return true
	end
	
	prevBtn.anchorX = 0
	prevBtn.anchorY = 0
	prevBtn.x = xInset * 2
	prevBtn.y = display.contentHeight - yInset * 3
	prevBtn:scale(scaleX*2,scaleX*2)
	prevBtn.alpha = 0
	prevBtn:addEventListener("tap",gotoPrev)
	sceneGroup:insert(prevBtn)	
	
	nextBtn.anchorX = 0
	nextBtn.anchorY = 0
	nextBtn.x = display.contentWidth - xInset * 6
	nextBtn.y = display.contentHeight - yInset * 3
	nextBtn:scale(scaleX*2,scaleX*2)
	nextBtn.alpha = 0
	nextBtn:addEventListener("tap",gotoNext)
	sceneGroup:insert(nextBtn)	
	
	playBtn = display.newImage("images/play.png")
	pauseBtn = display.newImage("images/pause.png")
	
	local function pressPause(event)
		isPlaying = false
		transition.fadeOut(pauseBtn,{time=fadeTime/3})
		transition.fadeIn(playBtn, {time=fadeTime/3})
		audio.pause(sentenceChannel)
		return true
	end	
	
	pauseBtn.anchorX = 0
	pauseBtn.anchorY = 0
	pauseBtn.x = xInset * 7.9
	pauseBtn.y = display.contentHeight - yInset * 3
	pauseBtn:scale(scaleX*2,scaleX*2)
	pauseBtn:addEventListener("tap",pressPause)
	sceneGroup:insert(pauseBtn)
	
	local function pressPlay(event)
		if (isRecord)then
			local exist, err = io.open(recordingPath,"r")
			if (exist)then
				io.close(exist)
				sentenceSound = audio.loadSound(sceneName.."-recording.wav",system.DocumentsDirectory)
			else
				sentenceSound = audio.loadSound("sounds/"..sceneName..".mp3")
			end
		else
			sentenceSound = audio.loadSound("sounds/"..sceneName..".mp3")
		end
			
		isPlaying = true
		transition.fadeOut(playBtn,{time=fadeTime/3})
		transition.fadeIn(pauseBtn, {time=fadeTime/3})
		highlightWords()
		if (isFinished) then
			isFinished = false
			curWord=1
			audio.play(sentenceSound, {onComplete= function()
				curWord=1
				isPlaying = false
				isFinished = true
				showPrevNext()
				transition.fadeOut(pauseBtn,{time=fadeTime/3})
				transition.fadeIn(playBtn, {time=fadeTime/3}) end})
		else
			audio.resume(sentenceChannel)
		end
		return true
	end	
	
	playBtn.anchorX = 0
	playBtn.anchorY = 0
	playBtn.x = xInset * 7.9
	playBtn.y = display.contentHeight - yInset * 3
	playBtn:scale(scaleX*2,scaleX*2)
	playBtn:addEventListener("tap",pressPlay)
	playBtn.alpha = 0
	sceneGroup:insert(playBtn)
	
	local width = 0
	local textHeight = display.contentHeight - yInset*7
	local curSceneText = sceneTxt[curScene]
	for i=1,#curSceneText do
		if curSceneText[i] == "$" then
			width = 0
			textHeight = textHeight + yInset*1.25
		else
		local options =
		{
			text = curSceneText[i],
			font = fnt,
			fontSize = 36,
			align = "center"		
		}
		local mytext = display.newText(options)
		mytext.anchorX = 0
		mytext.anchorY = 0
		mytext:setFillColor(0,0,0)		
		mytext.x = xInset * 2 + width
		width = width + mytext.contentWidth + xInset/spacing
		mytext.y = textHeight
		
		sentenceTable[i] = mytext
		sceneGroup:insert(mytext)
		end
	end
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
		recordBtn.isVisible = isRecord
		playBtn.alpha = 0
		pauseBtn.alpha = 1
		isFinished = false
		curWord = 1
      
    elseif phase == "did" then
        -- Called when the scene is now on screen	
		
		highlightWords()
		if (isRecord)then
			local exist, err = io.open(recordingPath,"r")
			if (exist)then
				io.close(exist)
				sentenceSound = audio.loadSound(sceneName.."-recording.wav",system.DocumentsDirectory)
			else
				sentenceSound = audio.loadSound("sounds/"..sceneName..".mp3")
			end
		else
			sentenceSound = audio.loadSound("sounds/"..sceneName..".mp3")
		end
        audio.play(sentenceSound, {onComplete= function()
				isPlaying = false
				isFinished = true
				curWord = 1
				showPrevNext()
				transition.fadeOut(pauseBtn,{time=fadeTime/3})
				transition.fadeIn(playBtn, {time=fadeTime/3}) end})
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        -- we obtain the object by id from the scene's object hierarchy
       
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
		if (isPlaying) then
			audio.stop()
			isFinished = true
			isPlaying = false
			curWord = 1
		end
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		composer.removeScene(sceneName,false)
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
