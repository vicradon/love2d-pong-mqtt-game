local loveframes =  require("libraries.loveframes")
local ScreenManager = require( 'libraries.screen_manager.ScreenManager' )

function love.load()
	local font = love.graphics.newFont(12)
	love.graphics.setFont(font)

	local screens = {
        ['home'] = require( 'screens.Home' ),
        ['lobby'] = require( 'screens.Lobby' ),
        ['pairing'] = require( 'screens.Pairing' ),
	}
	
	ScreenManager.init(screens, 'home')
	ScreenManager.registerCallbacks()
end

function love.update(dt)
    ScreenManager.update(dt)
	loveframes.update(dt)
end

function love.draw()
    ScreenManager.draw()
	love.graphics.setColor(1, 1, 1, 1)
	loveframes.draw()
end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
	loveframes.wheelmoved(x, y)
end

function love.keypressed(key, isrepeat)
	loveframes.keypressed(key, isrepeat)
end

function love.keyreleased(key)
	loveframes.keyreleased(key)
end

function love.textinput(text)
	loveframes.textinput(text)
end