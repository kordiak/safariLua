--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-04-30
-- Time: 16:29
-- To change this template use File | Settings | File Templates.
--
local properties={};

local originX=display.screenOriginX;
local originY=display.screenOriginY;


properties.bottomSide=display.actualContentHeight;
properties.rightSide=display.actualContentWidth;

properties.types=
{
    red={1,0,0},
    blue={0,0,1}
}
properties.typesNum=2


properties.X=function(value)

    return value+originX;
end

properties.Y=function(value)

    return value+originY;
end

return properties;