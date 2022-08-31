return Def.ActorFrame {
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_sides")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_base")),
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay/_normaltop")),
	Def.DeviceList {
		Font="Common Normal",
		InitCommand= function (self)
			self:x(SCREEN_CENTER_X+280):y(SCREEN_BOTTOM-102):zoom(0.4):halign(1):valign(0):maxwidth(400)
		end
	},
	Def.InputList {
		Font="Common Normal",
		InitCommand=function (self)
			self:x(SCREEN_LEFT+145):y(SCREEN_CENTER_Y):maxheight(SCREEN_CENTER_Y):zoom(1):halign(0):vertspacing(8):maxwidth(560)
		end
	}
}
