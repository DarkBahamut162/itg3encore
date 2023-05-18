return Def.ActorFrame{
	LoadActor("playagainsoon")..{
		InitCommand=function(self) self:Center():y(30*WideScreenDiff()):zoom(WideScreenDiff()) end
	}
}