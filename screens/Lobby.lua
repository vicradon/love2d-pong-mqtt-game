local ScreenManager = require('libraries.screen_manager.ScreenManager')
local Screen =  require("libraries.screen_manager.Screen")
local loveframes =  require("libraries.loveframes")

local LobbyScreen = {}

function LobbyScreen.new()
    local self = Screen.new()
    local commonXPosition = 40

    function self:draw()
        love.graphics.print("Lobby", 0, 0, 0)
    end

    local infoText = loveframes.Create("text")
	infoText:SetText({
        {color={200, 20, 20, 1}},
        "Either start a new game or pair with an existing player"
    })
    infoText:SetPos(commonXPosition, 40)


    local button = loveframes.Create("button")
	button:SetWidth(150)
	button:SetPos(commonXPosition, 70)
	button:SetText("Start New Game")
    

	button.OnClick = function(object, x, y)
        ScreenManager.switch( 'home' )
	end

    local infoText = loveframes.Create("text")
	infoText:SetText({
        {color={200, 20, 20, 1}},
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
        local button = loveframes.Create("button")
        button:SetWidth(300)
        button:SetPos(commonXPosition, 110 + key*30)
        button:SetText("Play with " .. player["name"])
    end

    return self
end

return LobbyScreen
