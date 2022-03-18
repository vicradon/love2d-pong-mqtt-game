local ScreenManager = require('libraries.screen_manager.ScreenManager')
local Screen =  require("libraries.screen_manager.Screen")
local loveframes =  require("libraries.loveframes")

local HomeScreen = {}

function HomeScreen.new()
    local self = Screen.new()
    local commonXPosition = 40

    function self:draw()
        love.graphics.print("Home", 0, 0, 0)
    end

    local usernameText = loveframes.Create("text")
	usernameText:SetText({
        {color={200, 20, 20, 1}},
        "Username"
    })
    usernameText:SetPos(commonXPosition, 40)

    local textinput = loveframes.Create("textinput", frame)
	textinput:SetPos(commonXPosition, 60)
	textinput:SetWidth(490)
	textinput.OnEnter = function(object)
		if not textinput.multiline then
			object:Clear()
		end
	end
	textinput:SetFont(love.graphics.newFont( "resources/FreeSans-LrmZ.ttf", 12))
	

    local button = loveframes.Create("button")
	button:SetWidth(100)
	button:SetPos(commonXPosition, 100)
	button:SetText("Enter")

	button.OnClick = function(object, x, y)
        ScreenManager.switch('lobby')
	end



    return self

end


return HomeScreen
