return Def.ActorFrame{
	Def.BitmapText {
		File = "_z bold 19px",
		InitCommand=function(self) self:shadowlength(1) end,
		BeginCommand=function(self) self:playcommand("Set") end,
		CurrentSongChangedMessageCommand=function(self) self:finishtweening():playcommand("Set") end,
		SetCommand=function(self)
			local Stage = GAMESTATE:GetCurrentStage()
			local songsPerPlay = PREFSMAN:GetPreference("SongsPerPlay")
			if Stage:gsub("%D+", "") ~= "" and Stage:gsub("%D+", "") == songsPerPlay then
				Stage = 'Stage_Final'
			end
			if GAMESTATE:IsEventMode() then Stage = 'Stage_Event' end
			if IsNetSMOnline() then Stage = 'Stage_Online' end
			Stage = ToEnumShortString(Stage)
			self:settext(THEME:GetString("Stages",Stage))
		end
	}
}