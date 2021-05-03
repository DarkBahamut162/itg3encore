return Def.ActorFrame{
	InitCommand=cmd(y,scale(1,1,7,SCREEN_CENTER_Y-130,SCREEN_CENTER_Y+130));
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier01"))..{ InitCommand=cmd(zoom,0.45;x,scale(1,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier02"))..{ InitCommand=cmd(zoom,0.45;x,scale(2,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier03"))..{ InitCommand=cmd(zoom,0.45;x,scale(3,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier04"))..{ InitCommand=cmd(zoom,0.45;x,scale(4,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier05"))..{ InitCommand=cmd(zoom,0.45;x,scale(5,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier06"))..{ InitCommand=cmd(zoom,0.45;x,scale(6,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier07"))..{ InitCommand=cmd(zoom,0.45;x,scale(7,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier08"))..{ InitCommand=cmd(zoom,0.45;x,scale(8,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier09"))..{ InitCommand=cmd(zoom,0.45;x,scale(9,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
	LoadActor(THEME:GetPathG("GradeDisplayEval","Tier10"))..{ InitCommand=cmd(zoom,0.45;x,scale(10,1,10,SCREEN_LEFT+160,SCREEN_RIGHT-50)); };
};