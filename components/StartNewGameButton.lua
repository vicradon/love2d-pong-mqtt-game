function startNewGameButton()
    startGameButtonWidth = screenWidth/4
    startGameButtonHeight = screenHeight/16
    startGameButtonXPosition = screenWidth/2 - startGameButtonWidth/2
    startGameButtonYPosition = screenHeight/8
    buttonFont = love.graphics.newFont(20)

    love.graphics.rectangle("fill", startGameButtonXPosition, startGameButtonYPosition, startGameButtonWidth, startGameButtonHeight)
    love.graphics.print("Start New Game", buttonFont, startGameButtonXPosition+30, startGameButtonYPosition+5)

 
    function love.mousepressed(x, y, button, istouch, presses)
        if button == 1 and x >= startGameButtonXPosition and x <= (startGameButtonXPosition + startGameButtonWidth) and y >= startGameButtonYPosition  and y <= (startGameButtonYPosition + startGameButtonHeight) then
            activeScene = "home"
        end
    end


    function love.keypressed(key)
        if key == "return" then
            activeScene = "home"
        end
    end
end

return startNewGameButton