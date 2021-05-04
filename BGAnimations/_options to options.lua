return Def.ActorFrame{
	LoadActor(THEME:GetPathS("_options","to options"))..{
		OnCommand=function(self) self:play() end;
	};
};