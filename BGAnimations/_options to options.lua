return Def.ActorFrame{
	Def.Sound {
		File = THEME:GetPathS("_options","to options"),
		OnCommand=function(self) self:play() end
	}
}