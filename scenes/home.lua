function home()
    love.graphics.printf("Enter username and click enter", 0, 0, love.graphics.getWidth())
    love.graphics.printf("Enter username: ".. username, 0, 20, love.graphics.getWidth())

    function love.keypressed(key)
        if key == "return" then
            activeScene = "lobby"
        end
    end

    function love.textinput(character)
        username = username .. character
    end
end
