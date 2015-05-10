--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-09
-- Time: 10:39
-- To change this template use File | Settings | File Templates.
--
local targetChaingenerator=require("targetChainGenerator")
local p=require("properties")
local gameField_Size={};
gameField_Size.width=p.rightSide;
gameField_Size.height=p.bottomSide-p.bottomSide/6;


local gameGenerator = {}


--todo:not finished
gameGenerator.create = function()

    local gameController = {};


    local currentPositionInChain = 1;



    local showTask = function()


        gameController.targetsChain =targetChaingenerator.create()
        gameController.targetsChain.orderChain(gameController.chain)
        gameController.targetsChain.draw(gameField_Size.width,gameField_Size.height)

        gameController.targetsChain.x=p.X(gameField_Size.width/2)
        gameController.targetsChain.y=p.Y(gameField_Size.height/2)


    end

    local checkUserChoice = function(type)
        if (gameController.chain[currentPositionInChain] == type) then
            print("OK")
            currentPositionInChain = currentPositionInChain + 1;
            Runtime:dispatchEvent({name="pointChange",points=100})
        else
            Runtime:dispatchEvent({name="pointChange",points=-100})

        end

    end

    local finishGame = function()
    end

    local createChain = function(elementsNum, n)

        for i = 1, elementsNum do
            local number = math.random(1, n);
            table.insert(gameController.chain, number)
            print(number)
        end
    end

    local startGame = function(elementsNum, n)

        gameController.chain = {}
        n = n or p.typesNum
        createChain(elementsNum, n)


        showTask()
    end






    local eventListener = function(event)

        print(event.name)
        print(event.type or "EMPTY")

        if (event.type ~= nil) then
        checkUserChoice(event.type)
        else
            gameController.targetsChain.remove()
        end
    end




    gameController.start = function()

        Runtime:addEventListener("timesUp", eventListener)
        Runtime:addEventListener("targetHit", eventListener)
        startGame(5);
    end

    return gameController
end
return gameGenerator




