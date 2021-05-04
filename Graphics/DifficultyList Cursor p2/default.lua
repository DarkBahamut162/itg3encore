local t = Def.ActorFrame{
	LoadActor(THEME:GetPathG("","_bar"))..{
		InitCommand=cmd(x,22;diffusealpha,0;sleep,0.1;linear,0.3;diffusealpha,1;);
		OnCommand=cmd(diffuseshift;effectcolor1,color("#0000CC");effectcolor2,color("#ffffff");effectoffset,0;effectclock,'beat');
		--OnCommand=cmd(diffusealpha,0;sleep,0.1;linear,0.3;diffusealpha,1;diffuseshift;effectcolor1,"#0000CC";effectcolor2,"#ffffff";effectoffset,0;effectclock,"bgm");
		OffCommand=function(self) self:stoptweening():decelerate(0.3):diffusealpha(0) end;
	};
	LoadActor("p2a")..{
		InitCommand=cmd(x,158;diffusealpha,0;);
		OnCommand=cmd(linear,.4;diffusealpha,1;bounce;effectmagnitude,3,0,0;effectperiod,1.0;effectoffset,0.2;effectclock,"beat";);
	};
};

return t;