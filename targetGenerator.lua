--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-05
-- Time: 14:08
-- To change this template use File | Settings | File Templates.


local targetGenerator={}
local types=
{
    red={1,0,0},
    blue={0,0,1}
}

targetGenerator.created={}

local eb=function(event)print("event") end

local colors={}
colors[1]="red"
colors[2]="blue"

local clicked;
clicked=
function(e)


    for i=1,#targetGenerator.created do

        if targetGenerator.created[i].object==e.target then

            print(colors[targetGenerator.created[i].type]);
            Runtime:dispatchEvent({name="targetClicked",target=targetGenerator})
            table.remove(targetGenerator.created,i)
            break
        end
        end

--todo: remove test

    Runtime:dispatchEvent({name="pointChange", points=math.floor(#targetGenerator.created)})

    e.target:setFillColor(1,1,0)
    e.target:removeEventListener("touch",clicked)
    e.target:removeSelf()
end



targetGenerator.create=function(type,w,h)

    local object=display.newRect(0,0,w,h);

    if type==1 then
        object:setFillColor(unpack(types.red,1,3))
    elseif type==2 then
        object:setFillColor(unpack(types.blue,1,3))

    end

    object:addEventListener("touch",clicked)

    local target={object=object,type=type}
    table.insert(targetGenerator.created,target)



    return object
end


return targetGenerator