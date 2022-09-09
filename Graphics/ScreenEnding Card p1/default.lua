return Def.ActorFrame{
	LoadActor("card")..{
		InitCommand=function(self) self:glowshift():zoom(0.7) end,
		CardRemovedP1MessageCommand=function(self) self:diffusealpha(0) end
	}
}