local t = Def.ActorFrame{
	InitCommand=function(self) self:fov(70) end;
	LoadActor("_arrow")..{
		InitCommand=function(self) self:x(-230+50) end;
		OnCommand=function(self) self:wag():effectmagnitude(0,0,16):effectperiod(2.5):zoom(0.6) end;
	};
	LoadActor("_text")..{
		OnCommand=function(self) self:x(40):zoom(0.4) end;
	};
	LoadActor("_text")..{
		Name="TextGlow";
		InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0.05) end;
		OnCommand=function(self) self:x(40):glowshift():effectperiod(2.5):effectcolor1(color("1,1,1,0.25")):effectcolor2(color("1,1,1,1")):zoom(0.4) end;
	};
	LoadFont("_v profile")..{
		Text="Powered by";
		InitCommand=function(self) self:x(-140+25):y(-36-30):halign(0):shadowlength(2) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
	LoadFont("_v 26px bold shadow")..{
		Text="https://projectmoon.dance/";
		InitCommand=function(self) self:x(36):y(55+10):shadowlength(2):zoom(0.75) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
};

return t;