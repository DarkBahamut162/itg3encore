local t = Def.ActorFrame{
	LoadActor("light")..{
		InitCommand=cmd(blend,Blend.Add;addx,-146;diffusealpha,0;);
		OnCommand=cmd(sleep,2.5;accelerate,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#FFFFFF00");effectclock,'beat';effectperiod,4;);
	};
	LoadActor("base")..{ InitCommand=cmd(addx,-5); };
	LoadActor("light")..{
		InitCommand=cmd(blend,Blend.Add;addx,-164;diffusealpha,0;);
		OnCommand=cmd(sleep,2.5;accelerate,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("#FFFFFF");effectcolor2,color("#FFFFFF00");effectclock,'beat';effectperiod,4;);
	};
	LoadActor("streak")..{
		InitCommand=cmd(addx,-155;addx,-100;);
		OnCommand=cmd(sleep,0.8;decelerate,0.6;addx,100);
	};
	LoadActor("streak")..{
		InitCommand=cmd(addx,-174;addx,-100;);
		OnCommand=cmd(sleep,1;decelerate,0.6;addx,100);
	};
	LoadActor("glow2")..{
		InitCommand=cmd(blend,Blend.Add;addx,-5;diffusealpha,0;);
		OnCommand=cmd(sleep,1.8;decelerate,0.3;diffusealpha,1;sleep,.2;accelerate,0.6;diffusealpha,0;queuecommand,"Destroy");
		DestroyCommand=cmd(visible,false);
	};
};

return t;