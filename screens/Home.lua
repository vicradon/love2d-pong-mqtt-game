local uuid = require("utils.uuid")

function HomeScreen(loveframes, client)
    local commonXPosition = 40
    	
	local frame = loveframes.Create("frame")
	frame:SetName(availablePlayersCount) -- This should update with respect to updates made in love.update
	frame:SetWidth(love.graphics.getWidth())
	frame:SetHeight(love.graphics.getHeight())
	frame:ShowCloseButton(false)
    frame:SetState("homestate")

    local usernameText = loveframes.Create("text", frame)
	usernameText:SetText({
        {color={0, 0, 0, 1}},
        "Username"
    })
    usernameText:SetPos(commonXPosition, 40)

    local textinput = loveframes.Create("textinput", frame)
	textinput:SetPos(commonXPosition, 60)
	textinput:SetWidth(490)
	textinput:SetFont(love.graphics.newFont( "resources/FreeSans-LrmZ.ttf", 12))
	

    local button = loveframes.Create("button", frame)
	button:SetWidth(100)
	button:SetPos(commonXPosition, 100)
	button:SetText("Enter")

	loveframes.SetState("homestate")

	button.OnClick = function(object, x, y)
		if textinput:GetText() == "" then
			local promptFrame = loveframes.Create("frame", frame)
			promptFrame:SetName("Prompt")
			promptFrame:Center()
			local text = loveframes.Create("text", promptFrame)
			text:SetText("You must set a username to continue")
			text:Center()
		else 
			playerDetails["username"] = textinput:GetText()
			playerDetails["uuid"] = uuid()
			loveframes.SetState("lobbystate")
		end
	end
end


return HomeScreen
