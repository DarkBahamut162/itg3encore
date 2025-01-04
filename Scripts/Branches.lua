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
	if GAMESTATE:IsEventMode() then return SelectMusicOrCourse() end
	if STATSMAN:GetCurStageStats():AllFailed() or GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() == 0 then return "ScreenNameEntryTraditional" end
	return SelectMusicOrCourse()
end

Branch.PlayerOptions = function()
	local restricted = { PlayMode_Oni = true }
	local optionsScreen = "ScreenPlayerOptions"
	if restricted[GAMESTATE:GetPlayMode()] then
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
	if isOutFox() then
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
	return Branch.TitleScreen()
end
