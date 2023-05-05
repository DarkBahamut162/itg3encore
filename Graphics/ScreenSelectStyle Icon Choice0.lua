return Def.ActorFrame{
	OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
	LoadFont("_r bold glow 30px")..{
		Text="This game mode isn't supported!",
		InitCommand=function(self) self:x(SCREEN_CENTER_X+100*((WideScreenDiff()+WideScreenSemiDiff())/2)):y(SCREEN_CENTER_Y+125+12*WideScreenSemiDiff()):zoom(0.68*WideScreenDiff()):maxwidth(840):shadowlength(0) end,
		OnCommand=function(self) self:diffuse(Color.Red) end,
		GainFocusCommand=function(self) self:visible(true):finishtweening():cropright(1):linear(0.5):cropright(0) end,
		LoseFocusCommand=function(self) self:visible(false) end
	}
}