local t = Def.ActorFrame{
	InitCommand=function(self) self:fov(70) end;
	LoadActor(THEME:GetPathB("","_thanks/_outfox/logo"))..{
		InitCommand=function(self) self:x(-180) end;
		OnCommand=function(self) self:pulse():effectclock("beat"):effectperiod(0.83):effectmagnitude(1,1.25,0):zoom(0.6) end;
	};
	LoadActor(THEME:GetPathB("","_thanks/_outfox/text"))..{
		OnCommand=function(self) self:x(120):zoom(0.6) end;
	};
	LoadActor(THEME:GetPathB("","_thanks/_outfox/text"))..{
		Name="TextGlow";
		InitCommand=function(self) self:blend(Blend.Add):diffusealpha(0.05) end;
		OnCommand=function(self) self:x(120):glowshift():effectperiod(2.5):effectcolor1(color("1,1,1,0.25")):effectcolor2(color("1,1,1,1")):zoom(0.6) end;
	};
	LoadFont("_v profile")..{
		Text="Powered by";
		InitCommand=function(self) self:x(-101):y(-69):halign(0):shadowlength(2) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
	LoadFont("_v 26px bold shadow")..{
		Text="https://projectoutfox.com/";
		InitCommand=function(self) self:x(23):y(69):shadowlength(2):zoom(0.75) end;
		OnCommand=function(self) self:diffusealpha(0):sleep(1):linear(0.5):diffusealpha(1) end;
	};
};

return t;