--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:c25dbdfea1a7749ac7f31761c2c509b5:22dd79c7d29c8e5031637dcf5f34d045:ac6b5e9b0068ded6ac31f2aa974540f7$
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
            -- cover-arm-pos-1
            x=75,
            y=1,
            width=74,
            height=74,

        },
        {
            -- Cover-Arm-Pos-2
            x=1,
            y=1,
            width=72,
            height=76,

        },
    },
    
    sheetContentWidth = 150,
    sheetContentHeight = 78
}

SheetInfo.frameIndex =
{

    ["cover-arm-pos-1"] = 1,
    ["Cover-Arm-Pos-2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
