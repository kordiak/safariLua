--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-08
-- Time: 11:23
-- To change this template use File | Settings | File Templates.
--

---EVENT: timesUp


local timerGenerator ={}


timerGenerator.create=function()

local timerBox =display.newGroup()

timerBox.draw=function(width,height)


    if width==nil then width=200 height=100 end

    local params=
    {
        text=0,
        x=0,
        y=0,
        font = native.systemFontBold,
        fontSize = 50
    }


    timerBox.text=display.newText(params)
    timerBox.text.value=0;
    timerBox.rect=display.newRoundedRect(0,0,width,height,5);

    timerBox:insert(timerBox.text)
    timerBox:insert(timerBox.rect)

    timerBox.rect:setFillColor(1,1,0,0.3)
    timerBox.rect.strokeWidth=10
    timerBox.rect:setStrokeColor(1,1,1,0.2)





end
timerBox.isOn=false
timerBox.time=0
timerBox.timer=nil
timerBox.start=function(startValue)
    local countdown=nil

    countdown=function()


        if(timerBox.time>=1)then

            timerBox.time= timerBox.time-1;
            timerBox.text.text= timerBox.time;
            timerBox.timer=timer.performWithDelay(1000,countdown)

        else

            Runtime:dispatchEvent({name="timesUp"})
        end

    end
    timerBox.time=startValue
    timerBox.text.text= timerBox.time
    timerBox.timer= timer.performWithDelay(1000,countdown)
end

timerBox.remove=function()

    timerBox:removeSelf();
end

return timerBox

end
return timerGenerator













