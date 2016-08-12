--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:8ea958c4008ad073914815165d6eb3e1:f6a8640efe61ea43d95843d9386283b0:960bb90d5cb5a9d14041a3aea661bbf5$
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
            -- Scene-1-boy-pos-1_e_e
            x=1,
            y=1,
            width=220,
            height=305,

        },
        {
            -- Scene-1-boy-pos-2_e_e
            x=223,
            y=1,
            width=314,
            height=304,

        },
    },
    
    sheetContentWidth = 538,
    sheetContentHeight = 307
}

SheetInfo.frameIndex =
{

    ["Scene-1-boy-pos-1_e_e"] = 1,
    ["Scene-1-boy-pos-2_e_e"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
