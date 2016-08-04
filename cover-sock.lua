--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:cf9cac71c081bec9029584ace400dba2:def25f22d417685bd1ce98cf22603b09:a6b07970706992eb2b8ad6f9ee16220b$
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
            -- cover-sock-and-foot-pos-1
            x=1,
            y=1,
            width=111,
            height=126,

        },
        {
            -- Cover-Sock-and-foot-Pos-2
            x=1,
            y=129,
            width=111,
            height=121,

        },
    },
    
    sheetContentWidth = 113,
    sheetContentHeight = 251
}

SheetInfo.frameIndex =
{

    ["cover-sock-and-foot-pos-1"] = 1,
    ["Cover-Sock-and-foot-Pos-2"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

function SheetInfo:getFrames()
	return self.sheet.frames;
end

return SheetInfo
