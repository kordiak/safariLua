--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-11
-- Time: 15:28
-- To change this template use File | Settings | File Templates.
--


local p = require("properties")
local targetCreator = require("targetGenerator")


local gameFieldGenerator = {}

gameFieldGenerator.create = function(gameField_Size)

    local field = display.newGroup()
    field.positions = {}

    local gameField_singleSize = {};
    gameField_singleSize.height = gameField_Size.height / 8;
    gameField_singleSize.width = gameField_Size.width / 6;

    field.draw = function()

        local i = 0;



        for h = 0 + gameField_singleSize.height / 2, gameField_Size.height, gameField_singleSize.height do

            for w = gameField_singleSize.width / 2, gameField_Size.width, gameField_singleSize.width do
                field.positions[i] = { y = p.Y(h), x = p.X(w), elements = display.newGroup() };
                field.positions[i].elements.x = field.positions[i].x
                field.positions[i].elements.y = field.positions[i].y

                local rect = display.newRect(0, 0, gameField_singleSize.width, gameField_singleSize.height);
                rect:setFillColor(i / 45, i / 55, 0.2);

                field.positions[i].elements:insert(rect)
                field:insert(field.positions[i].elements)
                i = i + 1;
            end
        end
    end

    field.fullFill = function(listOfTargets)

        for b = 1, #listOfTargets do

            local types = listOfTargets[b]

            local i = 0
            while i ~= 5 do
                local rand = math.random(0, #field.positions)
                field.positions[rand].target = targetCreator.create(types, gameField_singleSize.width / 2, gameField_singleSize.height / 2);
                field.positions[rand].elements:insert(field.positions[rand].target)
                i = i + 1
            end
        end
    end

    field.remove=function()
    field:removeSelf();
    end
    return field
end



return gameFieldGenerator