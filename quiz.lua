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

--local prevBtn = display.newImage("images/Previous-Page-arrow.png")



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

local color = {0,150/255,14/255}
local strokeWidth = 8

function newTouchListener (event)
	if (event.phase == "began")then
		isTouched = true
		iX = event.x
		iY = event.y
		
		circle = display.newCircle(iX, iY,strokeWidth/2)
		circle:setFillColor(color[1],color[2],color[3])
		line = display.newLine(iX,iY,iX,iY)
		line.anchorX = 0
		line.anchorY = 0
		line:setStrokeColor(color[1],color[2],color[3])
		line.strokeWidth = strokeWidth
		
		--linegrid:insert(circle)
		--linegrid:insert(line)
	elseif (event.phase == "moved") then
		if (isTouched)then
			line:removeSelf()
			line = nil
			
			if (circle1 ~= nil) then
				circle1:removeSelf()
				circle1 = nil
			end
			
			circle1 = display.newCircle(event.x,event.y,strokeWidth/2)
			circle1:setFillColor(color[1],color[2],color[3])
			line = display.newLine( iX, iY, event.x , event.y )
			line.anchorX =0
			line.anchorY =0
			line:setStrokeColor( color[1],color[2],color[3])
			line.strokeWidth = SW
		end
	end
	return true
end	
		




math.randomseed(os.time())

function scene:create( event )
	local sceneGroup = self.view
	local bg = display.newRect(0,0,display.contentWidth,display.contentHeight)
	bg.anchorX = 0
	bg.anchorY = 0
	sceneGroup:insert(bg)
	
	local rand = math.random
	local itterations = #quiz
	local j
	local newQuiz = quiz
	for i=itterations,2,-1 do
		j = rand(i)
		newQuiz[i], newQuiz[j] = newQuiz[j], newQuiz[i]
	end	
	-- local qGroup = display.newRect(xInset*2,yInset,xInset*16,yInset*#newQuiz*3.9)
	-- qGroup.anchorX = 0
	-- qGroup.anchorY = 0
	-- qGroup.alpha = 0
	-- qGroup.isHitTestable = true
	
	currentLink = 0
	
	for i=1,#newQuiz do			
		local quizQ = display.newImage("images/"..sceneName.."/"..newQuiz[i].question..".png")
		quizQ.anchorX = 0
		quizQ.anchorY = 0
		quizQ.x = xInset * 2 
		quizQ.y = ((i-1) * yInset * #newQuiz) + yInset
		quizQ.link = newQuiz[i].link
		local scaleX = xInset * 1.5 * #newQuiz/quizQ.contentWidth
		quizQ:scale(scaleX,scaleX)
		quizQ:addEventListener("tap",function() currentLink = quizQ.link print(currentLink) end)
	end
	
	local newAns = quiz
	for i=itterations,2,-1 do
		j = rand(i)
		newAns[i], newAns[j] = newAns[j], newAns[i]
	end	
	
	for i=1,#newAns do			
		local quizA = display.newImage("images/"..sceneName.."/"..newAns[i].answer..".png")
		quizA.anchorX = 0
		quizA.anchorY = 0
		quizA.x = xInset * 12 
		quizA.y = ((i-1) * yInset * #newAns) + yInset
		quizA.link = newAns[i].link
		local scaleX = xInset * 1.5 * #newAns/quizA.contentWidth
		quizA:scale(scaleX,scaleX)
		quizA:addEventListener("tap",function() if (currentLink == quizA.link)then print ("YAY") end end)
		--sceneGroup:insert(quizA)
	end
	--qGroup:addEventListener("touch",newTouchListener)
	
	local gradient = display.newRect(0, display.contentHeight - yInset*2, display.contentWidth, yInset*2)
	gradient.anchorX = 0
	gradient.anchorY = 0
	
	local gradientColor = {
		type="gradient",
		color1={0,150/255,14/255}, color2={1,1,1}, direction="up"
	}
	
	gradient:setFillColor(gradientColor)
	sceneGroup:insert(gradient)
	
	-- local function gotoHome(event)
		-- transition.to(sceneGroup,{time= 500, onComplete=function() transition.to(sceneGroup, {time= 500}) end})
		-- composer.gotoScene("menu", {time=500, effect="crossFade"})
		-- return true
	-- end
	
	-- local homeBtn = display.newImage("images/home.png")
	-- homeBtn.anchorX = 0
	-- homeBtn.anchorY = 0
	-- homeBtn.x = xInset *0.5
	-- homeBtn.y = yInset /2
	-- homeBtn:scale(scaleX*3,scaleX*3)
	-- homeBtn:addEventListener("tap",gotoHome)
	-- sceneGroup:insert(homeBtn)	
	
	-- local function gotoNext(event)
		-- transition.to(sceneGroup,{time= 500, y = 0, onComplete=function() transition.to(sceneGroup, {time= 500, y = 0}) end})
		-- composer.gotoScene("home", {time=500,effect="crossFade"})

		-- return true
	-- end
	
	-- local function gotoPrev(event)
		-- transition.to(sceneGroup,{time= 500, onComplete=function() transition.to(sceneGroup, {time= 500}) end})
		-- local prv = maxScenes
		-- composer.gotoScene("scene"..tostring(prv), {time=500, effect="crossFade"})
		-- return true
	-- end
	
	-- prevBtn.anchorX = 0
	-- prevBtn.anchorY = 0
	-- prevBtn.x = xInset * 2
	-- prevBtn.y = display.contentHeight - yInset * 3
	-- prevBtn:scale(scaleX*2,scaleX*2)
	-- prevBtn.alpha = 0
	-- prevBtn:addEventListener("tap",gotoPrev)
	-- sceneGroup:insert(prevBtn)	
	
	-- nextBtn.anchorX = 0
	-- nextBtn.anchorY = 0
	-- nextBtn.x = display.contentWidth - xInset * 6
	-- nextBtn.y = display.contentHeight - yInset * 3
	-- nextBtn:scale(scaleX*2,scaleX*2)
	-- nextBtn.alpha = 0
	-- nextBtn:addEventListener("tap",gotoNext)
	-- sceneGroup:insert(nextBtn)	
	

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
