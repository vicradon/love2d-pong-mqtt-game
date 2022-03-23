local splitString = require("utils.split_string")

mainGameObjects = {
	mainGameFrame = nil,
    player = nil,
    otherPlayer = nil,
    ball,
    client = nil,
    loveframes = nil
}

function MainGameScreen(loveframes, client)
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    local scoreDetailsYPosition = 30
    local paddleWidth = 15
    local paddleHeight = 80
    local paddleSpeed = 100

    local ballProperties = {
        radius=10,
        xVelocity=100,
        yVelocity=0,
    }

    -- Temporary
	loveframes.SetState("maingamestate")

    local commonXPosition = 40
    mainGameObjects.client = client
    mainGameObjects.loveframes = loveframes

    mainGameObjects.mainGameFrame = loveframes.Create("frame")
    mainGameObjects.mainGameFrame:SetName("Main Game")
	mainGameObjects.mainGameFrame:SetWidth(love.graphics.getWidth())
	mainGameObjects.mainGameFrame:SetHeight(love.graphics.getHeight())
	mainGameObjects.mainGameFrame:ShowCloseButton(false)
    mainGameObjects.mainGameFrame:SetState("maingamestate")    

    mainGameObjects.player = loveframes.Create("panel", mainGameObjects.mainGameFrame)
    mainGameObjects.otherPlayer = loveframes.Create("panel", mainGameObjects.mainGameFrame)
    mainGameObjects.ball = loveframes.Create("panel", mainGameObjects.mainGameFrame)

    mainGameObjects.player:SetSize(paddleWidth, paddleHeight)
    mainGameObjects.otherPlayer:SetSize(paddleWidth, paddleHeight)
    mainGameObjects.ball:SetSize(ballProperties.radius, ballProperties.radius)

    mainGameObjects.otherPlayer:SetWidth(paddleWidth)
    mainGameObjects.otherPlayer:SetHeight(paddleHeight)

    mainGameObjects.player:SetPos(10, mainGameObjects.mainGameFrame:GetHeight()/2) 
    mainGameObjects.otherPlayer:SetPos(mainGameObjects.mainGameFrame:GetWidth() - 30, mainGameObjects.mainGameFrame:GetHeight()/2) 
    mainGameObjects.ball:Center()
    
    mainGameObjects.playerScore = loveframes.Create("text", mainGameObjects.mainGameFrame)
    mainGameObjects.otherPlayerScore = loveframes.Create("text", mainGameObjects.mainGameFrame)

	mainGameObjects.playerScore:SetText({
        {color={0,0,0, 1}},
        "0"
    })

	mainGameObjects.otherPlayerScore:SetText({
        {color={0,0,0, 1}},
        "0"
    })

    local playerIndicator = loveframes.Create("text", mainGameObjects.mainGameFrame)
    local otherPlayerIndicator = loveframes.Create("text", mainGameObjects.mainGameFrame)
    local scoreSeparator = loveframes.Create("text", mainGameObjects.mainGameFrame)

    playerIndicator:SetText({
        {color={0,0,0, 1}},
        "You"
    })

    otherPlayerIndicator:SetText({
        {color={0,0,0, 1}},
        "Other Player"
    })

    scoreSeparator:SetText({
        {color={0,0,0, 1}},
        "-"
    })

    playerIndicator:SetPos(windowWidth/2 - 50, scoreDetailsYPosition)
    mainGameObjects.playerScore:SetPos(windowWidth/2 - 15, scoreDetailsYPosition)
    
    otherPlayerIndicator:SetPos(windowWidth/2 + 30, scoreDetailsYPosition)
    mainGameObjects.otherPlayerScore:SetPos(windowWidth/2 + 15, scoreDetailsYPosition)

    scoreSeparator:SetPos(windowWidth/2, scoreDetailsYPosition)


    -- if (playerDetails.isPlayer1 == true) then
    --     mainGameObjects.player:SetPos(10, mainGameObjects.mainGameFrame:GetHeight()/2) 
    -- end

    -- if (playerDetails.isPlayer1 == false) then
    --     mainGameObjects.player:SetPos(600, mainGameObjects.mainGameFrame:GetHeight()/2)
    -- end

    -- mainGameObjects.player.draw = function(object)
    --     love.graphics.setColor(0.5, 0.8, 0.2)
    --     love.graphics.rectangle("fill", 10, windowHeight/2 - paddleHeight/2, paddleWidth, paddleHeight)
    --     return object
    -- end

    function objectsAreColliding(object1, object2)
        return object1:GetX() + object1:GetWidth() >= object2:GetX()  
        and object2:GetX() + object2:GetWidth() >= object1:GetX() 
        and object1:GetY() + object1:GetHeight() >= object2:GetY() 
        and object2:GetY() + object2:GetHeight() >= object1:GetY()
    end

    mainGameObjects.ball.Update = function(object, dt)
        object:SetX(object:GetX() + (ballProperties.xVelocity * dt))
        object:SetY(object:GetY() + (ballProperties.yVelocity * dt))

        if (objectsAreColliding(object, mainGameObjects.player)) then
            ballProperties.xVelocity = -ballProperties.xVelocity
            -- print(object:GetX())
            -- object:SetX(object:GetX() + (ballProperties.xVelocity * dt))
        end
    end
    
    
    mainGameObjects.player.Update = function(object, dt)
        if love.keyboard.isDown("up") then
            object:SetY(object:GetY() - (paddleSpeed * dt))
        end
        if love.keyboard.isDown("down") then
            object:SetY(object:GetY() + (paddleSpeed * dt))
        end
        -- if love.keyboard.isDown("left") then
        --     object:SetX(object:GetX() - (paddleSpeed * dt))
        -- end
        -- if love.keyboard.isDown("right") then
        --     object:SetX(object:GetX() + (paddleSpeed * dt))
        -- end
    end

    mainGameObjects.player.keypressed = function(object, key)
        -- print(object, key)
        -- if (key == 'up') then
        --     mainGameObjects.player:SetY(mainGameObjects.player:GetY() - 10)
        --     -- mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
        -- end
        -- if (key == 'down') then
        --     mainGameObjects.player:SetY(mainGameObjects.player:GetY() + 10)
        --     -- mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
        -- end
    end

    mainGameObjects.player.keyreleased = function(object, key)
        -- if (key == 'up') then
        --     mainGameObjects.player:SetY(mainGameObjects.player:GetY() - 10)
        --     -- mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
        -- end
        -- if (key == 'down') then
        --     mainGameObjects.player:SetY(mainGameObjects.player:GetY() + 10)
        --     -- mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
        -- end
    end

    return self
end

function MainGameUpdate(dt)
    if mainGameObjects.loveframes:GetState() == "maingamestate" then
        -- if mainGameObjects.player.up() then
        --     mainGameObjects.player:SetY(mainGameObjects.player:GetY() - 1)
        --     mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
        -- end
        -- if mainGameObjects.player.down() then
        --     mainGameObjects.player:SetY(mainGameObjects.player:GetY() + 1)
        --     mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
        -- end

        if (splitString(otherPlayerLastPosition, "=")[2] ~= playerDetails.username) then
            if splitString(otherPlayerLastPosition, "=")[1] ~= nil then
                mainGameObjects.otherPlayer:SetY(splitString(otherPlayerLastPosition, "=")[1])
            end
        end
    end
end



local MainGame = {
    load = MainGameScreen,
    update = MainGameUpdate
}

return MainGame


    -- mainGameObjects.ball.Draw = function(object) 
    --     love.graphics.setColor(1, 0.3, 0.3)
    --     love.graphics.circle("fill", windowWidth/2, windowHeight/2, 5)
    -- end
