function LobbyScreen(loveframes, client)
    local commonXPosition = 40
    	
	lobbyFrame = loveframes.Create("frame")
	lobbyFrame:SetName("Lobby")
	lobbyFrame:SetWidth(love.graphics.getWidth())
	lobbyFrame:SetHeight(love.graphics.getHeight())
	lobbyFrame:ShowCloseButton(false)
    lobbyFrame:SetState("lobbystate")

    local infoText = loveframes.Create("text", lobbyFrame)
	infoText:SetText({
        {color={0, 0, 0, 1}},
        "Either start a new game or pair with an existing player"
    })
    infoText:SetPos(commonXPosition, 40)


    local startGameButton = loveframes.Create("button", lobbyFrame)
	startGameButton:SetWidth(150)
	startGameButton:SetPos(commonXPosition, 70)
	startGameButton:SetText("Start New Game")

    startGameButton.OnClick = function(object, x, y)
        playerDetails["isPlayer1"] = true
        client:publish{topic = "players", payload=playerDetails.username}
        loveframes.SetState("pairingstate")
	end


    local infoText = loveframes.Create("text", lobbyFrame)
	infoText:SetText({
        {color={0, 0, 0, 1}},
        "Available players"
    })
    infoText:SetPos(commonXPosition, 110)


    firstAvailablePlayerButton = loveframes.Create("button", lobbyFrame)
    firstAvailablePlayerButton:SetWidth(400)
    firstAvailablePlayerButton:SetPos(40, 140)
    firstAvailablePlayerButton:SetVisible(false)

    firstAvailablePlayerButton.OnClick = function(object, x, y)
        client:publish{topic = "players", payload=playerDetails.username}
        playerDetails["isPlayer1"] = false
        loveframes.SetState("maingamestate")
    end

    return self
end


local Lobby = {
    load = LobbyScreen
}

return Lobby

-- set up username setting
-- set up start game
