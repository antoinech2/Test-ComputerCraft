-- Meta class

local listButton = {}

local defaultButton = {
	x = 1,
	y = 1,
	ncol = 10,
	nline = 1,
	text = {""} ,
	textColor = {},
	backColor = {},
	defaultTextColor = colors.red ,
	defaultBackColor = colors.green ,
	screen = term ,
	userData = 0 ,
	_show = false ,
	_click = false ,
	onClick = function (btId) end ,
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

local function _text_format(txt,col)
	--print (txt,":",col)
	txt = txt or " "
	txt = string.format ("%-"..col.."s", txt)
	
	if (string.len(txt) > col) then return string.sub(txt,1,col) end
	local l1 = (col - string.len(txt))/2
	local sp = ""
	if (l1 > 0) then sp = string.rep(" ",l1) end
	txt = sp..txt..sp.."  "
	return string.sub(txt,1,col)

end

-- Derived class method new

function Create (screen,x,y,ncol,nline)
	local new_button = _copy(defaultButton);

	new_button.screen = screen or defaultButton.screen
	x = x or defaultButton.x
	y = y or defaultButton.y
	ncol = ncol or defaultButton.ncol
	nline = nline or defaultButton.nline
	
	if (x < 1) then x = defaultButton.x end
	if (y < 1) then y = defaultButton.y end
	if (ncol < 1) then ncol = defaultButton.ncol end
	if (nline < 1) then nline = defaultButton.nline end
	
	new_button.x = x;
	new_button.y = y;
	new_button.ncol = ncol;
	new_button.nline = nline;
	
	local tempString = _text_format(" ", ncol)
	
	for ind = 1,nline do
	--print (ind)
		new_button.text[ind] = tempString
		new_button.textColor[ind] = nil
		--new_button.backColor[ind] = nil
	end
	
	table.insert(listButton, new_button)

	return #listButton
end

-- Derived class method 
--	Boutton.setOption (btIndex, {Text1="Toto",TextColor=color.red))
--
function setOption(btnId,tParam)
	if (listButton[btnId]) and (type(tParam) == "table") then
		local btn = listButton[btnId]
		
		for k,v in pairs(tParam) do
			--print (k,v) ----------------------------
			local sTindex = string.match(k, '^Text(%d+)$') or "0"
			local sCindex = string.match(k, '^TextColor(%d+)$') or "0"
			local sBindex = string.match(k, '^BackColor(%d+)$') or "0"
			
			local Tindex = tonumber(sTindex)
			local Cindex = tonumber(sCindex)
			local Bindex = tonumber(sBindex)
			
			--print ("t="..Tindex..":"..Cindex..":"..Bindex.."k="..k.."v="..v) ----------------------------
			
			if (Tindex > 0) and (Tindex <= btn.nline) then btn.text[Tindex] = _text_format(v,btn.ncol)
			elseif (Cindex > 0) and (Cindex <= btn.nline) then btn.textColor[Cindex] = v
			elseif (Bindex > 0) and (Bindex <= btn.nline) then btn.backColor[Bindex] = v
			elseif (k == "TextColor") then btn.defaultTextColor = v
			elseif (k == "BackColor") then btn.defaultBackColor = v
			elseif (k == "UserData") then btn.userData = v
			end
		end
		
	end
end

function SetOnClick(btnId, func)
	if (listButton[btnId]) and (type(func) == "function") then
		listButton[btnId].onClick = func
		listButton[btnId]._click = true
		return true
	else
		return false
	end
end

function Show(btnId)
	if (listButton[btnId]) then
		listButton[btnId]._show = true
		ReDraw(btnId)
	end
end

function Hide(btnId)
	if (listButton[btnId]) and (listButton[btnId]._show) then
		local btn = listButton[btnId]
		btn._show = false
		-- save context
		local currentx, currenty = btn.screen.getCursorPos()
		-- draw each lines
		local hideString = _text_format(" ", btn.ncol)
		for index = 1,btn.nline do
			btn.screen.setCursorPos(btn.x, btn.y+index-1)
			btn.screen.write(hideString)
		end
		-- restore context
		btn.screen.setCursorPos(currentx, currenty)
	end
end

function ReDraw(btnId)
	if (listButton[btnId]) and (listButton[btnId]._show) then
		local btn = listButton[btnId]
		--_dump(btn)
		-- save context
		local currentx, currenty = btn.screen.getCursorPos()
		local currentTextColor = btn.screen.getTextColor()
		local currentBackgroundColor = btn.screen.getBackgroundColor()
		-- draw each lines
		for index = 1,btn.nline do
			btn.screen.setCursorPos(btn.x, btn.y+index-1)
			btn.screen.setBackgroundColor((btn.backColor[index]) or (btn.defaultBackColor))
			btn.screen.setTextColor((btn.textColor[index]) or (btn.defaultTextColor))
			btn.screen.write(btn.text[index])
		end
		-- restore context
		btn.screen.setCursorPos(currentx, currenty)
		btn.screen.setTextColor(currentTextColor)
		btn.screen.setBackgroundColor(currentBackgroundColor)
	end
end

function GetUserData (btnId)
	if (listButton[btnId]) then
		return listButton[btnId].userData
	end
	return 0
end

function EventClick(x,y)
	for index,btn in ipairs(listButton) do
		if (btn._show) and (btn._click) then
			if ((x >= btn.x) and (x < btn.x+btn.ncol) and
			   (y >= btn.y) and (y < btn.y+btn.nline )) then
			   print ("found:"..index)
			   btn.onClick(index)
			end
		end
 	end
end
