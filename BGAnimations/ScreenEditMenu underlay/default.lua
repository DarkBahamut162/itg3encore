return Def.ActorFrame{
	LoadActor("main")..{ InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-32); };
	LoadActor("explanation")..{ InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+138); };
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","underlay"))
};