return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:Center():FullScreen():diffuse(color("#000000")):cropleft(1):fadeleft(0.5) end;
		OnCommand=function(self) self:linear(0.5):cropleft(-0.5):sleep(0.5) end;
	};
	LoadActor("cancel") .. {
		StartTransitioningCommand=function(self) self:play() end;
	};
};