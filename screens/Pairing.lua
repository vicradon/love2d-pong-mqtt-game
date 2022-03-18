local ScreenManager = require('libraries.screen_manager.ScreenManager')
local Screen =  require("libraries.screen_manager.Screen")
local loveframes =  require("libraries.loveframes")

local LobbyScreen = {}

function LobbyScreen.new()
    local self = Screen.new()
    local commonXPosition = 40

    function self:draw()
        love.graphics.print("Pairing", 0, 0, 0)
    end

    local infoText = loveframes.Create("text")
	infoText:SetText({
        {color={200, 20, 20, 1}},
        "Waiting for another player to pair"
    })
    infoText:SetPos(commonXPosition, 40)

    return self
end

return LobbyScreen
