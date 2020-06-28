
os.loadAPI("Button")

local function detectEvent()
    local bcontinue = true
    local event,p1,p2,p3,p4 = os.pullEvent()
	p1 = p1 or ""
	p2 = p2 or ""
	p3 = p3 or ""
	p4 = p4 or ""

	print("Event:"..event.." /p1:"..p1.." /p2:"..p2.." /p3:"..p3.." /p4:"..p4)
    if event == "monitor_touch" then
    	Button.EventClick(p2,p3)
    end
    
    if event == "key" then
    	bcontinue = false
    end
    
    return (bcontinue)
end

--- programme principal ---
local monitor = peripheral.wrap( "right" )
monitor.clear()

monitor.setCursorPos(1,1)
monitor.setTextColor(colors.red)
monitor.write( "Hello Every Body!" )

local bt1 = Button.Create(monitor,3,5,20,4)
local btOption1 = { 
	Text1 = "Bonjour",
	Text3 = "Antoine :-)",
	TextColor1 = colors.blue ,
	BackColor1 = colors.yellow ,
	BackColor = colors.green ,
	UserData = 1,
	}
local btOption2 = { 
	Text1 = "Au REVOIR",
	Text3 = "Antoine (:-(",
	TextColor1 = colors.green ,
	BackColor1 = colors.blue ,
	BackColor = colors.gray ,
	UserData = 2,
	}
			
Button.setOption( bt1, btOption1)
Button.Show(bt1)

Button.SetOnClick(bt1,
	function ()
		print ("click bt",bt1)
		if (Button.GetUserData(bt1) == 1) then
			Button.setOption( bt1, btOption2)
		else
			Button.setOption( bt1, btOption1)
		end	
			
		Button.ReDraw(bt1)
	end
	)


local btH = Button.Create(monitor,40,40,29,1)
Button.setOption( btH, {Text1 = "LUMIERE", TextColor = colors.yellow, BackColor = colors.lightBlue})
Button.Show(btH)
local btM = Button.Create(monitor,70,40,1,1)
Button.setOption( btM, {Text1 = "+", UserData = 1, TextColor = colors.orange, BackColor = colors.blue})
Button.Show(btM)
local btLON = Button.Create(monitor,40,41,9,3)
Button.setOption( btLON, {Text1 = "ON", TextColor = colors.Gray, BackColor = colors.lightGray})
local btLOFF = Button.Create(monitor,50,41,9,3)
Button.setOption( btLOFF, {Text1 = "OFF", TextColor = colors.Gray, BackColor = colors.lightGray})
local btLAUTO = Button.Create(monitor,60,41,9,3)
Button.setOption( btLAUTO, {Text1 = "AUTO", TextColor = colors.Gray, BackColor = colors.lightGray})




local bcontinue = true
while bcontinue do
	bcontinue = detectEvent()
end
