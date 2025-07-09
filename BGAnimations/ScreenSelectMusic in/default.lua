function MemoryCheck()
	if isEtterna() then return false else return GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() end
end

return Def.ActorFrame{
	loadfile(THEME:GetPathB("_selectmusic","menu in add"))(),
	Def.Actor{
		OnCommand=function(self) self:sleep(0.8) end
	},
	Def.Sound {
		File = "open.ogg",
		OnCommand=function(self) self:play() end
	},
	loadfile(THEME:GetPathB("_statsout","musicwheel"))()..{
		Condition=MemoryCheck()
	}
}