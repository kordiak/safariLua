--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-04-30
-- Time: 16:28
-- To change this template use File | Settings | File Templates.
--




local p=require("properties")



local panelsGroup={}



panelsGroup.create=function()

    local object=display.newGroup();
    object.x=p.X(0)
    object.y=p.Y(0
    )

    object.draw=function(arrayOf)



        local drawBottom=function(size)

            local bottom={y=p.bottomSide-p.bottomSide/size /2,x=p.rightSide/2};
            object.bottom=display.newGroup()
            object.bottom.x=bottom.x
            object.bottom.y=bottom.y

            object:insert(object.bottom);



            object.bottom.background=display.newRect(0,0,p.rightSide,p.bottomSide/size);

            object.bottom:insert(object.bottom.background)


            object.setBottomColor=function(rgba)

                object.bottom.background:setFillColor(unpack(rgba,1,3))
            end

            object.bottomInsert=function(element,position,scale)

                local xScale=scale
                local yScale=scale

            if not scale then scale=1
            elseif type(scale)=="table" then
                xScale=scale.xScale
                yScale=scale.yScale

            end

                local fixedXPostion=p.rightSide/(3)*position
                element.xScale=scale
                element.yScale=scale
                object.bottom:insert(element)
                element.x=fixedXPostion
            end

        end

        local drawLeft=function(size)
            local left={y=p.bottomSide/2,x=p.X(0)+p.rightSide/size/2};
            object.left=display.newRect(left.x,left.y,p.rightSide/size,p.bottomSide);

        end
    if(arrayOf.bottom~=nil) then

        drawBottom(arrayOf.bottom.size);


    elseif(arrayOf.left~=nil)then

        drawLeft(arrayOf.left.size);
    end

    end



    object.remove=function()

        --object.img:removeSelf();
        object:removeSelf();

    end




    return object;

end
return panelsGroup;
