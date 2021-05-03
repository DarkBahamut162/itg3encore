return Def.ActorFrame{
	LoadActor("CJ113")..{
		InitCommand=cmd(Center;FullScreen);
	};
	LoadActor("roxor")..{
		InitCommand=cmd(Center;FullScreen;blend,Blend.Add;sleep,6);
	};
};