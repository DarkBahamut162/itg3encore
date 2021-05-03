local t = Def.ActorFrame{
	LoadActor(THEME:GetPathB("_selectmusic","menu in add"));
	Def.Actor{
		OnCommand=cmd(sleep,0.8);
	};
	LoadActor(THEME:GetPathB("_statsout","musicwheel"))..{
		InitCommand=cmd(visible,GAMESTATE:IsAnyHumanPlayerUsingMemoryCard());
	};
	LoadActor("open.ogg")..{
		OnCommand=cmd(play);
	};
};

return t;
