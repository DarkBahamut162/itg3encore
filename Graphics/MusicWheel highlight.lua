return Def.ActorFrame{
	Def.Sprite {
		Texture = "MusicWheel _highlight "..(isFinal() and "Final" or "Normal"),
		InitCommand=function(self) self:blend(Blend.Add) end
	}
}