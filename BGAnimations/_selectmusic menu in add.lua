-- holdover from loading profiles
return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("0,0,0,1")) end;
		OnCommand=function(self) self:linear(0.2):diffusealpha(0) end;
	};
	LoadActor("lolhi")..{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard();
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end;
		OnCommand=function(self) self:linear(0.2):zoomy(0.0) end;
	};
	LoadActor("profile")..{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard();
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0.68) end;
		OnCommand=function(self) self:linear(0.2):zoomy(0.0) end;
	};
	LoadFont("_z 36px shadowx")..{
		Condition=not GAMESTATE:IsAnyHumanPlayerUsingMemoryCard();
		Text="LOADING...";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+42):CenterY():zoom(0.7) end;
		OnCommand=function(self) self:linear(0.2):diffuse(color("0,0,0,0")) end;
	};
	LoadFont("_z 36px shadowx")..{
		Condition=GAMESTATE:IsAnyHumanPlayerUsingMemoryCard();
		Text="LOADING PROFILES...";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+42):CenterY():zoom(0.7) end;
		OnCommand=function(self) self:linear(0.2):diffuse(color("0,0,0,0")) end;
	};
};
