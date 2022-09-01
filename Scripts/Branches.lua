function ScreenCleaning()
	if Hour() > 2 and Hour() < 7 and GetScreenCleaning() == true then return "ScreenNoise" end
	return "ScreenCompany"
end

Branch.TitleScreen = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
		return "ScreenTitleMenu"
	end
	return "ScreenTitleJoin"
end

Branch.StartGame = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
		if isRave() then
			return "ScreenSelectNumPlayers"
		end
		return "ScreenSelectStyle"
	else
		if PREFSMAN:GetPreference("ShowCaution") then return "ScreenWarning" end
		return "ScreenSelectGameMode"
	end
	return "ScreenSelectGameMode"
end

Branch.AfterSelectStyleCheck = function()
	if GAMESTATE:IsAnyHumanPlayerUsingMemoryCard() then return Branch.AfterSelectStyle() end
	return "ScreenProfileLoad"
end

Branch.AfterSelectStyle = function()
	if GAMESTATE:IsCourseMode() then return "ScreenSelectCourse" end
	if IsNetSMOnline() then return SMOnlineScreen() end
	if IsNetConnected() then return "ScreenNetSelectMusic" end
	return "ScreenSelectMusic"
end

Branch.PostProfileSave = function()
	if GAMESTATE:IsEventMode() then return SelectMusicOrCourse() end
	if STATSMAN:GetCurStageStats():AllFailed() or GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() == 0 then return "ScreenNameEntryTraditional" end
	return SelectMusicOrCourse()
end

Branch.PlayerOptions = function()
	local pm = GAMESTATE:GetPlayMode()
	local restricted = { PlayMode_Oni= true }
	local optionsScreen = "ScreenPlayerOptions"
	if restricted[pm] then
		optionsScreen = "ScreenPlayerOptionsRestricted"
	end
	if SCREENMAN:GetTopScreen():GetGoToOptions() then
		return optionsScreen
	else
		return "ScreenStageInformation"
	end
end

Branch.SongOptions = function()
	if SCREENMAN:GetTopScreen():GetGoToOptions() then
		return "ScreenSongOptions"
	else
		return "ScreenStageInformation"
	end
end

Branch.AfterGameplay = function()
	if GAMESTATE:IsCourseMode() then
		if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
			return "ScreenEvaluationNonstop"
		else
			return "ScreenEvaluationOni"
		end
	elseif isRave() then
		return "ScreenEvaluationRave"
	else
		return "ScreenEvaluationNormal"
	end
end

Branch.AfterEvaluation = function()
	if GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() >= 1 then
		return "ScreenProfileSave"
	elseif GAMESTATE:GetCurrentStage() == "Stage_Extra1" then
		if STATSMAN:GetCurStageStats():AllFailed() then
			if GAMESTATE:IsCourseMode() then
				return "ScreenProfileSaveSummary"
			else
				return "ScreenEvaluationSummary"
			end
		else
			return "ScreenProfileSave"
		end
	elseif STATSMAN:GetCurStageStats():AllFailed() then
		return "ScreenEvaluationSummary"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenProfileSaveSummary"
	else
		return "ScreenEvaluationSummary"
	end
end

Branch.AfterSaveSummary = function()
	if STATSMAN:GetBestGrade() <= 0 then return "ScreenEndingPerfect"
	elseif STATSMAN:GetBestGrade() <= 3 then return "ScreenEndingGood"
	elseif STATSMAN:GetBestGrade() <= 6 then return "ScreenEndingOkay"
	else return "ScreenEndingNormal" end
end