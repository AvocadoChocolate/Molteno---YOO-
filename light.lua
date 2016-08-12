--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:a73b734695af7d7d75002d572280dbdd:ba54a0f8168101c2d809bdfd3d057d8a:c1b0acb3c895428fe111e7b06e5aabcd$
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
            -- Scene-1-flame-pos-1_e_e
            x=1,
            y=1,
            width=33,
            height=33,

        },
        {
            -- Scene-1-flame-pos-2_e_e
            x=36,
            y=1,
            width=33,
            height=33,

        },
    },
    
    sheetContentWidth = 70,
    sheetContentHeight = 35
}

SheetInfo.frameIndex =
{

    ["Scene-1-flame-pos-1_e_e"] = 1,
    ["Scene-1-flame-pos-2_e_e"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
