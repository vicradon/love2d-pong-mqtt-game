function lobby()
  local uuid = require("libraries/uuid")
  local buttonFont = love.graphics.newFont(20)
  local textFont = love.graphics.newFont(30)

  local generateGameButtonWidth = screenWidth/3
  local generateGameButtonHeight = screenHeight/16
  local generateGameButtonXPosition = screenWidth/2 - generateGameButtonWidth/2
  local generateGameButtonYPosition = screenHeight/4 - generateGameButtonHeight/2
  
  local startGameButtonWidth = screenWidth/4
  local startGameButtonHeight = screenHeight/16
  local startGameButtonXPosition = screenWidth/2 - startGameButtonWidth/2
  local startGameButtonYPosition = screenHeight/2 - startGameButtonHeight/2

  local gameCode = ""
  local generatedGameId = uuid()

  function love.draw()
    love.graphics.setColor(0.2, 0.8, 0.2, 0.8)
    love.graphics.print("Lobby", textFont, screenWidth/2 - 40, 10)
    love.graphics.print("Generate a game code and share or join with code", screenWidth/3, 50)
    
    love.graphics.printf("Click the button to generate a game code", generateGameButtonXPosition, generateGameButtonYPosition - 50, screenWidth)
    love.graphics.printf("Your game code is " .. generatedGameId, generateGameButtonXPosition, generateGameButtonYPosition + 50, screenWidth)
    love.graphics.rectangle("fill", generateGameButtonXPosition, generateGameButtonYPosition, generateGameButtonWidth, generateGameButtonHeight)
    love.graphics.print("Generate Game Code", buttonFont, generateGameButtonXPosition+30, generateGameButtonYPosition+5)
    
    love.graphics.printf("Enter Game Code: " .. gameCode, startGameButtonXPosition, startGameButtonYPosition - 50, screenWidth)
    love.graphics.rectangle("fill", startGameButtonXPosition, startGameButtonYPosition, startGameButtonWidth, startGameButtonHeight)
    love.graphics.print("Start Game", buttonFont, startGameButtonXPosition+30, startGameButtonYPosition+5)
  end

  function love.textinput(character)
    gameCode = gameCode .. character
  end  
end