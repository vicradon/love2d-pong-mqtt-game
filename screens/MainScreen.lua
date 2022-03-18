local ScreenManager = require( 'libraries.screen_manager.ScreenManager' )
local Screen =  require("libraries.screen_manager.Screen")
local loveframes =  require("libraries.loveframes")

local MainScreen = {}

function MainScreen.new()
    local self = Screen.new()

    function self:draw()
        love.graphics.print("main", 0, 0, 0)
    end

    local button = loveframes.Create("button", frame)
	button:SetWidth(200)
	button:SetText("Button")
	button:Center()
	button.OnClick = function(object, x, y)
		object:SetText("You clicked the button!")
        ScreenManager.switch( 'overlay' )
	end
	button.OnMouseEnter = function(object)
		object:SetText("The mouse entered the button.")
	end
	button.OnMouseExit = function(object)
		object:SetText("The mouse exited the button.")
	end

    

    function self:keypressed( key )
        if key == 'p' then
            ScreenManager.push( 'overlay', 'Game paused' )
        end
    end

    return self
end

return MainScreen
