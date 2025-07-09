return Def.ActorFrame{
	Def.Sprite{
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local curStage = isEtterna() and "Stage_Event" or GAMESTATE:GetCurrentStage()
			if GAMESTATE:IsCourseMode() then
				if GAMESTATE:GetCourseSongIndex()+1 <= 5 then
					self:Load(THEME:GetPathG("_gameplay","course song " .. GAMESTATE:GetCourseSongIndex()+1))
				end
			else
				local songsPerPlay = isEtterna() and 0 or PREFSMAN:GetPreference("SongsPerPlay")
				if curStage:gsub("%D+", "") == songsPerPlay then curStage = 'Stage_Final' end
				if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' end
				if IsNetSMOnline() then curStage = 'Stage_Online' end

				self:Load(THEME:GetPathG("_gameplay","stage "..ToEnumShortString(curStage)))
			end
		end
	},
	Def.BitmapText {
		File = "_z bold gray 36px",
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				if GAMESTATE:GetCourseSongIndex()+1 > 5 then
					self:settext("SONG ".. (GAMESTATE:GetCourseSongIndex()+1))
				end
			end
		end
	}
}