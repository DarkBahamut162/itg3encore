local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:diffuse(color("#000000")):Center():FullScreen() end;
		StartCommand=function(self) self:FullScreen():diffusealpha(0):sleep(0.3):linear(0.3):diffusealpha(1) end;
		FinishCommand=function(self) self:sleep(0.3):linear(0.3):diffusealpha(0) end;
	};
};

return t;