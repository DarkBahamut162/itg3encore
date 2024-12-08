local currentAction = {
	["Clear"] = 0,
	["Reload"] = 1,
	["Save"] = 2,
	["SetList"] = 3,
}

return Def.BitmapText{
	Font="Common Normal",
	InitCommand=function(self) self:x(SCREEN_CENTER_X):y(2*WideScreenDiff()):zoom(0.5*WideScreenDiff(),0):diffuse(color("#FFFFFF")) end,
	OnCommand=function(self)
		self:addx(currentAction[self:GetName()] < 2 and -145*(1.5-currentAction[self:GetName()]) or 145*(currentAction[self:GetName()]-1.5))
		:addy((-28*WideScreenDiff())*currentAction[self:GetName()]):diffusealpha(0):decelerate(0.5):diffusealpha(1):settext(THEME:GetString("ScreenMapControllers", "Action" .. self:GetName()))
	end,
	OffCommand=function(self) self:stoptweening():accelerate(0.3):diffusealpha(0):queuecommand("Hide") end,
	HideCommand=function(self) self:visible(false) end,
	GainFocusCommand=function(self) self:diffuseshift():effectcolor1(color("#808080")):effectcolor2(color("#FFFFFF")) end,
	LoseFocusCommand=function(self) self:stopeffect() end
}
