local completeGoal = {
	PLAYER_1 = false,
	PLAYER_2 = false
}

return Def.ActorFrame{
	Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_1),
		Def.RollingNumbers{
			Font="_r bold numbers",
			PlayerNumber=PLAYER_1,
			InitCommand=function(self) self:Load("RollingNumbersCalories"):targetnumber(WorkoutGetTotalCaloriesEvaluation(PLAYER_1))
				:x(THEME:GetMetric("ScreenGameplay","ScoreP1X")):y(THEME:GetMetric("ScreenGameplay","ScoreP1Y")+12*WideScreenDiff())
				:shadowlength(2):zoom(WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):addy(-100) end,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end,
			OffCommand=function(self) self:accelerate(0.8):addy(-100) end,
			StepMessageCommand=function(self,params)
				if params.PlayerNumber == PLAYER_1 then
					self:targetnumber(WorkoutGetTotalCaloriesGameplay(PLAYER_1))
				end
			end
		},
		Def.ScoreDisplayAliveTime{
			Font="_r bold numbers",
			PlayerNumber=PLAYER_1,
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay","ScoreP1X")):y(SCREEN_BOTTOM-38*WideScreenDiff())
				:shadowlength(2):zoom(0.85*WideScreenDiff()):diffuse(PlayerColor(PLAYER_1)):addy(100) end,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.8):addy(100) end
		},
		Def.BitmapText{
			Font="_eurostile normal",
			Text="Goal Complete!",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay","ScoreP1X")):y(SCREEN_BOTTOM-62*WideScreenDiff())
				:zoom(0.6*WideScreenDiff()):diffuseshift():effectcolor1(0.5,0.5,0.5,1):diffusealpha(0):addy(100)
				if WorkoutGetPercentCompleteCaloriesGameplay(PLAYER_1)>=1 then self:queuecommand("GoalCompleteP1") end
			end,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.8):addy(100) end,
			StepMessageCommand=function(self,params)
				if params.PlayerNumber == PLAYER_1 then
					if WorkoutGetPercentCompleteCaloriesGameplay(PLAYER_1)>=1 then self:queuecommand("GoalCompleteP1") end
				end
			end,
			GoalCompleteP1Command=function(self)
				if not completeGoal[PLAYER_1] then self:zoom(2*WideScreenDiff()):linear(0.5):zoom(0.7*WideScreenDiff()):diffusealpha(1) completeGoal[PLAYER_1] = true end
			end
		}
	},
	Def.ActorFrame{
		Condition=GAMESTATE:IsPlayerEnabled(PLAYER_2),
		Def.RollingNumbers{
			Font="_r bold numbers",
			Format="%5.2fc",
			PlayerNumber=PLAYER_2,
			InitCommand=function(self) self:Load("RollingNumbersCalories"):targetnumber(WorkoutGetTotalCaloriesEvaluation(PLAYER_2))
				:x(THEME:GetMetric("ScreenGameplay","ScoreP2X")):y(THEME:GetMetric("ScreenGameplay","ScoreP2Y")+12)
				:shadowlength(2):zoom(WideScreenDiff()):diffuse(PlayerColor(PLAYER_2)):addy(-100) end,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(100) end,
			OffCommand=function(self) self:accelerate(0.8):addy(-100) end,
			StepMessageCommand=function(self,params)
				if params.PlayerNumber == PLAYER_2 then
					self:targetnumber(WorkoutGetTotalCaloriesGameplay(PLAYER_2))
				end
			end
		},
		Def.ScoreDisplayAliveTime{
			Font="_r bold numbers",
			PlayerNumber=PLAYER_2,
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay","ScoreP2X")):y(SCREEN_BOTTOM-38)
				:shadowlength(2):zoom(0.85*WideScreenDiff()):diffuse(PlayerColor(PLAYER_2)):addy(100) end,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.8):addy(100) end
		},
		Def.BitmapText{
			Font="_eurostile normal",
			Text="Goal Complete!",
			InitCommand=function(self) self:x(THEME:GetMetric("ScreenGameplay","ScoreP2X")):y(SCREEN_BOTTOM-38-24)
				:zoom(0.6*WideScreenDiff()):diffuseshift():effectcolor1(0.5,0.5,0.5,1):diffusealpha(0):addy(100)
				if WorkoutGetPercentCompleteCaloriesGameplay(PLAYER_2)>=1 then self:queuecommand("GoalCompleteP2") end
			end,
			OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addy(-100) end,
			OffCommand=function(self) self:accelerate(0.8):addy(100) end,
			StepMessageCommand=function(self,params)
				if params.PlayerNumber == PLAYER_2 then
					if WorkoutGetPercentCompleteCaloriesGameplay(PLAYER_2)>=1 then self:queuecommand("GoalCompleteP2") end
				end
			end,
			GoalCompleteP2Command=function(self) if not completeGoal[PLAYER_2] then self:zoom(2*WideScreenDiff()):linear(0.5):zoom(0.7*WideScreenDiff()):diffusealpha(1) completeGoal[PLAYER_2] = true end end
		}
	},
	LoadActor("ScreenGameplay overlay")
}