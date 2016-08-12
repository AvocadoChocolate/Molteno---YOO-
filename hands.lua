--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:4d59555df059d994469668f98ed51b4b:5157fc4a6fc835c128c786ba743a6f35:af6a49ff4bb5dd15881ee3d3edf6f7a1$
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
            -- Scene-1-boy-pos-2-Arm-1_e_e
            x=93,
            y=1,
            width=58,
            height=86,

        },
        {
            -- Scene-1-boy-pos-2-Arm-2_e_e
            x=1,
            y=1,
            width=48,
            height=88,

        },
        {
            -- Scene-1-boy-pos-2-Arm-3_e_e
            x=51,
            y=1,
            width=40,
            height=88,

        },
    },
    
    sheetContentWidth = 152,
    sheetContentHeight = 90
}

SheetInfo.frameIndex =
{

    ["Scene-1-boy-pos-2-Arm-1_e_e"] = 1,
    ["Scene-1-boy-pos-2-Arm-2_e_e"] = 2,
    ["Scene-1-boy-pos-2-Arm-3_e_e"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
