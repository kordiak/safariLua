-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


require("config")
local gameGenerator = require("gameGenerator")
local targetCreator = require("targetGenerator")
local p = require("properties")








------------------------------------ Create field
local gameField_Size = {};
gameField_Size.width = p.rightSide;
gameField_Size.height = p.bottomSide - p.bottomSide / 6;

local field = display.newRect(p.X(gameField_Size.width / 2), p.Y(gameField_Size.height / 2), p.rightSide, gameField_Size.height);
field:setFillColor(0.5, 0.5, 1)

local i = 0;
local gameField_singleSize = {};
local positions = {};







gameField_singleSize.height = gameField_Size.height / 8;
gameField_singleSize.width = gameField_Size.width / 6;




--for h = 0 + gameField_singleSize.height / 2, gameField_Size.height, gameField_singleSize.height do
--
--    for w = gameField_singleSize.width / 2, gameField_Size.width, gameField_singleSize.width do
--        positions[i] = { y = p.Y(h), x = p.X(w), elements = display.newGroup() };
--        positions[i].elements.x = positions[i].x
--        positions[i].elements.y = positions[i].y
--
--        local rect = display.newRect(0, 0, gameField_singleSize.width, gameField_singleSize.height);
--        rect:setFillColor(i / 45, i / 55, 0.2);
--
--        positions[i].elements:insert(rect)
--
--        i = i + 1;
--    end
--end
--
--
--
--
-------------------------------------- Fullfill field
---- TODO: ENSURE that there is only one target in the field
--



local gameController = gameGenerator.create()
gameController.start(5)


--
--for b = 1, #gameController.chain do
--
--    local types = gameController.chain[b]
--
--    local i = 0
--    while i ~= 5 do
--        local rand = math.random(0, #positions)
--        positions[rand].target = targetCreator.create(types, gameField_singleSize.width / 2, gameField_singleSize.height / 2);
--        positions[rand].elements:insert(positions[rand].target)
--        i=i+1
--    end
--end









--object.draw({left={size=5}});












