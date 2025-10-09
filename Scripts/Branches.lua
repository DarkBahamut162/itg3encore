function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"..(isFinal() and "Final" or "")
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"..(isFinal() and "Final" or "")
	else
		return "ScreenSelectMusic"..(isFinal() and "Final" or "")
	end
end

function IsAprilFools()
	return MonthOfYear() + 1 == 4 and DayOfMonth() == 1
end

Branch.TitleScreen = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then return IsAprilFools() and "ScreenTitleMenuAlt" or "ScreenTitleMenu" end
	return IsAprilFools() and "ScreenTitleAlt" or "ScreenTitleJoin"
end

Branch.StartGame = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
		if isVS() then return "ScreenSelectNumPlayers" end
	else
		if PREFSMAN:GetPreference("ShowCaution") then return "ScreenWarning" end
		return "ScreenSelectPlayMode"
	end
	return "ScreenSelectStyle"
end

Branch.BeforeSelectStyle = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Free' then
		return "ScreenSelectPlayMode"
	else
		return Branch.TitleScreen()
	end
end

Branch.AfterSelectStyle = function()
	if getenv("Workout") then return "ScreenWorkoutMenu" end
	if GAMESTATE:IsCourseMode() then return "ScreenSelectCourse"..(isFinal() and "Final" or "") end
	if IsNetSMOnline() then return SMOnlineScreen() end
	if IsNetConnected() then return "ScreenNetSelectMusic" end
	return "ScreenSelectMusic"..(isFinal() and "Final" or "")
end

Branch.AfterWorkoutMenu = function()
	if GAMESTATE:IsCourseMode() then return "ScreenSelectCourse"..(isFinal() and "Final" or "") end
	return "ScreenSelectMusic"..(isFinal() and "Final" or "")
end

Branch.PostProfileSave = function()
	if GAMESTATE:IsEventMode() then return SelectMusicOrCourse() else
		if not isEtterna() and not GAMESTATE:IsCourseMode() and ThemePrefs.Get("TrueRounds") then
			local songsPerPlay = PREFSMAN:GetPreference("SongsPerPlay")
			local stagesPlayed = STATSMAN:GetStagesPlayed()
			local totalStageNum = math.huge
			local totalStage = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
			local LongCutoff = PREFSMAN:GetPreference("LongVerSongSeconds")
			local MarathonCutoff = PREFSMAN:GetPreference("MarathonVerSongSeconds")
			for player in ivalues(GAMESTATE:GetHumanPlayers()) do
				for stage = 1, stagesPlayed do
					local playedSS = STATSMAN:GetPlayedStageStats(stage)
					local playerSS = playedSS:GetPlayerStageStats(player)
					local song = playedSS:GetPlayedSongs()[1]
					local steps = playerSS:GetPlayedSteps()[1]
					local trueSeconds = 0

					if ThemePrefs.Get("UseStepCache") then
						trueSeconds = tonumber(LoadFromCache(song,steps,"TrueSeconds")) or 0
					else
						trueSeconds = song:GetFirstSecond() > song:GetLastSecond() and 0 or song:GetLastSecond()-song:GetFirstSecond()
					end

					local IsMarathon = trueSeconds > MarathonCutoff
					local IsLong     = trueSeconds > LongCutoff
					local ActualSongCost = (IsMarathon and 3) or (IsLong and 2) or 1
					totalStage[player] = totalStage[player] + ActualSongCost
				end
				totalStageNum = math.min(totalStageNum,totalStage[player])
			end
			local TrueLeft = songsPerPlay-totalStageNum

			if GAMESTATE:GetNumStagesLeft(GAMESTATE:GetMasterPlayerNumber()) < TrueLeft then
				for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
					for i=1, math.abs(TrueLeft - GAMESTATE:GetNumStagesLeft(GAMESTATE:GetMasterPlayerNumber())) do
						GAMESTATE:AddStageToPlayer(pn)
					end
				end
			end
		end
	end
	if STATSMAN:GetCurStageStats():AllFailed() or GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() == 0 then return "ScreenNameEntryTraditional" end
	return SelectMusicOrCourse()
end

Branch.PlayerOptions = function()
	local restricted = { PlayMode_Oni = true }
	local optionsScreen = "ScreenPlayerOptions"
	if not isEtterna() and restricted[GAMESTATE:GetPlayMode()] then
		optionsScreen = "ScreenPlayerOptionsRestricted"
	end
	if SCREENMAN:GetTopScreen():GetGoToOptions() then
		return optionsScreen
	else
		return Branch.BeforeGameplay()
	end
end

Branch.SongOptions = function()
	if SCREENMAN:GetTopScreen():GetGoToOptions() then
		return "ScreenSongOptions"
	else
		return Branch.BeforeGameplay()
	end
end

Branch.BeforeGameplay = function()
	if isOutFox(20210815) then
		return "ScreenLoadGameplayElements"
	else
		return "ScreenStageInformation"
	end
end

Branch.AfterGameplay = function()
	if GAMESTATE:IsCourseMode() then
		if isNonstop() then
			return "ScreenEvaluationNonstop"
		else
			return "ScreenEvaluationOni"
		end
	elseif isVS() then
		return "ScreenEvaluationRave"
	else
		if IsNetSMOnline() then
			return "ScreenNetEvaluation"
		else
			return "ScreenEvaluationNormal"
		end
	end
end

Branch.AfterSaveSummary = function()
	if STATSMAN:GetBestGrade() <= 0 then return "ScreenEndingPerfect"
	elseif STATSMAN:GetBestGrade() <= 3 then return "ScreenEndingGood"
	elseif STATSMAN:GetBestGrade() <= 6 then return "ScreenEndingOkay"
	else return "ScreenEndingNormal" end
end

Branch.AfterStageInformation = function()
	if getenv("Workout") then return "ScreenGameplayWorkout" end
	return "ScreenGameplay"
end

Branch.AfterGameplayWorkout = function()
	if isNonstop() then return "ScreenEvaluationCourseWorkout" end
	if isPlayMode("PlayMode_Endless") then return "ScreenEvaluationCourseWorkout" end
	return "ScreenEvaluationWorkout"
end

Branch.AfterEvaluation = function()
	return "ScreenProfileSave"
end

Branch.AfterEvaluationWorkout = function()
	if isPlayMode("PlayMode_Endless") then return "ScreenWorkoutMenu" end
	return "ScreenSelectCourse"
end

Branch.ScreenSelectMusicPrevScreen = function()
	if getenv("Workout") then return "ScreenWorkoutMenu" end
	if ThemePrefs.Get("ShowSummary") and GAMESTATE:IsEventMode() and GAMESTATE:GetCurrentStageIndex() > 0 then return "ScreenSummary" end
	return Branch.TitleScreen()
end
