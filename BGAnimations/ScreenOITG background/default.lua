return Def.ActorFrame{
	LoadActor("PROCFB")..{
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_WIDTH/4*3);
	};
};