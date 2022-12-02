return Def.ActorFrame {
	Name="YOU_WISH_YOU_WERE_PLAYING_BEATMANIA_RIGHT_NOW",
	UpdateDiscordInfoCommand=function()
		local player = GAMESTATE:GetMasterPlayerNumber()
		if GAMESTATE:GetCurrentSong() then
			local title = PREFSMAN:GetPreference("ShowNativeLanguage") and GAMESTATE:GetCurrentSong():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetTranslitFullTitle()
			local songname = title .. " - " .. GAMESTATE:GetCurrentSong():GetGroupName()
			local state = GAMESTATE:IsDemonstration() and "Watching Song" or "Playing Song"
			GAMESTATE:UpdateDiscordProfile(GAMESTATE:GetPlayerDisplayName(player))
			local stats = STATSMAN:GetCurStageStats()
			if not stats then return end
			local courselength = function()
				if GAMESTATE:IsCourseMode() then
					if GAMESTATE:GetPlayMode() ~= "PlayMode_Endless" then
						return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().. " (Song ".. stats:GetPlayerStageStats( player ):GetSongsPassed()+1 .. " of ".. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() ..")" or ""
					end
					return GAMESTATE:GetCurrentCourse():GetDisplayFullTitle().. " (Song ".. stats:GetPlayerStageStats( player ):GetSongsPassed()+1 .. ")" or ""
				end
			end
			GAMESTATE:UpdateDiscordSongPlaying(GAMESTATE:IsCourseMode() and courselength() or state,songname,(GAMESTATE:GetCurrentSong():GetLastSecond() - GAMESTATE:GetCurMusicSeconds())/GAMESTATE:GetSongOptionsObject('ModsLevel_Song'):MusicRate())
		end
	end,
	OnCommand=function(self)
		if Var "LoadingScreen" ~= "ScreenDemonstration2" then
			self:playcommand("UpdateDiscordInfo")
			for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
				if (PREFSMAN:GetPreference("Center1Player") and GAMESTATE:GetNumPlayersEnabled() == 1) and
				ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerOneSide" then
					if pn == PLAYER_2 then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):addx(SCREEN_WIDTH/4)
					else
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):addx(-SCREEN_WIDTH/4)
					end
				end
				if SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)) and SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):GetChild("NoteField") then
					if getenv("RotationLeft"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):GetChild("NoteField"):rotationz(270)
						if GAMESTATE:IsPlayerEnabled(PLAYER_2) and not GAMESTATE:IsPlayerEnabled(PLAYER_1) then
							SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):GetChild("NoteField"):addx(-SCREEN_WIDTH/2)
						end
					elseif getenv("RotationRight"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):GetChild("NoteField"):rotationz(90)
						if GAMESTATE:IsPlayerEnabled(PLAYER_1) and not GAMESTATE:IsPlayerEnabled(PLAYER_2) then
							SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):GetChild("NoteField"):addx(SCREEN_WIDTH/2)
						end
					elseif getenv("RotationUpsideDown"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):GetChild("NoteField"):rotationz(180):addy(20)
					elseif getenv("RotationSolo"..ToEnumShortString(pn)) == true then
						if ToEnumShortString(GAMESTATE:GetCurrentStyle():GetStyleType()) == "OnePlayerOneSide" then
							if pn == PLAYER_2 then
								SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):addx(-SCREEN_WIDTH/4)
							else
								SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):addx(SCREEN_WIDTH/4)
							end
						end
					end

					local mlevel = GAMESTATE:IsCourseMode() and "ModsLevel_Stage" or "ModsLevel_Preferred"
					local currentMini = 1-math.round(GAMESTATE:GetPlayerState(pn):GetPlayerOptions(mlevel):Mini()*50) / 100

					if getenv("EffectVibrate"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):vibrate():effectmagnitude(20*currentMini,20*currentMini,20*currentMini)
					elseif getenv("EffectSpin"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):spin():effectclock('beat'):effectmagnitude(0,0,45*currentMini)
					elseif getenv("EffectSpinReverse"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):spin():effectclock('beat'):effectmagnitude(0,0,-45*currentMini)
					elseif getenv("EffectBounce"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):bob():effectclock('beat'):effectmagnitude(30*currentMini,30*currentMini,30*currentMini)
					elseif getenv("EffectPulse"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):pulse():effectclock('beat')
					elseif getenv("EffectWag"..ToEnumShortString(pn)) == true then
						SCREENMAN:GetTopScreen():GetChild("Player"..ToEnumShortString(pn)):wag():effectclock('beat')
					end
				end
			end
		end
	end,
	DoneLoadingNextSongMessageCommand=function(self) self:playcommand("On") end
}