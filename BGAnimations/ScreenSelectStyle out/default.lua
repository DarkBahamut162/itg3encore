return Def.ActorFrame{
	-- sound

	Def.Quad{
		InitCommand=function(self) self:Center():diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.5):linear(0.31):diffusealpha(1) end;
	};
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+120):diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y+158) end;
	};
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-120):diffuse(color("0,0,0,1")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y-158) end;
	};

	-- lolhi (no card) vs. profile (card)
	Def.Sprite{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0) end;
		BeginCommand=function(self)
			self:Load(THEME:GetPathB("","lolhi"))
		end;
		OnCommand=function(self) self:linear(0.5):zoomy(0.68) end;
	};

	LoadFont("_z 36px black")..{
		Text="Loading Profiles...";
		InitCommand=function(self) self:Center():zoom(0.7):cropright(1.3):faderight(0.1):visible(false) end;
		OnCommand=function(self) self:sleep(0.25):linear(0.7):cropright(-0.3) end;
	};
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=function(self) self:Center():zoom(0.7):cropright(1.3):faderight(0.1):visible(true) end;
		OnCommand=function(self) self:sleep(0.25):linear(0.7):cropright(-0.3) end;
	};
	-- disk (no card)

	LoadActor("stats");
};