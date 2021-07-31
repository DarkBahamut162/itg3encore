local t = Def.ActorFrame{
	LoadActor("_base")..{
		Condition=GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave';
		InitCommand=function(self) self:zoomx(-1) end; 
		OnCommand=function(self) self:x(SCREEN_CENTER_X+200):y(SCREEN_CENTER_Y+154):addx(EvalTweenDistance()):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
	};
	LoadActor("_maskp2")..{
		Condition=GAMESTATE:GetPlayMode() ~= 'PlayMode_Rave';
		InitCommand=function(self) self:zbuffer(1):blend("BlendMode_NoEffect") end;
		OnCommand=function(self) self:x(SCREEN_CENTER_X+264):y(SCREEN_CENTER_Y+188):addx(EvalTweenDistance()):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end;
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end;
	};
	LoadActor("_frame mask")..{
		Condition=GAMESTATE:GetPlayMode() == 'PlayMode_Rave';
		InitCommand=function(self) self:zbuffer(1):blend("BlendMode_NoEffect"):x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-30):zoomx(0.80):zoomy(1.005):addy(SCREEN_HEIGHT) end;
		OnCommand=function(self) self:sleep(3):decelerate(0.3):addy(-SCREEN_HEIGHT) end;
		OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_HEIGHT) end;
	};
};

return t;