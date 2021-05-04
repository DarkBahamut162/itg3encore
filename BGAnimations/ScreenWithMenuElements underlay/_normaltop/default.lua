local t = Def.ActorFrame{
	LoadActor("_width")..{
		InitCommand=cmd(x,SCREEN_LEFT+180;valign,0;halign,0;zoomtowidth,SCREEN_WIDTH-630;);
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_lside")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;valign,0);
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_rside")..{
		InitCommand=cmd(x,SCREEN_RIGHT;halign,1;valign,0);
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_lmask")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;valign,0;blend,'BlendMode_NoEffect';zwrite,true;draworder,110;);
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
};

return t;