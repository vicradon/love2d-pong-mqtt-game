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

    return self
end

return PairingScreen
