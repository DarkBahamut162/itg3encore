local t = Def.ActorFrame{
	LoadActor("_base")..{
		Condition=not isRave();
		OnCommand=function(self) self:x(SCREEN_CENTER_X-200):y(SCREEN_CENTER_Y+154):addx(-EvalTweenDistance()):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
	};
	LoadActor("_maskp1")..{
		Condition=not isRave();
		InitCommand=function(self) self:zbuffer(1):blend("BlendMode_NoEffect") end;
		OnCommand=function(self) self:x(SCREEN_CENTER_X-138):y(SCREEN_CENTER_Y+188):addx(-EvalTweenDistance()):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end;
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
	};
	LoadActor("_frame mask")..{
		Condition=isRave();
		InitCommand=function(self) self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-30):zoomx(0.80):zoomy(1.005):addy(SCREEN_HEIGHT):zbuffer(1):blend("BlendMode_NoEffect") end;
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addy(-SCREEN_HEIGHT) end;
		OffCommand=function(self) self:accelerate(0.3):addy(SCREEN_HEIGHT) end;
	};
};

return t;