return Def.ActorFrame{
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
		InitCommand=function(self) self:zoom(0.8):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.2):linear(0.4):diffusealpha(1):zoom(1):sleep(1.5) end;
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/glow"))..{
		InitCommand=function(self) self:blend(Blend.Add):zoom(1):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(0.4):accelerate(0.3):diffusealpha(0.4):linear(1.8):zoom(1.4):diffusealpha(0) end;
	};
	LoadActor(THEME:GetPathB("ScreenTitleMenu","background/light"))..{
		InitCommand=function(self) self:y(10):blend(Blend.Add):zoom(1):cropright(1.2):cropleft(-0.2) end;
		OnCommand=function(self) self:linear(1):cropright(-0.2):cropleft(-0.3):cropright(1):faderight(0.1):fadeleft(0.1):sleep(0.4):linear(0.7):cropleft(1):cropright(-0.3):sleep(0.5) end;
	};
	LoadFont("_v 26px bold shadow")..{
		Text="www.inthegroove3.com";
		InitCommand=function(self) self:x(0):y(115):shadowlength(2):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(1):linear(0.5):diffusealpha(1) end;
	};
};