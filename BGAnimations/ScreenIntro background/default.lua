return Def.ActorFrame{
	LoadActor("intro")..{ InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,SCREEN_WIDTH/4*3;rate,.92;sleep,35;diffusealpha,0); };

	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_TOP;vertalign,top;zoomto,SCREEN_WIDTH,(SCREEN_WIDTH/4*.35)/2;diffuse,color("0,0,0,1"));
	};
	Def.Quad{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM;vertalign,bottom;zoomto,SCREEN_WIDTH,(SCREEN_WIDTH/4*.35)/2;diffuse,color("0,0,0,1"));
	};

	Def.ActorFrame{
		InitCommand=cmd(Center);
		LoadActor("swoosh")..{
			InitCommand=cmd(y,20;zoomtowidth,SCREEN_WIDTH;blend,Blend.Add;cropright,1;faderight,1;);
			OnCommand=cmd(linear,0.5;cropright,0;faderight,0;sleep,4;linear,0.5;diffusealpha,0.0;addx,50;cropleft,1;fadeleft,1;);
		};
		LoadFont("_v 26px bold glow")..{
			Text="RoXoR Games Presents";
			InitCommand=cmd(blend,Blend.Add;cropright,1;faderight,1;);
			OnCommand=cmd(sleep,.1;linear,.2;cropright,0;faderight,0;sleep,2;linear,0.5;diffusealpha,0);
		};
		LoadFont("_v credit")..{
			Text="RoXoR Games Presents";
			InitCommand=cmd(cropright,1;faderight,1;);
			OnCommand=cmd(sleep,.1;linear,.2;cropright,0;faderight,0;sleep,2;linear,0.5;diffusealpha,0);
		};
	};
	Def.ActorFrame{
		Name="WaveLogo";
		InitCommand=cmd(x,SCREEN_CENTER_X-30;y,SCREEN_CENTER_Y-30;addy,20;addx,30;);
		OnCommand=cmd(hibernate,3.2;linear,3.0;sleep,1.2;queuecommand,"h");
		hCommand=cmd(visible,false);

		Def.ActorFrame{
			InitCommand=cmd(x,-SCREEN_WIDTH/2;y,-240;);
			-- title menu bg stuff
		};

		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
			InitCommand=cmd(zoom,.9;diffusealpha,0;);
			OnCommand=cmd(sleep,1;linear,1;diffusealpha,1;zoom,1;sleep,1.5;accelerate,0.2;diffusealpha,0;zoom,2.3;);
		};
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
			InitCommand=cmd(blend,Blend.Add;zoom,1;diffusealpha,0;);
			OnCommand=cmd(sleep,1.5;accelerate,.3;diffusealpha,.4;linear,1.2;zoom,1.4;diffusealpha,0;);
		};
		LoadActor(THEME:GetPathB("ScreenTitleMenu","background/light"))..{
			InitCommand=cmd(y,10;zoom,1;cropright,1.2;cropleft,-0.2;blend,Blend.Add);
			OnCommand=cmd(linear,1;cropright,-0.2;cropleft,-0.3;cropright,1;faderight,.1;fadeleft,.1;sleep,1.2;linear,0.7;cropleft,1;cropright,-0.3;sleep,0.5;);
		};
	};

	LoadActor("songs");
	LoadActor("charts");
	LoadActor("courses");
	LoadActor("mods");

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffusealpha,0;);
		OnCommand=cmd(hibernate,34.5;linear,0.5;diffusealpha,1;linear,0.5;diffusealpha,0);
	};
};