local t = Def.Quad{
		InitCommand=cmd(Center;FullScreen;);
		OnCommand=cmd(linear,0.3;diffusealpha,0);
};

return t;