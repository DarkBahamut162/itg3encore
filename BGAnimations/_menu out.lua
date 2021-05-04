return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y+120):diffuse(color("#00000000")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end;
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y+158) end;
	};
	Def.Quad{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-120):diffuse(color("#00000000")):zoomto(SCREEN_WIDTH,SCREEN_HEIGHT/2) end;
		OnCommand=function(self) self:sleep(0):linear(0.5):diffusealpha(1):y(SCREEN_CENTER_Y-158) end;
	};
	LoadActor("lolhi")..{
		InitCommand=function(self) self:Center():zoomx(SCREEN_WIDTH):zoomy(0) end;
		OnCommand=function(self) self:linear(0.2):zoomy(.68) end;
	};
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=function(self) self:x(SCREEN_CENTER_X+42):CenterY():cropright(1.3):faderight(0.1):zoom(.7) end;
		OnCommand=function(self) self:sleep(0.2):linear(0.5):cropright(-0.3) end;
	};
	LoadActor("_disk")..{
		InitCommand=function(self) self:x(SCREEN_CENTER_X-120):CenterY():diffusealpha(0) end;
		OnCommand=function(self) self:spin():diffusealpha(1) end;
	};
};