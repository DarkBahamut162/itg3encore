return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+158;diffuse,color("#000000FF");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;);
		OnCommand=cmd(sleep,0;linear,0.2;diffusealpha,0;zoomtoheight,SCREEN_HEIGHT/1.5);
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-158;diffuse,color("#00000000");zoomto,SCREEN_WIDTH,SCREEN_HEIGHT/2;);
		OnCommand=cmd(sleep,0;linear,0.2;diffusealpha,0;zoomtoheight,SCREEN_HEIGHT/1.5);
	};
	LoadActor("lolhi")..{
		InitCommand=cmd(Center;zoomx,SCREEN_WIDTH;zoomy,.68;);
		OnCommand=cmd(linear,.5;zoomy,0);
	};
	LoadFont("_z 36px shadowx")..{
		Text="LOADING...";
		InitCommand=cmd(x,SCREEN_CENTER_X+42;CenterY;zoom,.7);
		OnCommand=cmd(linear,0.2;diffuse,color("0,0,0,0"));
	};
};