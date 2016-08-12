--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:54220af68c44e6c56d2df74cec402392:2de718616a1d02e539bea39363b7b196:e48a078b71eb74a185cb0df7d0486ff7$
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
            -- Scene-1-spider-pos-1_e_e
            x=1,
            y=1,
            width=77,
            height=50,

        },
        {
            -- Scene-1-spider-pos-2_e_e
            x=1,
            y=53,
            width=70,
            height=57,

        },
    },
    
    sheetContentWidth = 79,
    sheetContentHeight = 111
}

SheetInfo.frameIndex =
{

    ["Scene-1-spider-pos-1_e_e"] = 1,
    ["Scene-1-spider-pos-2_e_e"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
