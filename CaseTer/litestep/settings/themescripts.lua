--  settings/themescripts.lua

require "args"
require "evar"
require "evarutils"
require "lsmodule"

--local evar = evar
local exec = lslua.exec
local table = table

local mb = lslua.message_box
local ResX = evar.ResolutionX
local ResY = evar.ResolutionY

themevars = evarutils.config["settings\\themevars"]
ampconfig = evarutils.config["config\\amp"]
desktopconfig = evarutils.config["config\\desktop"]
infoconfig = evarutils.config["config\\info"]

local label = lsmodule.xlabel

function StartMenuGroup(x)
	evar.Group = x
	local StartBackground = label.StartBackground
	if tonumber(x) == 1 then
		label.StartBackground:refresh(label.Tab1Image,'start\\tab1set1active.png')
		label.StartBackground:refresh(label.Tab1HoverImage,'start\\tab1set1active.png')
		label.StartBackground:refresh(label.Tab2Image,'start\\tab2set1normal.png')
		label.StartBackground:refresh(label.Tab2HoverImage,'start\\tab2set1hover.png')
		label.StartBackground:refresh(label.Tab3Image,'start\\tab3set1normal.png')
		label.StartBackground:refresh(label.Tab3HoverImage,'start\\tab3set1hover.png')
		label.StartMenuGroup2:hide()
		label.StartMenuGroup3:hide()
		label.StartMenuGroup1:show()
		label.StartMenuGroup1:setalwaysontop()
	elseif tonumber(x) == 2 then
		label.StartBackground:refresh(label.Tab2Image,'start\\tab2set2active.png')
		label.StartBackground:refresh(label.Tab2HoverImage,'start\\tab2set2active.png')
		label.StartBackground:refresh(label.Tab1Image,'start\\tab1set2normal.png')
		label.StartBackground:refresh(label.Tab1HoverImage,'start\\tab1set2hover.png')
		label.StartBackground:refresh(label.Tab3Image,'start\\tab3set2normal.png')
		label.StartBackground:refresh(label.Tab3HoverImage,'start\\tab3set2hover.png')
		label.StartMenuGroup1:hide()
		label.StartMenuGroup3:hide()
		label.StartMenuGroup2:show()
		label.StartMenuGroup2:setalwaysontop()
	elseif tonumber(x) == 3 then
		label.StartBackground:refresh(label.Tab3Image,'start\\tab3set3active.png')
		label.StartBackground:refresh(label.Tab3HoverImage,'start\\tab3set3active.png')
		label.StartBackground:refresh(label.Tab1Image,'start\\tab1set3normal.png')
		label.StartBackground:refresh(label.Tab1HoverImage,'start\\tab1set3hover.png')
		label.StartBackground:refresh(label.Tab2Image,'start\\tab2set3normal.png')
		label.StartBackground:refresh(label.Tab2HoverImage,'start\\tab2set3hover.png')
		label.StartMenuGroup1:hide()
		label.StartMenuGroup2:hide()
		label.StartMenuGroup3:show()
		label.StartMenuGroup3:setalwaysontop()
	end
end

function StartMenuToggle()
	local x = tonumber(evar.Group)
	if x == nil then
		--exec("!LabelToggle StartMenuGroup1")
		label.StartMenuGroup1:toggle()
	else
		exec("!LabelToggle StartMenuGroup"..x)
		--label.StartMenuGroup.x:toggle()
	end
	label.StartMenu:toggle()
	label.StartMenu:setalwaysontop()
	label.StartMenuGroup:setalwaysontop()
	label.StartMenuGroup1:setalwaysontop()
end

function bang_DesktopSongMove()
	desktopconfig.DesktopSongButtonX = evar.DesktopSongButtonCurrentX
	desktopconfig.DesktopSongButtonY = evar.DesktopSongButtonCurrentY
end

function bang_DesktopSongReset()
	label.DesktopSongButton:move(80,-100)
	desktopconfig.DesktopSongButtonX = 80
	desktopconfig.DesktopSongButtonY = -100
end

function bang_DesktopAmpToggle()
	label.DesktopAmp:toggle()
	if evar.DesktopAmpStartHidden == "on" then
		desktopconfig.DesktopAmpStartHidden = "off"
	elseif evar.DesktopAmpStartHidden == "off" then
		desktopconfig.DesktopAmpStartHidden = "on"
	end
end

function bang_DesktopClockToggle()
	label.DesktopClock:toggle()
	if evar.DesktopClockStartHidden == "on" then
		desktopconfig.DesktopClockStartHidden = "off"
	elseif evar.DesktopClockStartHidden == "off" then
		desktopconfig.DesktopClockStartHidden = "on"
	end
end

function ClockFormat(time)
	local time = tonumber(time)
	local text = tostring(text)
	
	if time == 12 then
		text = "[time('hh nn')];[date('dd mm yy')]"
	elseif time == 24 then
		text = "[time('ii nn')];[date('dd mm yy')]"
	end
	
	desktopconfig.DesktopClockText = tostring("\""..text.."\"")
	infoconfig.InfoClockText = tostring("\""..text.."\"")
	--label.DesktopClock:refresh(label.DesktopClockText,text)
	--label.InfoClock:refresh(label.InfoClockText,text)
	exec("!Recycle")
end
	