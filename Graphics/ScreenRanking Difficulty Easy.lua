return Def.ActorFrame{
	LoadFont("_eurostile normal")..{
		Text="Easy",
		InitCommand=function(self) self:x(4):zoom(0.5):shadowlength(2):diffuse(ContrastingDifficultyColor("Easy")):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.3):diffusealpha(0) end
	}
}