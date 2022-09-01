return Def.ActorFrame{
	LoadActor("roxor logo")..{
		InitCommand=function(self) self:Center():zoom(4/3) end
	}
}