local t = Def.ActorFrame{
	InitCommand=cmd(fov,70);
	LoadActor("_arrow")..{
		InitCommand=cmd(x,225;);
		OnCommand=cmd(wag;effectmagnitude,0,0,16;effectperiod,2.5;);
	};
	LoadActor("_text");
	LoadActor("_text")..{
		Name="TextGlow";
		InitCommand=cmd(blend,Blend.Add;diffusealpha,0.05;);
		OnCommand=cmd(glowshift;effectperiod,2.5;effectcolor1,color("1,1,1,0.25");effectcolor2,color("1,1,1,1"););
	};
	LoadFont("_v profile")..{
		Text="Powered by";
		InitCommand=cmd(x,-140;y,-36;halign,0;shadowlength,2;);
		OnCommand=cmd(diffusealpha,0;sleep,1;linear,0.5;diffusealpha,1);
	};
	LoadFont("_v 26px bold shadow")..{
		Text="http://code.google.com/p/sm-ssc/";
		InitCommand=cmd(y,36;shadowlength,2;);
		OnCommand=cmd(diffusealpha,0;sleep,1;linear,0.5;diffusealpha,1);
	};
};

return t;
