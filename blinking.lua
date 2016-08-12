--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:0036b9407ae5796386ffc05428fb42f6:87048d70032cc248535c01a02c24f158:a72a535e7b21e9518552ed87b0d7c7ca$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- Scene-1-boy-pos-1-Blink_e_e
            x=1,
            y=1,
            width=20,
            height=9,

        },
        {
            -- Scene-1-boy-pos-2-Blink_e_e
            x=23,
            y=1,
            width=3,
            height=3,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 20,
            sourceHeight = 9
        },
    },
    
    sheetContentWidth = 27,
    sheetContentHeight = 11
}

SheetInfo.frameIndex =
{

    ["Scene-1-boy-pos-1-Blink_e_e"] = 1,
    ["Scene-1-boy-pos-2-Blink_e_e"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
