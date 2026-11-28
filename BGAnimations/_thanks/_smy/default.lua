return Def.ActorFrame{
	Def.Sprite {
		Texture = "logo",
		InitCommand=function(self) self:y(5):zoomto(92+8,22+4):halign(0) end
	}
}