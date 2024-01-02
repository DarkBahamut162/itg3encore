return Def.ActorFrame{
	InitCommand=function(self) self:y(-77*WideScreenDiff())end,
	LoadActor(THEME:GetPathG("ScreenOptions","more/moreexit")) .. {
		Text="Exit",
		InitCommand=function(self) self:CenterX():y(-10*WideScreenDiff()):zoom(WideScreenDiff()):croptop(0.57):cropbottom(0.1):diffuse(color("0.5,0.5,0.5,1")) end,
		OnCommand=function(self) self:diffusealpha(0):decelerate(0.5):diffusealpha(1) end,
		OffCommand=function(self) self:stoptweening():accelerate(0.3):diffusealpha(0):queuecommand("Hide") end,
		HideCommand=function(self) self:visible(false) end,
		GainFocusCommand=function(self) self:linear(0.2):diffuse(color("1,1,1,1")) end,
		LoseFocusCommand=function(self) self:stoptweening():linear(0.2):diffuse(color("0.5,0.5,0.5,1")) end
	},
	Def.ActorFrame{
		Name="Triangles",
		InitCommand=function(self) self:CenterX():y(6*WideScreenDiff()):zoom(WideScreenDiff()) end,
		LoadActor(THEME:GetPathG("ScreenOptions","more/_triangle "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:zoom(0.5):blend(Blend.Add):x(-38*WideScreenSemiDiff()):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(1):effectoffset(0):effectclock("beat") end,
			GainFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(-90) end,
			LoseFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(0) end
		},
		LoadActor(THEME:GetPathG("ScreenOptions","more/_triangle "..(isFinal() and "final" or "normal")))..{
			InitCommand=function(self) self:zoom(0.5):blend(Blend.Add):x(38*WideScreenSemiDiff()):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(1):effectoffset(0):effectclock("beat") end,
			GainFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(90) end,
			LoseFocusCommand=function(self) self:stoptweening():linear(0.15):rotationz(0) end
		}
	}
}