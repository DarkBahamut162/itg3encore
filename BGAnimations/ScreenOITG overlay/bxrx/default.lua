return Def.ActorFrame{
	LoadActor("wipe")..{
		InitCommand=cmd(cropright,1;faderight,1;y,27;);
		OnCommand=cmd(sleep,2.7;linear,0.5;cropright,0;faderight,0);
	};
	LoadActor("boxorroxors")..{
		OnCommand=cmd(diffusealpha,0;sleep,2.6;linear,.4;diffusealpha,1);
	};
	LoadActor("_b")..{
		InitCommand=cmd(x,-35;zoom,1.6;diffusealpha,0;);
		OnCommand=cmd(sleep,.8;linear,.8;diffusealpha,1;sleep,.4;decelerate,.7;zoom,1;addx,-193;sleep,1;linear,.7;diffusealpha,0);
	};
	LoadActor("_r")..{
		InitCommand=cmd(x,35;zoom,1.6;diffusealpha,0;);
		OnCommand=cmd(sleep,.8;linear,.8;diffusealpha,1;sleep,.4;decelerate,.7;zoom,1;addx,-31;sleep,1;linear,.7;diffusealpha,0);
	};
	LoadFont("_v 26px bold shadow")..{
		Text="www.boxorroxors.net";
		InitCommand=cmd(y,52;shadowlength,2;zoom,.9;diffusealpha,0;);
		OnCommand=cmd(sleep,3;linear,0.5;diffusealpha,1);
	};
};