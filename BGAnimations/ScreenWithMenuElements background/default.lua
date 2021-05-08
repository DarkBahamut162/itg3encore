return Def.ActorFrame{
	LoadActor("CJ112")..{
		InitCommand=function(self) self:Center():FullScreen() end;
	};
	-- clear the zbuffer so that screens can draw without having to clear it
	Def.Actor{ InitCommand=function(self) self:clearzbuffer(true) end; };
}