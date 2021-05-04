local t = Def.Quad{
		InitCommand=function(self) self:Center():FullScreen() end;
		OnCommand=function(self) self:linear(0.3):diffusealpha(0) end;
};

return t;