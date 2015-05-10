--
-- Created by IntelliJ IDEA.
-- User: kordi_000
-- Date: 2015-05-10
-- Time: 11:40
-- To change this template use File | Settings | File Templates.
--
--- EVENT: buttonPressed
--- event.buttonName

local buttonGenerator = {}



buttonGenerator.create =
function(params)

    local pressedGraphic=params.pressed
    local unpressedGraphic=params.unpressed



    local button = display.newGroup()
    button.textValue=params.text
    button.name=params.name or params.text
    local onClickListener = function(event)

        if (event.phase == "began") then
            button.pressedGraphic:toFront()
            button.text:toFront()
            elseif(event.phase=="ended")then
            button.unpressedGraphic:toFront()
            button.text:toFront()
            Runtime:dispatchEvent({name="buttonPressed",buttonName=button.name})
        end
    end
    button.pressed = false



    button.draw = function()

        button.pressedGraphic = pressedGraphic or display.newRoundedRect(0, 0, 200, 100,20)
        button.unpressedGraphic = unpressedGraphic or display.newRoundedRect(0, 0, 200, 100,20)

        button.pressedGraphic:setFillColor(0.5, 0.5, 0)
        button.unpressedGraphic:setFillColor(0.55, 0.55, 0)

        button.pressedGraphic.strokeWidth=25
        button.unpressedGraphic.strokeWidth=20

        button.pressedGraphic:setStrokeColor(0.40,0.40,0)
        button.unpressedGraphic:setStrokeColor(0.5,0.5,0)
        button:insert(button.pressedGraphic)
        button:insert(button.unpressedGraphic)

        local textParams=
        {
            text=button.textValue,
            font = native.systemFontBold,
            fontSize = 30

        }
        button.text=display.newText(textParams)
        button.text:setFillColor(0.2,0.2,0)
        button:insert(button.text)
        button:addEventListener("touch", onClickListener)

        button.xScale=0.5
        button.yScale=0.5
    end
    button.remove = function() end

    return button
end

return buttonGenerator
