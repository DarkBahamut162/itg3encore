return Def.ActorFrame{
	LoadActor(THEME:GetPathS("_options","to options"))..{
		OnCommand=cmd(play);
	};
};