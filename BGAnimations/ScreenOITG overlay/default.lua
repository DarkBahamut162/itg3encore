return Def.ActorFrame{
	--[[
	LoadActor("openitg")..{
		InitCommand=function(self) self:x(SCREEN_LEFT-15):y(SCREEN_CENTER_Y-SCREEN_HEIGHT/2.8):zoom(0.65) end;
	};
	--]]

	LoadActor("itg")..{
		InitCommand=function(self) self:CenterX():y(SCREEN_CENTER_Y-80):zoom(0.7) end;
	};

	LoadActor("sm5")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+192):y(WideScale(SCREEN_CENTER_Y+64,SCREEN_CENTER_Y+80)):zoom(0.65) end;
	};
	LoadActor("bxrx")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT-SCREEN_WIDTH/3.3):y(WideScale(SCREEN_CENTER_Y+132,SCREEN_CENTER_Y+80)):zoom(0.6) end;
	};

	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffusealpha(1) end;
		OnCommand=function(self) self:sleep(0.1):accelerate(0.5):diffusealpha(0) end;
	};
	LoadActor(THEME:GetPathB("ScreenAttract","overlay"));
};