-- ScreenSelectStyle Icon Choice2
return Def.ActorFrame{
	LoadFont("_r bold glow 30px")..{
		Text="Two Players, each use 4 Panels";
		InitCommand=cmd(x,SCREEN_CENTER_X+100;y,SCREEN_CENTER_Y+138;zoom,.68;maxwidth,840;horizalign,center;shadowlength,0);
		GainFocusCommand=function(self) self:visible(true):finishtweening():cropright(1):linear(0.5):cropright(0) end;
		LoseFocusCommand=function(self) self:visible(false) end;
		OffCommand=function(self) self:linear(0.3):diffusealpha(0) end;
	};
	Def.ActorFrame{
		InitCommand=cmd(x,SCREEN_LEFT+65;y,SCREEN_CENTER_Y-95+120;horizalign,left;ZoomToWidth,150;ZoomToHeight,110);
		LoadActor(THEME:GetPathG("_join","icons/choice2"))..{
			OnCommand=cmd(y,-2;zoomto,150,110);
			GainFocusCommand=cmd(accelerate,0.1;diffuse,color("#FFFFFF");x,52+19;);
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(52) end;
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end;
		};
		LoadActor(THEME:GetPathG("_join","icons/versus_icon"))..{
			GainFocusCommand=cmd(accelerate,0.1;diffuse,color("#FFFFFF");x,SCREEN_LEFT+65);
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):diffuse(color("#636363")):x(SCREEN_LEFT+46) end;
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end;
		};
		LoadActor(THEME:GetPathG("_join","icons/styleglow"))..{
			InitCommand=function(self) self:blend(Blend.Add) end;
			GainFocusCommand=cmd(accelerate,0.1;diffusealpha,1;x,SCREEN_LEFT+65;sleep,.07;linear,.2;diffusealpha,0);
			LoseFocusCommand=function(self) self:finishtweening():decelerate(0.1):x(SCREEN_LEFT+46):diffusealpha(0) end;
			OffFocusCommand=function(self) self:accelerate(0.4):addx(-SCREEN_WIDTH*.5) end;
		};
	};
};