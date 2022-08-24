return Def.ActorFrame{
	LoadActor("CJ112")..{
		InitCommand=function(self) self:Center():FullScreen() end;
	};
	Def.Actor{ InitCommand=function(self) self:clearzbuffer(true) end; };
}