function lobby()
  local uuid = require("libraries/uuid")
  local textFont = love.graphics.newFont(30)

  local generateGameButtonWidth = screenWidth/3
  local generateGameButtonHeight = screenHeight/16
  local generateGameButtonXPosition = screenWidth/2 - generateGameButtonWidth/2
  local generateGameButtonYPosition = screenHeight/4 - generateGameButtonHeight/2

  local gameCode = ""
  local generatedGameId = uuid()

  
  function love.draw()
    love.graphics.setColor(0.2, 0.8, 0.2, 0.8)
    love.graphics.print("Lobby", textFont, screenWidth/2 - 40, 10)
    love.graphics.print("Start a new game or joing an existing one", screenWidth/3, 50)
    
    -- love.graphics.printf("Click the button to generate a game code", generateGameButtonXPosition, generateGameButtonYPosition - 50, screenWidth)
    -- love.graphics.printf("Your game code is " .. generatedGameId, generateGameButtonXPosition, generateGameButtonYPosition + 50, screenWidth)
    -- love.graphics.rectangle("fill", generateGameButtonXPosition, generateGameButtonYPosition, generateGameButtonWidth, generateGameButtonHeight)
    -- love.graphics.print("Generate Game Code", buttonFont, generateGameButtonXPosition+30, generateGameButtonYPosition+5)
    
    

    startGameButtonWidth = screenWidth/4
    startGameButtonHeight = screenHeight/16
    startGameButtonXPosition = screenWidth/2 - startGameButtonWidth/2
    startGameButtonYPosition = screenHeight/8
    buttonFont = love.graphics.newFont(20)

    love.graphics.rectangle("fill", startGameButtonXPosition, startGameButtonYPosition, startGameButtonWidth, startGameButtonHeight)
    love.graphics.print("Start New Game", buttonFont, startGameButtonXPosition+30, startGameButtonYPosition+5)

 
   
  end

  function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and x >= startGameButtonXPosition and x <= (startGameButtonXPosition + startGameButtonWidth) and y >= startGameButtonYPosition  and y <= (startGameButtonYPosition + startGameButtonHeight) then
        activeScene = "home"
    end
  end


  function love.keypressed(key)
      if key == "return" then
        print("nemb")
          activeScene = "home"
      end
  end

end