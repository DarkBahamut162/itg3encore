return Def.ActorFrame{
	LoadFont("_eurostile normal")..{
		Text="Normal",
		InitCommand=function(self) self:x(4*WideScreenDiff()):zoom(0.5*WideScreenDiff()):shadowlength(2):diffuse(ContrastingDifficultyColor("Medium")):diffusealpha(0) end,
		OnCommand=function(self) self:sleep(0.1):linear(0.3):diffusealpha(1) end,
		OffCommand=function(self) self:linear(0.3):diffusealpha(0) end
	}
}