return Def.ActorFrame{
	Def.Sprite {
		Texture = "playagainsoon",
		InitCommand=function(self) self:Center():y(30*WideScreenDiff()):zoom(WideScreenDiff()) end
	}
}