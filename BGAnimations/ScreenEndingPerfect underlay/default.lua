return Def.ActorFrame{
	Def.Quad{
		InitCommand=function(self) self:FullScreen():diffuse(color("#000000FF")) end;
	};
    LoadActor("background");
    LoadActor("people");
    LoadActor("in the groove")..{
        OnCommand=function(self) self:sleep(20) end;
    };
};