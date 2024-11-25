return Def.ActorFrame{
	Def.Sprite {
		Texture = "../ScreenEvaluation GraphFrame p1/_base",
		Condition=not isVS(),
		InitCommand=function(self) self:zoomx(-1*WideScreenDiff()):zoomy(WideScreenDiff()) end,
		OnCommand=function(self) self:x(SCREEN_CENTER_X+200*WideScreenDiff()):y(SCREEN_CENTER_Y+154*WideScreenDiff()):addx(EvalTweenDistance()):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	},
	Def.Sprite {
		Texture = "_maskp2",
		Condition=not isVS(),
		InitCommand=function(self) self:zbuffer(1):blend(Blend.NoEffect):zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:x(SCREEN_CENTER_X+264*WideScreenDiff()):y(SCREEN_CENTER_Y+188*WideScreenDiff()):addx(EvalTweenDistance()):sleep(3):decelerate(0.3):addx(-EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(EvalTweenDistance()) end
	}
}