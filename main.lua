local loveframes =  require("libraries.loveframes")
local mqtt = require("mqtt")
local client = require('utils.mqtt_client')
local Home = require("screens.Home")
local Lobby = require("screens.Lobby")
local Pairing = require("screens.Pairing")

messages = {}
playerDetails = {}

function love.load()
	local font = love.graphics.newFont(12)
	love.graphics.setFont(font)

	Home(loveframes, client)
	Lobby(loveframes, client)
	Pairing(loveframes, client)
end

function love.update(dt)
	loop = mqtt.get_ioloop()
	loop:add(client)
	loop:iteration()
	loveframes.update(dt)
end

function love.draw()
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