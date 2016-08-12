--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:68325e77f155f455ba48e9497f23b137:2e58f12a51f436c75f742da87ff21f6d:a155b4c1437dbe1aa43599ee8b2329fa$
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
            -- Scene-1-boy-pos-2-Sock-1_e_e
            x=1,
            y=107,
            width=45,
            height=60,

        },
        {
            -- Scene-1-boy-pos-2-Sock-2_e_e
            x=1,
            y=51,
            width=49,
            height=54,

        },
        {
            -- Scene-1-boy-pos-2-Sock-3_e_e
            x=1,
            y=1,
            width=52,
            height=48,

        },
    },
    
    sheetContentWidth = 54,
    sheetContentHeight = 168
}

SheetInfo.frameIndex =
{

    ["Scene-1-boy-pos-2-Sock-1_e_e"] = 1,
    ["Scene-1-boy-pos-2-Sock-2_e_e"] = 2,
    ["Scene-1-boy-pos-2-Sock-3_e_e"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
