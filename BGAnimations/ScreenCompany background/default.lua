return Def.ActorFrame{
	LoadActor("roxor logo.avi")..{
		InitCommand=function(self) self:Center():zoom(4/3) end;
	};
};