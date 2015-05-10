--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-06
-- Time: 15:06
-- To change this template use File | Settings | File Templates.




---LISTENER : pointChange
----------------event.points



local pointsCreator ={}

pointsCreator.x=0;
pointsCreator.y=0;



pointsCreator.create=function()



    local pointsIndicator=display.newGroup()

    pointsIndicator.textValue=0;


    local pointListener=function(event)

        if(event.points+pointsIndicator.textValue>pointsIndicator.textValue) then


            local changeSize
            changeSize=function()

                if pointsIndicator.value.params==nil then
                    pointsIndicator.textValue=event.points+pointsIndicator.textValue
                    pointsIndicator.value.text=pointsIndicator.textValue

                pointsIndicator.value.params=
                {
                    xScale=1.2,
                    yScale=1.2,
                    time=300,
                    onComplete=changeSize
                }
                pointsIndicator.value:setFillColor(1,1,0)
                else
                pointsIndicator.value.params=
                {
                    xScale=1,
                    yScale=1,
                    time=100,
                    onComplete=function() pointsIndicator.value.params=nil  pointsIndicator.value:setFillColor(1,1,1) end

                }



                end

                transition.scaleTo(pointsIndicator.value,pointsIndicator.value.params)
            end

        changeSize()
        else
        --todo: what if there are many transmision in the same time
            local changeSizeDown
            changeSizeDown=function()

                if pointsIndicator.value.params==nil then
                    pointsIndicator.textValue=event.points+pointsIndicator.textValue
                    pointsIndicator.value.text=pointsIndicator.textValue

                    pointsIndicator.value.params=
                    {
                        xScale=0.8,
                        yScale=0.8,
                        time=300,
                        onComplete=changeSizeDown

                    }
                    pointsIndicator.value:setFillColor(1,0,0)
                else
                    pointsIndicator.value.params=
                    {
                        xScale=1,
                        yScale=1,
                        time=100,
                        onComplete=function() pointsIndicator.value.params=nil  pointsIndicator.value:setFillColor(1,1,1) end

                    }



                end

                transition.scaleTo(pointsIndicator.value,pointsIndicator.value.params)
            end
            changeSizeDown()
        end
        print("called")



    end
    --todo: Add listener to pointsIndicator

    pointsIndicator.draw=function()

        pointsIndicator.rect=display.newRoundedRect(0,0,200,100,5);
        pointsIndicator.rect.strokeWidth=10

        pointsIndicator.rect:setFillColor(1,1,0,0.3)
        pointsIndicator.rect:setStrokeColor(1,1,1,0.2)
        --pointsIndicator.rect:setStrokeColor(0.9,0.4,0,1)

        pointsIndicator:insert(pointsIndicator.rect)


        local params=
        {
            text=pointsIndicator.textValue,
            x=0,
            y=0,
            font = native.systemFontBold,
            fontSize = 50
        }


        pointsIndicator.value=display.newText(params)
        pointsIndicator:insert(pointsIndicator.value)





        Runtime:addEventListener("pointChange",pointListener)

    end


    pointsIndicator.remove=function()

        pointsIndicator:addEventListener("pointChange",pointListener)
        pointsIndicator:removeSelf()

    end


    return pointsIndicator

end


return pointsCreator