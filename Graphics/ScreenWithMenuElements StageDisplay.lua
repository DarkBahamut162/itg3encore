local screen = Var "LoadingScreen"

return Def.ActorFrame{
	Def.BitmapText {
		File = "_z bold 19px",
		InitCommand=function(self) self:shadowlength(1) end,
		BeginCommand=function(self) self:playcommand("Set") end,
		CurrentSongChangedMessageCommand=function(self) self:finishtweening():playcommand("Set") end,
		SetCommand=function(self)
			local curStage = screen:find("Evaluation") and STATSMAN:GetCurStageStats():GetStage() or GAMESTATE:GetCurrentStage()
			local songsPerPlay = PREFSMAN:GetPreference("SongsPerPlay")
			if curStage:gsub("%D+", "") == songsPerPlay then curStage = 'Stage_Final' end
			if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' end
			if IsNetSMOnline() then curStage = 'Stage_Online' end
			self:settext(THEME:GetString("Stages",ToEnumShortString(curStage))):maxwidth(240)
		end
	}
}