--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-09
-- Time: 15:23
-- To change this template use File | Settings | File Templates.
--

--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-08
-- Time: 11:23
-- To change this template use File | Settings | File Templates.
--

--- EVENT: timesUp

local targetGenerator = require("targetGenerator")
local p=require("properties")

local targetChainGenerator = {}


targetChainGenerator.create = function()

    local listenerTrap=function() return true end
    local targetsChain = display.newGroup()
    targetsChain.orderChain = function(arrayOftypes)

        targetsChain.internalChain = arrayOftypes
    end
    targetsChain.draw = function(width, height)


        if width == nil then width = 200 height = 100 end

        local params =
        {
            text = 0,
            x = 0,
            y = 0,
            font = native.systemFontBold,
            fontSize = 50
        }


        targetsChain.text = display.newText(params)
        targetsChain.text.value = 0;
        targetsChain.rect = display.newRoundedRect(0, 0, width, height, 5);

        targetsChain:insert(targetsChain.text)
        targetsChain:insert(targetsChain.rect)

        targetsChain.rect:setFillColor(1, 0.9, 0, 0.8)
        --targetsChain.rect.strokeWidth=10
        --targetsChain.rect:setStrokeColor(0.6,0.9,0,1)

        local w=20

        local newX=(#targetsChain.internalChain+1)*(w*1.25)/2


        for i = 1, #targetsChain.internalChain do
            local rect=targetGenerator.create(targetsChain.internalChain[i], 20, 20)
            rect.y=i*w*1.25-newX

            targetsChain:insert(rect)

        end

        targetsChain:addEventListener("touch",listenerTrap)

    end

    targetsChain.remove = function()

        targetsChain:removeEventListener("touch",listenerTrap)
        targetsChain:removeSelf();
    end

    return targetsChain
end
return targetChainGenerator















