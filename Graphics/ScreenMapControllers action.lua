return Def.BitmapText{
	Font="Common Normal",
	InitCommand= function (self) self:x(SCREEN_CENTER_X):zoom(0.5*WideScreenDiff(), 0):diffuse(color("#FFFFFF")) end,
	OnCommand= function(self)
		self:diffusealpha(0):decelerate(0.5):diffusealpha(1):settext(THEME:GetString("ScreenMapControllers", "Action" .. self:GetName()))
	end,
	OffCommand=function (self) self:stoptweening():accelerate(0.3):diffusealpha(0):queuecommand("Hide") end,
	HideCommand=function (self) self:visible(false) end,
	GainFocusCommand=function (self) self:diffuseshift():effectcolor1(color("#808080")):effectcolor2(color("#FFFFFF")) end,
	LoseFocusCommand=function (self) self:stopeffect() end
}
