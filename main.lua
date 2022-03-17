require("utils/constants")
require("utils/thread_code")

function love.load()
  local thread = love.thread.newThread(threadCode)
  thread:start()
  
  activeScene = "home"
  username = ""
  buttonFont = love.graphics.newFont(12)
  
  setUsernameButtonWidth = 120
  setUsernameButtonHeight = 30
  setUsernameButtonXPosition = screenWidth/4 - setUsernameButtonWidth/2
  setUsernameButtonYPosition = 100

  startGameButtonWidth =  120
  startGameButtonHeight = 30
  startGameButtonXPosition = screenWidth/2 - startGameButtonWidth/2
  startGameButtonYPosition = screenHeight/8
end

function love.update()

end

function love.draw()
  if activeScene == "home" then
    love.graphics.setColor(0.2, 0.8, 0.2, 0.6)
    love.graphics.printf("Enter username and click enter", 0, 0, screenWidth)
    love.graphics.printf("Enter username: ".. username, 0, 20, screenWidth)
    love.graphics.rectangle("fill", setUsernameButtonXPosition, setUsernameButtonYPosition, setUsernameButtonWidth, setUsernameButtonHeight)
    love.graphics.print("Set username", buttonFont, setUsernameButtonXPosition+15, setUsernameButtonYPosition+5)
  end

  if activeScene == "lobby" then
    love.graphics.setColor(0.2, 0.8, 0.2, 0.6)
    love.graphics.printf("Choose a game or start one yourself", 0, 0, screenWidth)
    love.graphics.rectangle("fill", startGameButtonXPosition, startGameButtonYPosition, startGameButtonWidth, startGameButtonHeight)
    love.graphics.print("Start Game", buttonFont, startGameButtonXPosition+15, startGameButtonYPosition+5)
  end

  if activeScene == "game" then
    love.graphics.print("main game", 0,0, 0)
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  if button == 1 and x >= setUsernameButtonXPosition and x <= (setUsernameButtonXPosition + setUsernameButtonWidth) and y >= setUsernameButtonYPosition  and y <= (setUsernameButtonYPosition + setUsernameButtonHeight) then
    -- activeScene = "lobby"
    client:publish{ topic = "input", payload = "hello" }
  end
  if button == 1 and x >= startGameButtonXPosition and x <= (startGameButtonXPosition + startGameButtonWidth) and y >= startGameButtonYPosition  and y <= (startGameButtonYPosition + startGameButtonHeight) then
      activeScene = "game"
  end
end

function love.keypressed(key)
  if key == "return" then
      activeScene = "lobby"
  end
end

function love.textinput(character)
  username = username .. character
end