local splitString = require("utils.split_string")

mainGameObjects = {
	mainGameFrame = nil,
    player = nil,
    otherPlayer = nil,
    client = nil,
    loveframes = nil
}

function MainGameScreen(loveframes, client)
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

    -- local playerText = loveframes.Create("text", mainGameFrame)
	-- mainGameObjects.player:SetText({
    --     {color={0,0,0, 1}},
    --     "Player 1"
    -- })
    mainGameObjects.player:SetWidth(15)
    mainGameObjects.player:SetHeight(80)

    mainGameObjects.otherPlayer:SetWidth(15)
    mainGameObjects.otherPlayer:SetHeight(80)

    mainGameObjects.player:SetPos(10, mainGameObjects.mainGameFrame:GetHeight()/2) 
    mainGameObjects.otherPlayer:SetPos(mainGameObjects.mainGameFrame:GetWidth() - 30, mainGameObjects.mainGameFrame:GetHeight()/2) 

    

    -- if (playerDetails.isPlayer1 == true) then
    --     mainGameObjects.player:SetPos(10, mainGameObjects.mainGameFrame:GetHeight()/2) 
    -- end

    -- if (playerDetails.isPlayer1 == false) then
    --     mainGameObjects.player:SetPos(600, mainGameObjects.mainGameFrame:GetHeight()/2)
    -- end

    function mainGameObjects.player.up()
        return love.keyboard.isDown("up") 
    end
    function mainGameObjects.player.down()
        return love.keyboard.isDown("down") 
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

function handleKeyPressed(key, scancode, isrepeat) 
    if (key == 'up') then
        mainGameObjects.player:SetY(mainGameObjects.player:GetY() - 1)
        mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
    end
    if (key == 'down') then
        mainGameObjects.player:SetY(mainGameObjects.player:GetY() + 1)
        mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
    end
end

function handleKeyReleased(key, scancode, isrepeat) 
    if (key == 'up') then
        mainGameObjects.player:SetY(mainGameObjects.player:GetY() - 1)
        mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
    end
    if (key == 'down') then
        mainGameObjects.player:SetY(mainGameObjects.player:GetY() + 1)
        mainGameObjects.client:publish{topic="playerPosition", payload=mainGameObjects.player:GetY() .. "=" ..  playerDetails.username}
    end
end

local MainGame = {
    load = MainGameScreen,
    update = MainGameUpdate,
    keypressed = handleKeyPressed,
    keyreleased = handleKeyReleased
}

return MainGame
