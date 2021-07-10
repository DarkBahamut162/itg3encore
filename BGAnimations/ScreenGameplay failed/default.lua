return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("#00000000")) end;
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end;
	};

	LoadActor("_stage")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-75):zoom(0.6):diffusealpha(0):addy(-30) end;
		OnCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1):addy(30) end;
	};
	Def.ActorFrame{
		Name="NormalFail";
		InitCommand=function(self) self:visible(songfail(false)) end;
		LoadActor("_failed text")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+2):y(SCREEN_CENTER_Y+30):diffusealpha(0):addx(-500) end;
			OnCommand=function(self) self:sleep(0.4):decelerate(0.7):addx(500):diffusealpha(1) end;
		};
	};
	Def.ActorFrame{
		Name="VertexFail";
		InitCommand=function(self) self:visible(songfail(true)) end;
		LoadActor("v_failed")..{
			InitCommand=function(self) self:x(SCREEN_CENTER_X+2):y(SCREEN_CENTER_Y+52):diffusealpha(0.2):cropleft(0.5):cropright(0.5) end;
			OnCommand=function(self) self:sleep(0.7):decelerate(0.75):cropright(0):cropleft(0):diffusealpha(1) end;
		};
		LoadActor(THEME:GetPathB("ScreenSelectStyle","out/horiz-line"))..{
			InitCommand=function(self) self:zoomx(2):rotationz(90):x(SCREEN_CENTER_X+1):y(SCREEN_CENTER_Y+52):cropleft(0.5):cropright(0.5) end;
			OnCommand=function(self) self:sleep(0.55):accelerate(0.15):cropleft(0):cropright(0):decelerate(0.725):addx(-300):linear(0.15):diffusealpha(0) end;
		};
		LoadActor(THEME:GetPathB("ScreenSelectStyle","out/horiz-line"))..{
			InitCommand=function(self) self:zoomx(2):rotationz(90):x(SCREEN_CENTER_X+2):y(SCREEN_CENTER_Y+52):cropleft(0.5):cropright(0.5) end;
			OnCommand=function(self) self:sleep(0.55):accelerate(0.15):cropleft(0):cropright(0):decelerate(0.725):addx(300):linear(0.15):diffusealpha(0) end;
		};
	};

	-- There would be code here, but I am not one of the people who wishes to
	-- acknowledge the existence of an overplayed piece of crap meme. If you
	-- want whatever Lightning added when you failed Crispy's "The Game" (from
	-- the original ITG) in the ITG3 theme to appear in this port, you'll have
	-- to add it yourself. I'm not going to do it for you. -freem.

	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("#00000000")) end;
		OnCommand=function(self) self:sleep(3):linear(0.3):diffusealpha(1) end;
	};
};