function LobbyScreen(loveframes, client)
    local commonXPosition = 40
    	
	local frame = loveframes.Create("frame")
	frame:SetName("Lobby")
	frame:SetWidth(love.graphics.getWidth())
	frame:SetHeight(love.graphics.getHeight())
	frame:ShowCloseButton(false)
    frame:SetState("lobbystate")    

    local infoText = loveframes.Create("text", frame)
	infoText:SetText({
        {color={0, 0, 0, 1}},
        "Either start a new game or pair with an existing player"
    })
    infoText:SetPos(commonXPosition, 40)


    local startGameButton = loveframes.Create("button", frame)
	startGameButton:SetWidth(150)
	startGameButton:SetPos(commonXPosition, 70)
	startGameButton:SetText("Start New Game")

    startGameButton.OnClick = function(object, x, y)
        -- when this button is clicked, we register the game on the server
        -- How do we register the game on the server?
        client:publish{topic = "games/" .. playerDetails.uuid, payload="initiated game"}
        loveframes.SetState("pairingstate")
	end


    local infoText = loveframes.Create("text", frame)
	infoText:SetText({
        {color={0, 0, 0, 1}},
        "Available players"
    })
    infoText:SetPos(commonXPosition, 110)

    players = {
        {name = "john wick"},
        {name = "Marie Curie"},
        {name = "Sensei Jojo"},
        {name = "Minsky Walu"},
    }

    for key,player in pairs(players) do
        local button = loveframes.Create("button", frame)
        button:SetWidth(300)
        button:SetPos(commonXPosition, 110 + key*30)
        button:SetText("Play with " .. player["name"])
    end

    local button1 = loveframes.Create("button", frame)
    button1:SetText("Sender 1")
    button1:SetPos(commonXPosition, 300)

    button1.OnClick = function(object, x, y)
        client:publish{ topic = "input", payload = "hello" }
    end

    local button2 = loveframes.Create("button", frame)
    button2:SetText("Sender 2")
    button2:SetPos(commonXPosition, 340)

    button2.OnClick = function(object, x, y)
        client:publish{ topic = "input", payload = "hi" }
    end

    client:subscribe{ topic="input", qos=1, callback=function(stuff)
        table.insert(messages, "message")
    end}


    return self
end

return LobbyScreen

-- set up username setting
-- set up start game
