return Def.ActorFrame{
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Easy"))()..{
		InitCommand=function(self) self:y(scale(2,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Medium"))()..{
		InitCommand=function(self) self:y(scale(3,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Hard"))()..{
		InitCommand=function(self) self:y(scale(4,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","Difficulty Expert"))()..{
		InitCommand=function(self) self:y(scale(5,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","CourseDifficulty Medium"))()..{
		InitCommand=function(self) self:y(scale(6,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	},
	loadfile(THEME:GetPathG("ScreenRanking","CourseDifficulty Hard"))()..{
		InitCommand=function(self) self:y(scale(7,1,7,SCREEN_CENTER_Y-130*WideScreenDiff(),SCREEN_CENTER_Y+130*WideScreenDiff())) end
	}
}