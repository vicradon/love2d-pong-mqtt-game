local example = {}
example.title = "Grid"
example.category = "Object Demonstrations"

function example.func(loveframes, centerarea)

	local frame = loveframes.Create("frame")
	frame:SetName("Grid")
	frame:CenterWithinArea(unpack(centerarea))

	local grid = loveframes.Create("grid", frame)
	grid:SetPos(5, 30)
	grid:SetRows(5)
	grid:SetColumns(5)
	grid:SetCellWidth(45)
	grid:SetCellHeight(45)
	grid:SetCellPadding(2)
	grid:SetItemAutoSize(true)

	grid:SetItemAutoSize(true)

	grid:ColSpanAt(1, 1, 5)
	grid:RowSpanAt(1, 1, 3)

	grid:RowSpanAt(4, 1, 2)
	grid:ColSpanAt(4, 1, 2)

	grid:ColSpanAt(5, 3, 2)

	local list = loveframes.Create('list')
	grid:AddItem(list, 1, 1)

	for i = 1, 10 do
	    local button = loveframes.Create("button")
	    button:SetText(tostring(i))
	    list:AddItem(button)
	end

	local button = loveframes.Create("button")
	button:SetText('4, 1')
	grid:AddItem(button, 4, 1, 'center')

	local button = loveframes.Create("button")
	button:SetText('5, 5')
	grid:AddItem(button, 5, 5, 'left')

	local button = loveframes.Create("button")
	button:SetText(('5, 3'))
	grid:AddItem(button, 5, 3, 'right')

	grid.OnSizeChanged = function(object)
		frame:SetSize(object:GetWidth() + 10, object:GetHeight() + 35)
		frame:CenterWithinArea(unpack(centerarea))
	end

end

return example