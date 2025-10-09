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
				local stageNum = curStage:gsub("%D+", "")
				local songsPerPlay = isEtterna() and 0 or PREFSMAN:GetPreference("SongsPerPlay")
				if stageNum == songsPerPlay then curStage = 'Stage_Final' end
				if curStage == "Stage_Final" then stageNum = songsPerPlay end
				if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' else
					if not isEtterna() and ThemePrefs.Get("TrueRounds") then
						local before = GetTotalStageCost()
						local current = GetCurrentTrueStageCost()
						local total = before+current
						if total == songsPerPlay then
							curStage = 'Stage_Final'
						elseif before+1 ~= stageNum then
							local add = {
								[1] = "st",
								[2] = "nd",
								[3] = "rd"
							}
							curStage = "Stage_"..(before+1)..(add[(before+1)] and add[(before+1)] or "th")
						end
					end
				end
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