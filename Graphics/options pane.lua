return Def.ActorFrame{
	Def.Sprite {
		Texture = "options pane "..(isFinal() and "final" or "normal"),
		InitCommand=function(self) self:zoom(WideScreenDiff()) end
	}
}