local t = Def.ActorFrame{
	LoadActor("_frame")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;decelerate,0.6;diffusealpha,1);
		OffCommand=cmd(diffusealpha,1;accelerate,0.6;diffusealpha,0);
	};
};

return t;