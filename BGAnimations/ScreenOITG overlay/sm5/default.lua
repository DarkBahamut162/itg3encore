local t = Def.ActorFrame{
	InitCommand=cmd(fov,70);
	LoadActor("_arrow")..{
		InitCommand=cmd(x,-230+50;);
		OnCommand=cmd(wag;effectmagnitude,0,0,16;effectperiod,2.5;zoom,0.6);
	};
	LoadActor("_text")..{
		OnCommand=cmd(x,40;zoom,0.4);
	};
	LoadActor("_text")..{
		Name="TextGlow";
		InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0.05) end;
		OnCommand=cmd(x,40;glowshift;effectperiod,2.5;effectcolor1,color("1,1,1,0.25");effectcolor2,color("1,1,1,1");zoom,0.4);
	};
	LoadFont("_v profile")..{
		Text="Powered by";
		InitCommand=cmd(x,-140+25;y,-36-30;halign,0;shadowlength,2;);
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
	LoadFont("_v 26px bold shadow")..{
		Text="https://projectmoon.dance/";
		InitCommand=cmd(x,36;y,55+10;shadowlength,2;zoom,0.75);
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
};

return t;
