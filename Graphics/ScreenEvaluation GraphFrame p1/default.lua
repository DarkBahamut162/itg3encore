local t = Def.ActorFrame{
	LoadActor("_base")..{
		Condition=GAMESTATE:GetPlayMode() == PLAY_MODE_REGULAR or GAMESTATE:GetPlayMode() == PLAY_MODE_NONSTOP or GAMESTATE:GetPlayMode() == PLAY_MODE_ONI;
		OnCommand=cmd(x,SCREEN_CENTER_X-200;y,SCREEN_CENTER_Y+154;addx,-EvalTweenDistance();sleep,3;decelerate,0.3;addx,EvalTweenDistance());
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
	};
	LoadActor("_maskp1")..{
		InitCommand=cmd(zbuffer,1;blend,"BlendMode_NoEffect");
		OnCommand=cmd(x,SCREEN_CENTER_X-138;y,SCREEN_CENTER_Y+188;addx,-EvalTweenDistance();sleep,3;decelerate,0.3;addx,EvalTweenDistance());
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end;
	};
};

return t;