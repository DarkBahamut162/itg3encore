local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("","_bar"))..{
		InitCommand=cmd(x,22;diffusealpha,0;linear,.3;diffusealpha,.6;);
	};
	LoadActor("p1a")..{
		InitCommand=cmd(x,-114;diffusealpha,0;);
		OnCommand=cmd(linear,.4;diffusealpha,1;bounce;effectmagnitude,-3,0,0;effectperiod,1.0;effectoffset,0.2;effectclock,"beat";);
	};
};

return t;