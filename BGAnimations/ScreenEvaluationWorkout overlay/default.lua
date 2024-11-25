local t = Def.ActorFrame{}

if ShowStandardDecoration("StyleIcon") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StyleIcon"))() .. {
		InitCommand=function(self)
			self:name("StyleIcon")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end
if ShowStandardDecoration("StageDisplay") then
	t[#t+1] = loadfile(THEME:GetPathG(Var "LoadingScreen", "StageDisplay"))() .. {
		InitCommand=function(self)
			self:name("StageDisplay")
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen")
		end
	}
end

return Def.ActorFrame{
	t,
	Def.ActorFrame{
		loadfile(THEME:GetPathB("ScreenEvaluationWorkout","overlay/P1"))()..{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1),
			InitCommand=function(self) self:zoom(1/3*2*WideScreenDiff()):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP1X")-62*WideScreenDiff()):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP1Y")+6*WideScreenDiff()):addx(-SCREEN_WIDTH) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.3):addx(-SCREEN_WIDTH) end
		},
		loadfile(THEME:GetPathB("ScreenEvaluationWorkout","overlay/P2"))()..{
			Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2),
			InitCommand=function(self) self:zoom(1/3*2*WideScreenDiff()):x(THEME:GetMetric("ScreenEvaluation","GradeFrameP2X")+62*WideScreenDiff()):y(THEME:GetMetric("ScreenEvaluation","GradeFrameP2Y")+6*WideScreenDiff()):addx(SCREEN_WIDTH) end,
			OnCommand=function(self) self:sleep(3):decelerate(0.3):addx(-SCREEN_WIDTH) end,
			OffCommand=function(self) self:accelerate(0.3):addx(SCREEN_WIDTH) end
		}
	}
}