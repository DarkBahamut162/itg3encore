return Def.ActorFrame {
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_base"))(),
	loadfile(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop"))(),
	Def.DeviceList {
		Font="Common Normal",
		InitCommand= function (self)
			self:x(SCREEN_CENTER_X+280*WideScreenDiff()):y(SCREEN_CENTER_Y+138*WideScreenDiff()):zoom(0.4*WideScreenDiff()):halign(1):valign(0):maxwidth(400)
		end
	},
	Def.InputList {
		Font="Common Normal",
		InitCommand=function (self)
			self:x(SCREEN_LEFT+145*WideScreenDiff()):CenterY():maxheight(SCREEN_CENTER_Y):zoom(WideScreenDiff()):halign(0):vertspacing(8):maxwidth(560)
		end
	}
}
