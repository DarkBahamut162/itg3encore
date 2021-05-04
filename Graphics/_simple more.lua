return Def.ActorFrame{
	LoadActor(THEME:GetPathG("ScreenOptions","more/_triangle"))..{
		--effectdelay,.6;
		InitCommand=function(self) self:blend(Blend.Add):x(-38):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(0.4):effectoffset(0.2):effectclock("beat") end;
		ExitSelectedP1Command=function(self) self:stoptweening():linear(.15):rotationz(-90) end;
		ExitUnselectedP1Command=function(self) self:stoptweening():linear(.15):rotationz(0) end;
	};
	LoadActor(THEME:GetPathG("ScreenOptions","more/_triangle"))..{
		--effectdelay,.6;
		InitCommand=function(self) self:blend(Blend.Add):x(38):diffuseblink():effectcolor1(color("0.6,0.6,0.6,1")):effectperiod(0.4):effectoffset(0.2):effectclock("beat") end;
		ExitSelectedP2Command=function(self) self:stoptweening():linear(.15):rotationz(90) end;
		ExitUnselectedP2Command=function(self) self:stoptweening():linear(.15):rotationz(0) end;
	};
	LoadActor(THEME:GetPathG("ScreenOptions","more/moreexit"))..{
		InitCommand=function(self) self:y(-19):croptop(.57):cropbottom(.1) end;
		GainFocusCommand=function(self) self:stoptweening():linear(.15):y(-16):croptop(.57):cropbottom(.1) end;
		LoseFocusCommand=function(self) self:stoptweening():linear(.15):y(16):croptop(.07):cropbottom(.6) end;
	};
};