return Def.ActorFrame{
	Def.Sprite {
		Texture = THEME:GetPathB("ScreenWithMenuElements","background/"..(isFinal() and "OITG Final" or "CJ112 Normal")),
		InitCommand=function(self) self:FullScreen() end,
		OnCommand=function(self) self:linear(1.5):diffusealpha(1) end
	}
}