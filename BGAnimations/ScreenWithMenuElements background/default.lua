return Def.ActorFrame{
	LoadActor("CJ112")..{
		InitCommand=cmd(Center;FullScreen);
	};
	-- clear the zbuffer so that screens can draw without having to clear it
	Def.Actor{ InitCommand=cmd(clearzbuffer,true); };
}
