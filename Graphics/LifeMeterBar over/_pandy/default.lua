local t = Def.ActorFrame{
	LoadActor("light")..{
		InitCommand=function(self) self:blend(Blend.Add):addx(-146):diffusealpha(0) end;
		OnCommand=cmd(sleep,2.5;accelerate,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("#00EAFF");effectcolor2,color("#FFFFFF00");effectclock,'beat';effectperiod,4;);
	};
	LoadActor("base")..{ InitCommand=function(self) self:addx(-5) end; };
	LoadActor("light")..{
		InitCommand=function(self) self:blend(Blend.Add):addx(-164):diffusealpha(0) end;
		OnCommand=cmd(sleep,2.5;accelerate,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("#00EAFF");effectcolor2,color("#FFFFFF00");effectclock,'beat';effectperiod,4;);
	};
	LoadActor("streak")..{
		InitCommand=function(self) self:addx(-155):addx(-100) end;
		OnCommand=function(self) self:sleep(0.8):decelerate(0.6):addx(100) end;
	};
	LoadActor("streak")..{
		InitCommand=function(self) self:addx(-174):addx(-100) end;
		OnCommand=function(self) self:sleep(1):decelerate(0.6):addx(100) end;
	};
	LoadActor("glow2")..{
		InitCommand=function(self) self:blend(Blend.Add):addx(-5):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(1.8):decelerate(0.3):diffusealpha(1):sleep(.2):accelerate(0.6):diffusealpha(0):queuecommand("Destroy") end;
		DestroyCommand=function(self) self:visible(false) end;
	};
};

return t;