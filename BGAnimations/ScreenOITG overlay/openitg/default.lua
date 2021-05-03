return Def.ActorFrame{
	LoadActor("_otherred")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120;y,SCREEN_CENTER_Y+30;horizalign,left;zoomy,.3;zoomtowidth,430;faderight,1);
		OnCommand=cmd(addx,-430;cropleft,1;sleep,.6;decelerate,.3;cropleft,0;addx,430;);
	};
	LoadActor("_otherred")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-120;y,SCREEN_CENTER_Y+30;horizalign,left;zoomy,.3;zoomtowidth,430;faderight,1);
		OnCommand=cmd(addx,-430;cropleft,1;sleep,.6;decelerate,.3;cropleft,0;addx,430;);
	};
	LoadActor("arrow")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-190;y,SCREEN_CENTER_Y-25;zoom,.8;glow,color("1,1,1,1");addx,SCREEN_WIDTH/2;addy,SCREEN_HEIGHT/1.2;);
		OnCommand=cmd(sleep,.2;decelerate,.5;addx,-SCREEN_WIDTH/2;addy,-SCREEN_HEIGHT/1.2;glow,color("1,1,1,0");wag;effectmagnitude,4,0,4;effectperiod,8);
	};

	Def.ActorFrame{
		Name="OpenITGText";
		InitCommand=cmd(x,SCREEN_CENTER_X+90;y,SCREEN_CENTER_Y+30;zoom,.8;draworder,1);
		LoadActor("_openitg normal")..{
			InitCommand=cmd(cropright,1;faderight,1;);
			OnCommand=cmd(sleep,.7;linear,.3;cropright,0;faderight,.1;linear,.03;faderight,0);
		};
		LoadActor("_openitg glow")..{
			InitCommand=cmd(diffusealpha,.8;cropright,1;faderight,1;);
			OnCommand=cmd(sleep,.7;linear,.3;cropright,0;faderight,.1;linear,.03;faderight,0;linear,.5;diffusealpha,0);
		};
	};

	LoadFont("_v profile")..{
		Text="Powered by";
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-28;shadowlength,2;);
		OnCommand=cmd(diffusealpha,0;sleep,1;linear,0.5;diffusealpha,1);
	};
	LoadFont("_v 26px bold shadow")..{
		Text="http://github.com/openitg/";
		InitCommand=cmd(x,SCREEN_CENTER_X+90;y,SCREEN_CENTER_Y+88;shadowlength,2;);
		OnCommand=cmd(diffusealpha,0;sleep,1;linear,0.5;diffusealpha,1);
	};
};