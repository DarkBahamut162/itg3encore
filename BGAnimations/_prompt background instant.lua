return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH*2,SCREEN_HEIGHT*2):diffuse(color("0,0,0,0")) end,
		OnCommand=function(self) self:diffusealpha(0.75) end,
		OffCommand=function(self) self:diffusealpha(0) end,
		CancelCommand=function(self) self:diffusealpha(0) end
	}
}