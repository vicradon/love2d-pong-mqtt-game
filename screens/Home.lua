function HomeScreen(loveframes, client)
  local commonXPosition = 40
  homeFrame = loveframes.Create("frame")
    	
	homeFrame:SetName("Home")
	homeFrame:SetWidth(love.graphics.getWidth())
	homeFrame:SetHeight(love.graphics.getHeight())
	homeFrame:ShowCloseButton(false)
  homeFrame:SetState("homestate")

  local usernameText = loveframes.Create("text", homeFrame)
	usernameText:SetText({
        {color={0, 0, 0, 1}},
        "Username"
    })
    usernameText:SetPos(commonXPosition, 40)

  local textinput = loveframes.Create("textinput", homeFrame)
	textinput:SetPos(commonXPosition, 60)
	textinput:SetWidth(490)

  local button = loveframes.Create("button", homeFrame)
	button:SetWidth(100)
	button:SetPos(commonXPosition, 100)
	button:SetText("Enter")

	loveframes.SetState("homestate")

	button.OnClick = function(object, x, y)
		if textinput:GetText() == "" then
			local promptFrame = loveframes.Create("frame", homeFrame)
			promptFrame:SetName("Prompt")
			promptFrame:Center()
			local text = loveframes.Create("text", promptFrame)
			text:SetText("You must set a username to continue")
			text:Center()
		else 
			playerDetails["username"] = textinput:GetText()
			loveframes.SetState("lobbystate")
		end
	end
	
	homeFrame.up = function() return love.keyboard.isDown("a") end

	
end

return HomeScreen
