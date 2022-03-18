local ScreenManager = require( 'libraries.screen_manager.ScreenManager' )
local Screen =  require("libraries.screen_manager.Screen")
local loveframes =  require("libraries.loveframes")

local Overlay = {}

function Overlay.new()
    local self = Screen.new() -- Note how we inherit from the Screen class.

    function self:draw()
        love.graphics.print("overlay", 0, 0, 0)
    end

    local button = loveframes.Create("button", frame)
	button:SetWidth(200)
	button:SetText("Button")
	button:Center()
	button.OnClick = function(object, x, y)
		object:SetText("You clicked the button!")
        ScreenManager.switch( 'main' )
        
	end
	button.OnMouseEnter = function(object)
		object:SetText("The mouse entered the button.")
	end
	button.OnMouseExit = function(object)
		object:SetText("The mouse exited the button.")
	end


    function self:keypressed( key )
        if key == 'escape' then
            -- Removes the topmost screen, so in this case the overlay itself.
            ScreenManager.pop()
        elseif key == 'n' then
           -- Closes all screens (close() function will be called) and creates a new screen.
            ScreenManager.switch( 'main' )
        end
    end

    return self
end

return Overlay
