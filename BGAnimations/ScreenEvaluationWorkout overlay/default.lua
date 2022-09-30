return Def.ActorFrame{
	StandardDecorationFromFileOptional("StyleIcon","StyleIcon"),
	StandardDecorationFromFileOptional("StageDisplay","StageDisplay"),
	Def.ActorFrame{
		LoadActor("P1")..{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1),
			InitCommand=function(self) self:zoom(1/3*2):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-62):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")+6):addx(-SCREEN_WIDTH) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-SCREEN_WIDTH) end
		},
		LoadActor("P2")..{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2),
			InitCommand=function(self) self:zoom(1/3*2):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+62):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")+6):addx(SCREEN_WIDTH) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end
		}
	}
}