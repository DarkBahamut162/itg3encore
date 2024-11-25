return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenOptions","more/_triangle "..(isFinal() and "final" or "normal")),
		InitCommand=function(self) self:zoom(0.5):blend(Blend.Add):x(-38):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(0.4):effect_hold_at_full(0.6):effectoffset(0.2):effectclock("beat") end,
		ExitSelectedP1Command=function(self) self:stoptweening():linear(0.15):rotationz(-90) end,
		ExitUnselectedP1Command=function(self) self:stoptweening():linear(0.15):rotationz(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenOptions","more/_triangle "..(isFinal() and "final" or "normal")),
		InitCommand=function(self) self:zoom(0.5):blend(Blend.Add):x(38):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(0.4):effect_hold_at_full(0.6):effectoffset(0.2):effectclock("beat") end,
		ExitSelectedP2Command=function(self) self:stoptweening():linear(0.15):rotationz(90) end,
		ExitUnselectedP2Command=function(self) self:stoptweening():linear(0.15):rotationz(0) end
	},
	Def.Sprite {
		Texture = THEME:GetPathG("ScreenOptions","more/moreexit"),
		InitCommand=function(self) self:y(-19):croptop(0.57):cropbottom(0.1) end,
		GainFocusCommand=function(self) self:stoptweening():linear(0.15):y(-16):croptop(0.57):cropbottom(0.1) end,
		LoseFocusCommand=function(self) self:stoptweening():linear(0.15):y(16):croptop(0.07):cropbottom(0.6) end
	}
}