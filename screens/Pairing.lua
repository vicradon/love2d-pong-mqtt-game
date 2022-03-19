function PairingScreen(loveframes, client)
    local commonXPosition = 40

	local frame = loveframes.Create("frame")
    frame:SetName("Pairing")
	frame:SetWidth(love.graphics.getWidth())
	frame:SetHeight(love.graphics.getHeight())
	frame:ShowCloseButton(false)
    frame:SetState("pairingstate")    

    local infoText = loveframes.Create("text", frame)
	infoText:SetText({
        {color={0,0,0, 1}},
        "Waiting for another player to pair"
    })
    infoText:Center()

    

    return self
end

return PairingScreen
