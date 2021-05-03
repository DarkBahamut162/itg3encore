return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+120;diffuse,color("#00000000");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;);
		OnCommand=cmd(sleep,0;linear,0.5;diffusealpha,1;y,SCREEN_CENTER_Y+158;);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-120;diffuse,color("#00000000");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;);
		OnCommand=cmd(sleep,0;linear,0.5;diffusealpha,1;y,SCREEN_CENTER_Y-158;);
	};
	LoadActor("lolhi")..{
		InitCommand=cmd(Center;zoomx,SCREEN_WIDTH;zoomy,0;);
		OnCommand=cmd(linear,0.2;zoomy,.68);
	};
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=cmd(x,SCREEN_CENTER_X+42;CenterY;cropright,1.3;faderight,0.1;zoom,.7);
		OnCommand=cmd(sleep,0.2;linear,0.5;cropright,-0.3);
	};
	LoadActor("_disk")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120;CenterY;diffusealpha,0;);
		OnCommand=cmd(spin;diffusealpha,1;);
	};
};