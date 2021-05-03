local t = Def.ActorFrame{
	-- full combo

	Def.Quad{
		InitCommand=cmd(Center;FullScreen;diffuse,color("#00000000"));
		OnCommand=cmd(linear,0.3;diffusealpha,1;sleep,1;);
	};

	LoadActor("_round")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-75;zoom,.6;diffusealpha,0;addy,-30;);
		OnCommand=cmd(sleep,0.3;linear,.3;diffusealpha,1;addy,30);
	};

	LoadActor("_cleared bottom")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+15;zoom,.9;diffusealpha,0;addx,100;);
		OnCommand=cmd(sleep,0.6;decelerate,0.3;diffusealpha,1;addx,-100;sleep,0.5);
	};
	LoadActor("_cleared top")..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+10;zoom,.9;blend,Blend.Add;diffusealpha,0;addx,-100;);
		OnCommand=cmd(sleep,0.6;decelerate,0.3;diffusealpha,1;addx,100;sleep,0.5);
	};
};

return t;