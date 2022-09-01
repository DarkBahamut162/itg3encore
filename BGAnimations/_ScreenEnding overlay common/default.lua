return Def.ActorFrame{
	LoadActor("playagainsoon")..{
		InitCommand=function(self) self:Center():y(30) end
	}
}