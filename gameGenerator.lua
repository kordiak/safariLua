--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-09
-- Time: 10:39
-- To change this template use File | Settings | File Templates.
--
local targetChaingenerator = require("targetChainGenerator")
local p = require("properties")
local bg = require("buttonGenerator")
local timerGenerator=require("timerGenerator")
local gameFieldGenerator=require("gameFieldGenerator")
local panelClass=require("panelClass")
local pointsCreator=require("pointsCreator")

local gameField_Size = {};
gameField_Size.width = p.rightSide;
gameField_Size.height = p.bottomSide - p.bottomSide / 6;


local gameGenerator = {}


--todo:not finished
gameGenerator.create = function()

    local gameController = {};


    local currentPositionInChain = 1;



    local showTask = function()


        gameController.targetsChain = targetChaingenerator.create()
        gameController.targetsChain.orderChain(gameController.chain)
        gameController.targetsChain.draw(gameField_Size.width, gameField_Size.height)

        gameController.targetsChain.x = p.X(gameField_Size.width / 2)
        gameController.targetsChain.y = p.Y(gameField_Size.height / 2)
    end


    local finishGame = function()

        gameController.targetsChain = targetChaingenerator.create()
        gameController.targetsChain.draw(gameField_Size.width, gameField_Size.height)
        gameController.targetsChain.x = p.X(gameField_Size.width / 2)
        gameController.targetsChain.y = p.Y(gameField_Size.height / 2)

        gameController.targetsChain.setText("Next level?")
        gameController.targetsChain.setTextColor({ 1, 0, 0 })



        local button = bg.create({ name = "yesButton", text = "YES" })
        button.draw()
        button.y = button.height
        button.x = button.width / 2
        gameController.targetsChain:insert(button)

        local buttonNo = bg.create({ name = "noButton", text = "NO" })
        buttonNo.draw()
        buttonNo.y = button.height
        buttonNo.x = -button.width / 2
        gameController.targetsChain:insert(buttonNo)
    end

    local checkUserChoice = function(type)
        if (gameController.chain[currentPositionInChain] == type) then
            print("OK")
            currentPositionInChain = currentPositionInChain + 1;
            Runtime:dispatchEvent({ name = "pointChange", points = 100 })
        else
            Runtime:dispatchEvent({ name = "pointChange", points = -100 })
        end
        if (currentPositionInChain > #gameController.chain) then finishGame() end
    end



    local createChain = function(elementsNum, n)

        for i = 1, elementsNum do
            local number = math.random(1, n);
            table.insert(gameController.chain, number)
            print(number)
        end
    end

    local startGame = function(elementsNum, n)


        if(gameController.pointsIndicator==nil)then
        ------------------------------------Draw bottom panel
        gameController.bottomPanel =panelClass.create();
        gameController.bottomPanel.draw({bottom={size=6}})
        gameController.bottomPanel.setBottomColor({0.1,0.2,0.3})
        -----------------------------------Show current points

        gameController.pointsIndicator=pointsCreator.create()
        gameController.pointsIndicator.draw();
        gameController.bottomPanel.bottomInsert(gameController.pointsIndicator,1,0.5)

        end



        ----------------------------------Show timer
        gameController.timerBox =timerGenerator.create()
        gameController.timerBox.draw()
        gameController.timerBox.start(5)



        --------------------element/position/alpha

        gameController.bottomPanel.bottomInsert(gameController.timerBox,-1,0.5)





        gameController.chain = {}
        n = n or p.typesNum
        createChain(elementsNum, n)

        gameController.gameField=gameFieldGenerator.create(gameField_Size)
        gameController.gameField.draw()
        gameController.gameField.fullFill(gameController.chain)
        showTask()




    end


    local refreshGameGenerator=function(howMany)

        gameController.targetsChain.remove()
        gameController.removeListeners()
        currentPositionInChain=1
        gameController.timerBox.remove()
        gameController.gameField.remove()
        timer.performWithDelay(200,function() gameController.start(howMany+1) end)

    end



    local eventListener = function(event)

        print(event.name)
        print(event.type or "EMPTY")

        if (event.name == "targetHit") then
            checkUserChoice(event.type)
        elseif event.name == "timesUp" then
            gameController.targetsChain.remove()
        elseif event.name == "buttonPressed" then


            if (event.buttonName == "yesButton") then
                print(event.buttonName)
                refreshGameGenerator(#gameController.chain)

            end
        end
        return true
    end

    gameController.removeListeners=function()

        Runtime:removeEventListener("timesUp", eventListener)
        Runtime:removeEventListener("targetHit", eventListener)
        Runtime:removeEventListener("buttonPressed", eventListener)


    end


    gameController.start = function(value)

        Runtime:addEventListener("timesUp", eventListener)
        Runtime:addEventListener("targetHit", eventListener)
        Runtime:addEventListener("buttonPressed", eventListener)

        startGame(value);
    end

    gameController.remove = function()
        gameController.removeListeners()
        gameController.targetsChain.remove()
    end
    return gameController
end
return gameGenerator




