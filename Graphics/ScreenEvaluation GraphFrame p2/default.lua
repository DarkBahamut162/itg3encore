return Def.ActorFrame{
	LoadActor("../ScreenEvaluation GraphFrame p1/_base")..{
		Condition=not isRave(),
		InitCommand=function(self) self:zoomx(-1) end, 
		OnCommand=function(self) self:x(SCREEN_CENTER_X+200):y(SCREEN_CENTER_Y+154):addx(EvalTweenDistance()):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
	LoadActor("_maskp2")..{
		Condition=not isRave(),
		InitCommand=function(self) self:zbuffer(1):blend("BlendMode_NoEffect") end,
		OnCommand=function(self) self:x(SCREEN_CENTER_X+264):y(SCREEN_CENTER_Y+188):addx(EvalTweenDistance()):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	}
}