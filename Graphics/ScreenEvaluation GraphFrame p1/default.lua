return Def.ActorFrame{
	Def.Sprite {
		Texture = "_base",
		Condition=not isVS(),
		OnCommand=function(self) self:x(SCREEN_CENTER_X-200*WideScreenDiff()):y(SCREEN_CENTER_Y+154*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	},
	Def.Sprite {
		Texture = "_maskp1",
		Condition=not isVS(),
		InitCommand=function(self) self:zbuffer(1):blend(Blend.NoEffect) end,
		OnCommand=function(self) self:x(SCREEN_CENTER_X-138*WideScreenDiff()):y(SCREEN_CENTER_Y+188*WideScreenDiff()):zoom(WideScreenDiff()):addx(-EvalTweenDistance()):sleep(3):decelerate(0.3):addx(EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(-EvalTweenDistance()) end
	}
}