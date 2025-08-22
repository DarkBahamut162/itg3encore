return Def.ActorFrame{
	Def.Sprite {
		Texture = "base"
	},
	-- Line 1: Stage Calories
	Def.BitmapText {
		File = "_eurostile normal",
		Text="Calories Burned",
        InitCommand=function(self) self:x(-128):y(-39):zoom(0.5):horizalign(left):shadowlength(0) end
    },
	Def.RollingNumbers{
		Font="_eurostile normal",
		InitCommand=function(self) self:Load("RollingNumbersWorkoutEvaluation"):targetnumber(WorkoutGetStageCalories(PLAYER_2)):x(90):y(-39):zoom(0.5):shadowlength(0):horizalign(right):diffuse(PlayerColor(PLAYER_2)) end
	},
	Def.BitmapText {
		File = "_eurostile normal",
		Text="cals",
        InitCommand=function(self) self:x(110):y(-39):zoom(0.5):shadowlength(0) end
    },
	-- Line 2: Total Calories
	Def.BitmapText {
		File = "_eurostile normal",
		Text="Total Cals Burned",
        InitCommand=function(self) self:x(-128):y(-23):zoom(0.5):horizalign(left):shadowlength(0) end
    },
	Def.RollingNumbers{
		Font="_eurostile normal",
		InitCommand=function(self) self:Load("RollingNumbersWorkoutEvaluation"):targetnumber(WorkoutGetTotalCaloriesEvaluation(PLAYER_2)):x(90):y(-23):zoom(0.5):shadowlength(0):horizalign(right):diffuse(PlayerColor(PLAYER_2)) end
	},
	Def.BitmapText {
		File = "_eurostile normal",
		Text="cals",
        InitCommand=function(self) self:x(110):y(-23):zoom(0.5):shadowlength(0) end
    },
	-- Line 3: Gameplay Seconds
	Def.BitmapText {
		File = "_eurostile normal",
		Text="Total Play Time",
        InitCommand=function(self) self:x(-128):y(-7):zoom(0.5):horizalign(left):shadowlength(0) end
    },
	Def.RollingNumbers{
		Font="_eurostile normal",
		InitCommand=function(self) self:Load("RollingNumbersWorkoutEvaluation"):targetnumber(WorkoutGetTotalSecondsEvaluation(PLAYER_2)/60):x(90):y(-7):zoom(0.5):shadowlength(0):horizalign(right):diffuse(PlayerColor(PLAYER_2)) end
	},
	Def.BitmapText {
		File = "_eurostile normal",
		Text="mins",
        InitCommand=function(self) self:x(110):y(-7):zoom(0.5):shadowlength(0) end
    },
	-- Line 4: Goal
	Def.BitmapText {
		File = "_eurostile normal",
		Text="Fitness Goal",
        InitCommand=function(self) self:x(-128):y(9):zoom(0.5):horizalign(left):shadowlength(0) end
    },
	Def.ActorFrame{
		Condition=WorkoutGetProfileGoalType(PLAYER_2) == 0,
		Def.RollingNumbers{
			Font="_eurostile normal",
			InitCommand=function(self) self:Load("RollingNumbersWorkoutEvaluation"):targetnumber(WorkoutGetGoalCalories(PLAYER_2)):x(90):y(9):zoom(0.5):shadowlength(0):horizalign(right):diffuse(PlayerColor(PLAYER_2)) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="cals",
			InitCommand=function(self) self:x(110):y(9):zoom(0.5):shadowlength(0) end
		}
	},
	Def.ActorFrame{
		Condition=WorkoutGetProfileGoalType(PLAYER_2) == 1,
		Def.RollingNumbers{
			Font="_eurostile normal",
			InitCommand=function(self) self:Load("RollingNumbersWorkoutEvaluation"):targetnumber(WorkoutGetGoalSeconds(PLAYER_2)/60):x(90):y(9):zoom(0.5):shadowlength(0):horizalign(right):diffuse(PlayerColor(PLAYER_2)) end
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Text="mins",
			InitCommand=function(self) self:x(110):y(9):zoom(0.5):shadowlength(0) end
		}
	},
	Def.ActorFrame{
		Condition=WorkoutGetProfileGoalType(PLAYER_2) == 2,
		Def.BitmapText {
			File = "_eurostile normal",
			Text="No Goal",
			InitCommand=function(self) self:x(90):y(9):zoom(0.5):shadowlength(0):horizalign(right):diffuse(PlayerColor(PLAYER_2)) end
		}
	},
	-- Line 5: Goal Status
	Def.ActorFrame{
		Condition=WorkoutGetProfileGoalType(PLAYER_2) == 0,
		Def.ActorFrame{
			Def.BitmapText {
				File = "_eurostile normal",
				Condition=WorkoutGetPercentCompleteCaloriesEvaluation(PLAYER_2)<1,
				Text="Keep Going!",
				InitCommand=function(self) self:x(-70):y(36):zoom(0.6):shadowlength(0):diffuseshift() end
			},
			Def.BitmapText {
				File = "_eurostile normal",
				Condition=WorkoutGetPercentCompleteCaloriesEvaluation(PLAYER_2)>=1,
				Text="Goal Complete!",
				InitCommand=function(self) self:x(-70):y(36):zoom(0.6):shadowlength(0):diffuseshift() end
			},
			Def.BitmapText {
				File = "_eurostile normal",
				Text=string.format('%01.0f%% Complete',WorkoutGetPercentCompleteCaloriesEvaluation(PLAYER_2)*100),
				InitCommand=function(self) self:x(64):y(36):zoom(0.6):maxwidth(220):shadowlength(0):diffuse(PlayerColor(PLAYER_2)) end
			}
		}
	},
	Def.ActorFrame{
		Condition=WorkoutGetProfileGoalType(PLAYER_2) == 1,
		Def.ActorFrame{
			Def.BitmapText {
				File = "_eurostile normal",
				Condition=WorkoutGetPercentCompleteSecondsEvaluation(PLAYER_2)<1,
				Text="Keep Going!",
				InitCommand=function(self) self:x(-70):y(44):zoom(0.6):shadowlength(0):diffuseshift() end
			},
			Def.BitmapText {
				File = "_eurostile normal",
				Condition=WorkoutGetPercentCompleteSecondsEvaluation(PLAYER_2)>=1,
				Text="Goal Complete!",
				InitCommand=function(self) self:x(-70):y(44):zoom(0.6):shadowlength(0):diffuseshift() end
			},
			Def.BitmapText {
				File = "_eurostile normal",
				Text=string.format('%01.0f%% Complete',WorkoutGetPercentCompleteSecondsEvaluation(PLAYER_2)*100),
				InitCommand=function(self) self:x(64):y(44):zoom(0.6):maxwidth(220):shadowlength(0):diffuse(PlayerColor(PLAYER_2)) end
			}
		},
		Def.BitmapText {
			File = "_eurostile normal",
			Condition=WorkoutGetProfileGoalType(PLAYER_2) == 2,
			Text="Keep Going!",
			InitCommand=function(self) self:x(0):y(44):zoom(0.6):shadowlength(0):diffuseshift() end
		},
	},
}