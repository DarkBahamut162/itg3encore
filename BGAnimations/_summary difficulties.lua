return Def.ActorFrame{
	LoadActor(THEME:GetPathG("ScreenRanking","Difficulty Easy"))..{
		InitCommand=cmd(y,scale(2,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););
	};
	LoadActor(THEME:GetPathG("ScreenRanking","Difficulty Medium"))..{
		InitCommand=cmd(y,scale(3,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););
	};
	LoadActor(THEME:GetPathG("ScreenRanking","Difficulty Hard"))..{
		InitCommand=cmd(y,scale(4,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););
	};
	LoadActor(THEME:GetPathG("ScreenRanking","Difficulty Expert"))..{
		InitCommand=cmd(y,scale(5,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););
	};
	LoadActor(THEME:GetPathG("ScreenRanking","CourseDifficulty Medium"))..{
		InitCommand=cmd(y,scale(6,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););
	};
	LoadActor(THEME:GetPathG("ScreenRanking","CourseDifficulty Hard"))..{
		InitCommand=cmd(y,scale(7,1,7,SCREEN_CENTER_Y-150,SCREEN_CENTER_Y+10););
	};
};