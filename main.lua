require("scenes/home")
require("scenes/lobby")
require("utils/constants")
require("utils/mqtt_connector")

-- Globals
activeScreen = "home"

function love.load()
  username = ""

     printx = 0
   printy = 0
end

function love.textinput(character)
  username = username .. character
end

function love.draw()
  if activeScreen == "home" then home() end
  if activeScreen == "lobby" then lobby() end
  if activeScreen == "game" then game() end
end

function love.keypressed(key)
  if key == "space" then
    print("hi")
  end
end

function love.mousepressed(x, y, button, istouch)
   if button == 2 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
      printx = x
      printy = y
   end
end
