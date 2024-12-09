return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:zoomto(SCREEN_WIDTH*2,SCREEN_HEIGHT):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:linear(0.3):diffusealpha(0.75) end,
		OffCommand=function(self) self:linear(0.3):diffusealpha(0) end,
		CancelCommand=function(self) self:linear(0.3):diffusealpha(0) end
	}
}