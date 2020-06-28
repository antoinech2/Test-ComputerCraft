-- Meta class

local listButton = {}

local function defaultClick(btnId)
	if (listButton[btnId]) then
		local btn = listButton[btnId]
		if (btn.state == 1) then
			btn.state = 0
			btn.display = "    Off   "
			btn.displayTextColor = colors.green
			btn.displayBackColor = colors.black
			Show(btnId)
		else
			btn.state = 1
			btn.display = "    On    "
			btn.displayTextColor = colors.red
			btn.displayBackColor = colors.green
			Show(btnId)
		end
	end
end

local defaultButton = {
	x = 1,
	y = 1,
	l = 10,
	w = 2,
	caption = "  Button  " ,
	captionTextColor = colors.white,
	captionBackColor = colors.gray,
	display = "    On    " ,
	displayTextColor = colors.red ,
	displayBackColor = colors.green ,
	screen = term ,
	state = 1 ,
	show = false ,
	onClick = defaultClick ,
}

local function _copy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

local function _dump(t)
	for k,v in pairs(t) do
		print (k.."="..tostring(v))
	end
end


-- Derived class method new

function Create (screen,x,y)
	local new_button = _copy(defaultButton);

	new_button.screen = screen or defaultButton.screen
	new_button.x = x or defaultButton.x
	new_button.y = y or defaultButton.y

	table.insert(listButton, new_button)

	return #listButton
end

-- Derived class method 

function Show(btnId)
	if (listButton[btnId]) then
		local btn = listButton[btnId]
		--_dump(btn)
		-- save context
		local currentx, currenty = btn.screen.getCursorPos()
		local currentTextColor = btn.screen.getTextColor()
		local currentBackgroundColor = btn.screen.getBackgroundColor()
		-- draw caption
		btn.screen.setCursorPos(btn.x, btn.y)
		btn.screen.setBackgroundColor(btn.captionBackColor)
		btn.screen.setTextColor(btn.captionTextColor)
		btn.screen.write(btn.caption)
		-- draw display
		btn.screen.setCursorPos(btn.x, btn.y+1)
		btn.screen.setBackgroundColor(btn.displayBackColor)
		btn.screen.setTextColor(btn.displayTextColor)
		btn.screen.write(btn.display)
		-- restore context
		btn.screen.setCursorPos(currentx, currenty)
		btn.screen.setTextColor(currentTextColor)
		btn.screen.setBackgroundColor(currentBackgroundColor)
		
		btn.show = true
	end
end

function EventClick(x,y)
	for index,btn in ipairs(listButton) do
		if (btn.show) then
			if ((x >= btn.x) and (x <= btn.x+btn.l) and
			   (y >= btn.y) and (y <= btn.y+btn.w )) then
			   print ("found:"..index)
			   btn.onClick(index)
			end
		end
 	end
end

function SetBackColor(color)
	--self.backcolor = color or colors.white
end

