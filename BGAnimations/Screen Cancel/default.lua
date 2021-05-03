return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("#000000");cropleft,1;fadeleft,.5;);
		OnCommand=cmd(linear,0.5;cropleft,-0.5;sleep,0.5);
	};
	LoadActor("cancel") .. {
		StartTransitioningCommand=cmd(play);
	};
};
