function PairingScreen(loveframes, client)
    local commonXPosition = 40

	pairingFrame = loveframes.Create("frame")
    pairingFrame:SetName("Pairing")
	pairingFrame:SetWidth(love.graphics.getWidth())
	pairingFrame:SetHeight(love.graphics.getHeight())
	pairingFrame:ShowCloseButton(false)
    pairingFrame:SetState("pairingstate")    

    local infoText = loveframes.Create("text", pairingFrame)
	infoText:SetText({
        {color={0,0,0, 1}},
        "Waiting for another player to pair..."
    })
    infoText:Center()

    -- How to send data here
    -- Either use the main.lua to get the current state and set the state immediately in that function where we make the button visible and
    -- somehow trigger the event from this running instance when the start game button is clicked
    return self
end

local Pairing = {
    load = PairingScreen
}

return Pairing
