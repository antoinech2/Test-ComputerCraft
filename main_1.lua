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

local bt1 = Button.Create(monitor,3,5)
Button.Show(bt1)

local bt2 = Button.Create(monitor,33,5)
Button.Show(bt2)

local bcontinue = true
while bcontinue do
	bcontinue = detectEvent()
end
