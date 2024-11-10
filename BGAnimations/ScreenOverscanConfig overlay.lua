local valtex_buttons = {
	CenterImageAddWidth = {"d", "a"},
	CenterImageAddHeight = {"w", "s"},
	CenterImageTranslateX = {"l", "j"},
	CenterImageTranslateY = {"k", "i"}
}
local valtex = {}

local function change_center_val(valname, amount)
	local new_val = PREFSMAN:GetPreference(valname) + amount
	PREFSMAN:SetPreference(valname, new_val)
	valtex[valname]:settext(new_val)
	update_centering()
end

local valtex_frames = {}
local widest_name = 0

local function valtexact(name, x, y, c)
	return Def.ActorFrame{
		InitCommand=function(self)
			valtex_frames[name] = self
			local name_w = self:GetChild("Name"):GetWidth()
			if name_w > widest_name then widest_name = name_w end
			self:y(y)
			for frame in ivalues(valtex_frames) do
				frame:playcommand("recenter")
			end
		end,
		recenterCommand= function(self)
			self:x(x + (widest_name / 2)*WideScreenDiff())
		end,
		Def.BitmapText{
			Font = "Common Normal",
			Name = "Value",
			InitCommand=function(self)
				valtex[name] = self
				self:x(4):settext(PREFSMAN:GetPreference(name)):horizalign(left):zoom(WideScreenDiff())
			end
		},
		Def.BitmapText{
			Font = "Common Normal",
			Name = "Name",
			InitCommand=function(self)
				self:x(-4):settext(THEME:GetString("ScreenOverscanConfig",name).."("..valtex_buttons[name][1].." "..THEME:GetString("ScreenOverscanConfig","OrSeparator").." "..valtex_buttons[name][2].."):")
				:horizalign(right):diffuse(c):zoom(WideScreenDiff())
			end
		}
	}
end

local function input(event)
	if event.type == "InputEventType_Release" then return false end
	local button = ToEnumShortString(event.DeviceInput.button)
	local gamebutton = event.GameButton
	local input_functions = {
		Start=function()
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			SOUND:PlayOnce(THEME:GetPathS("Common", "Start"), true)
		end,
		Back=function() SCREENMAN:GetTopScreen():Cancel() end
	}
	if input_functions[gamebutton] then input_functions[gamebutton]() end

	for valname, button_set in pairs(valtex_buttons) do
		if button == button_set[1] then
			change_center_val(valname, 1)
		elseif button == button_set[2] then
			change_center_val(valname, -1)
		end
	end
end

local function quaid(x, y, w, h, c, ha, va)
	return Def.Quad{
		InitCommand= function(self) self:xy(x, y):setsize(w, h):diffuse(c):horizalign(ha):vertalign(va) end
	}
end

local red = color("#ff0000")
local blue = color("#0000ff")

local args = {
	OnCommand= function(self) SCREENMAN:GetTopScreen():AddInputCallback(input) end,
	quaid(0, 0, _screen.w, 1, red, left, top),
	quaid(0, _screen.h, _screen.w, 1, red, left, bottom),
	quaid(0, 0, 1, _screen.h, blue, left, top),
	quaid(_screen.w, 0, 1, _screen.h, blue, right, top),
	valtexact("CenterImageAddHeight", _screen.cx, _screen.cy-36, red),
	valtexact("CenterImageAddWidth", _screen.cx, _screen.cy-12, blue),
	valtexact("CenterImageTranslateX", _screen.cx, _screen.cy+12, blue),
	valtexact("CenterImageTranslateY", _screen.cx, _screen.cy+36, red),
}

return Def.ActorFrame(args)
