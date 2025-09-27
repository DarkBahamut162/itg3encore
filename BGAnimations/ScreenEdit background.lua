return Def.ActorFrame{
	OnCommand=function(self)
		if isOutFox(20200500) then
			GAMESTATE:UpdateDiscordGameMode(GAMESTATE:GetCurrentGame():GetName())
			GAMESTATE:UpdateDiscordScreenInfo("Editing a Song","",1)
		end
	end,
	Def.Quad{ InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,1")) end },
	Def.Quad{ InitCommand=function(self) self:FullScreen():diffuse(color("0,0,0,0.2")) end }
}