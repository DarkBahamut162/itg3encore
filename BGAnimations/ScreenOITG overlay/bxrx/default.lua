return Def.ActorFrame{
	LoadActor("wipe")..{
		InitCommand=function(self) self:cropright(1):faderight(1):y(27) end,
		OnCommand=function(self) self:sleep(2.7):linear(0.5):cropright(0):faderight(0) end
	},
	LoadActor("boxorroxors")..{
		OnCommand=function(self) self:diffusealpha(0):sleep(2.6):linear(0.4):diffusealpha(1) end
	},
	LoadActor("_b")..{
		InitCommand=function(self) self:x(-35):zoom(1.6):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.8):linear(0.8):diffusealpha(1):sleep(0.4):decelerate(0.7):zoom(1):addx(-193):sleep(1):linear(0.7):diffusealpha(0) end
	},
	LoadActor("_r")..{
		InitCommand=function(self) self:x(35):zoom(1.6):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.8):linear(0.8):diffusealpha(1):sleep(0.4):decelerate(0.7):zoom(1):addx(-31):sleep(1):linear(0.7):diffusealpha(0) end
	},
	LoadFont("_v 26px bold shadow")..{
		Text="www.boxorroxors.net",
		InitCommand=function(self) self:y(52):shadowlength(2):zoom(0.9):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(3):linear(0.5):diffusealpha(1) end
	}
}