return Def.ActorFrame{
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Easy"))()..{
		InitCommand=function(self) self:y(scale(2,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Medium"))()..{
		InitCommand=function(self) self:y(scale(3,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Hard"))()..{
		InitCommand=function(self) self:y(scale(4,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Expert"))()..{
		InitCommand=function(self) self:y(scale(5,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","CourseDifficulty Medium"))()..{
		Condition=not isEtterna("0.55"),
		InitCommand=function(self) self:y(scale(6,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","CourseDifficulty Hard"))()..{
		Condition=not isEtterna("0.55"),
		InitCommand=function(self) self:y(scale(7,1,7,SCREEN_CENTER_Y-150*WideScreenDiff(),SCREEN_CENTER_Y+10*WideScreenDiff())) end
	}
}