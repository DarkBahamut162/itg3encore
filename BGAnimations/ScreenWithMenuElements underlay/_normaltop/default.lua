local t = Def.ActorFrame{
	LoadActor("_width")..{
		InitCommand=function(self) self:x(SCREEN_LEFT+180):valign(0):halign(0):zoomtowidth(SCREEN_WIDTH-630) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_lside")..{
		InitCommand=function(self) self:x(SCREEN_LEFT):halign(0):valign(0) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_rside")..{
		InitCommand=function(self) self:x(SCREEN_RIGHT):halign(1):valign(0) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	LoadActor("_lmask")..{
		InitCommand=function(self) self:x(SCREEN_LEFT):halign(0):valign(0):blend('BlendMode_NoEffect'):zwrite(true):draworder(110) end;
		OnCommand=function(self) self:y(SCREEN_TOP-100):decelerate(0.8):y(SCREEN_TOP) end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	--[[
	LoadActor("up")..{
		OnCommand=function(self) self:CenterX():y(46):zoomtowidth(SCREEN_WIDTH):diffusealpha(0):sleep(0.9):diffusealpha(1):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):linear(2.5):cropleft(1):cropright(-0.3):sleep(0.1):queuecommand("On") end;
		OffCommand=function(self) self:accelerate(0.5):addy(-100) end;
	};
	]]--
};

return t;