local sceneName = ...

local composer = require( "composer" )

local scene = composer.newScene( sceneName )

local curScene = tonumber(sceneName:sub(6,6))

local xInset, yInset = display.contentWidth / 20, display.contentHeight / 20

local sceneImg = sceneImages[curScene]
local sceneParts = sceneImg.parts
local timings = txtTimings[curScene]

local prevBtn = display.newImage("images/Previous-Page-arrow.png")
local nextBtn = display.newImage("images/Next-Page-arrow.png")
local recordBtn = display.newImage("images/record-voice-button.png")
local homeBtn = display.newImage("images/home.png")
local playBtn = display.newImage("images/play.png")
local pauseBtn = display.newImage("images/pause.png")

local isPlaying = true
local isFinished = false
local isRecording = false

local sentenceTable = {}

local r=nil
local recordingPath = system.pathForFile(sceneName.."-recording.wav", system.DocumentsDirectory)

local curWord = 1

local function showPrevNext(event)
	if (curScene == 1) then
		transition.fadeIn(nextBtn, {time=fadeTime})
	else
		transition.fadeIn(prevBtn, {time=fadeTime})
		transition.fadeIn(nextBtn, {time=fadeTime})
	end
	if (isRecord)then
		transition.fadeIn(recordBtn, {time=fadeTime})
	end
	
	return true
end

local function hideAll()
	transition.fadeOut(prevBtn, {time=fadeTime})
	transition.fadeOut(nextBtn, {time=fadeTime})
	transition.fadeOut(playBtn, {time=fadeTime})
	transition.fadeOut(pauseBtn, {time=fadeTime})
	transition.fadeOut(homeBtn, {time=fadeTime})
end

local function showAll()
	if (curScene == 1) then
		transition.fadeIn(nextBtn, {time=fadeTime})
	else
		transition.fadeIn(prevBtn, {time=fadeTime})
		transition.fadeIn(nextBtn, {time=fadeTime})
	end
	transition.fadeIn(playBtn, {time=fadeTime})
	transition.fadeIn(homeBtn, {time=fadeTime})
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
	if (isPlaying or isRecording) then
		 if (curWord == 1) then
			clearHighlight()
			if (isRecording) then
				r:startRecording()
				hideAll()
				print ("started recording")
			end
		 end
		local curSceneText = sceneTxt[curScene]
		if (curSceneText[curWord] == "$") then
			curWord = curWord + 1
		end	
		
		local word = sentenceTable[curWord]
		if (word ~= nil)then
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
										if (isRecording)then
											isRecording = false
											r:stopRecording()
											showAll()
											print ("stopped recording")
										end
										end)
			end	
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
	
	homeBtn.anchorX = 0
	homeBtn.anchorY = 0
	homeBtn.x = xInset *0.5
	homeBtn.y = yInset /2
	homeBtn:scale(scaleX/1.3,scaleX/1.3)
	homeBtn:addEventListener("tap",gotoHome)
	sceneGroup:insert(homeBtn)	
	
	local function record(event)
		isRecording = true	
		
		local exist, err = io.open(recordingPath,"r")
		if (exist)then
			io.close(exist)
			os.remove(recordingPath)
		end
		r = media.newRecording(recordingPath)
		curWord = 1
		highlightWords()
	end
	
	recordBtn.anchorX = 0
	recordBtn.anchorY = 0
	recordBtn.x = display.contentWidth - xInset * 4
	recordBtn.y = yInset/2
	recordBtn:scale(scaleX*0.75,scaleX*0.75)
	recordBtn.isVisible = false
	recordBtn:addEventListener("tap",record)
	recordBtn.alpha = 0
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
	prevBtn:scale(scaleX,scaleX)
	prevBtn.alpha = 0
	prevBtn:addEventListener("tap",gotoPrev)
	sceneGroup:insert(prevBtn)	
	
	nextBtn.anchorX = 0
	nextBtn.anchorY = 0
	nextBtn.x = display.contentWidth - xInset * 6
	nextBtn.y = display.contentHeight - yInset * 3
	nextBtn:scale(scaleX,scaleX)
	nextBtn.alpha = 0
	nextBtn:addEventListener("tap",gotoNext)
	sceneGroup:insert(nextBtn)	
	
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
	pauseBtn:scale(scaleX/2,scaleX/2)
	pauseBtn:addEventListener("tap",pressPause)
	sceneGroup:insert(pauseBtn)
	
	local function pressPlay(event)
		audio.dispose(sentenceChannel)
		audio.dispose(sentenceSound)
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
			sentenceChannel = audio.play(sentenceSound, {onComplete= function()
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
	playBtn:scale(scaleX/2,scaleX/2)
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
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
		recordBtn.isVisible = isRecord
		playBtn.alpha = 0
		pauseBtn.alpha = 1
		isFinished = false
		curWord = 1
      
    elseif phase == "did" then	
		audio.dispose(sentenceChannel)
		audio.dispose(sentenceSound)
		
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
        sentenceChannel = audio.play(sentenceSound, {onComplete= function()
				isPlaying = false
				isFinished = true
				curWord = 1
				showPrevNext()
				transition.fadeOut(pauseBtn,{time=fadeTime/3})
				transition.fadeIn(playBtn, {time=fadeTime/3}) end})      
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
    elseif phase == "did" then
		composer.removeScene(sceneName,false)
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
