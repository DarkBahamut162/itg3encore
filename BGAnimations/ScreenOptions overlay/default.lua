return Def.ActorFrame{
	Def.Sprite {
		Texture = "_frame",
		InitCommand=function(self) self:Center():zoom(WideScreenDiff()) end,
		OnCommand=function(self) self:diffusealpha(0):decelerate(0.6):diffusealpha(1) end,
		OffCommand=function(self) self:diffusealpha(1):accelerate(0.6):diffusealpha(0) end
	}
}