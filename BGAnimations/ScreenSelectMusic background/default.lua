return Def.ActorFrame{
	Def.Sprite {
		Texture = isFinal() and "CJ126 Final" or "CJ126 Normal",
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end
	}
}