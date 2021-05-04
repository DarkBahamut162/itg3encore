return Def.ActorFrame{
	LoadActor("PROCFB")..{
		InitCommand=function(self) self:Center():zoomto(SCREEN_WIDTH,SCREEN_WIDTH/4*3) end;
	};
};