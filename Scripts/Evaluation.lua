function EvalTweenDistance()
	return SCREEN_WIDTH/2
end

function isRegular()
	return isPlayMode("PlayMode_Regular")
end

function isNonstop()
	return isPlayMode("PlayMode_Nonstop")
end

function isOni()
	return isPlayMode("PlayMode_Oni")
end

function isVS()
	return isPlayMode("PlayMode_Rave") or isPlayMode("PlayMode_Battle")
end

function isLifeline(player)
	return isOni() and GAMESTATE:GetCurrentCourse(player):GetCourseEntry(0):GetGainSeconds() == 0
end

function isSurvival(player)
	return GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):LifeSetting() == "LifeType_Time"
end

function isMGD(player)
	return GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):LifeSetting() == "LifeType_Battery"
end

function TotalPossibleStepSecondsCurrent(player)
	local fSecs = 0
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
	if GAMESTATE:IsCourseMode() then
		if StepsOrTrail then
			local entries = StepsOrTrail:GetTrailEntries()
			for i=1, #entries do
				local song = entries[i]:GetSong()
				local step = entries[i]:GetSteps()
				local trueSeconds = tonumber(LoadFromCache(Song,StepsOrTrail,"TrueSeconds"))
				fSecs = fSecs + trueSeconds
			end
		end
	else
		local Song = GAMESTATE:GetCurrentSong()
		fSecs = tonumber(LoadFromCache(Song,StepsOrTrail,"TrueSeconds"))
	end

    local songoptions = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
    if not songoptions then return fSecs end

    return fSecs / songoptions:MusicRate()
end

function TotalPossibleStepSeconds(player)
	local fSecs = 0
	local s = STATSMAN:GetCurStageStats()
	local played = isITGmania() and #s:GetPlayedSongs() or #s:GetPossibleSongs()
	for a = 1, played do
		if player then
			local Song = s:GetPossibleSongs()[a]
			local Steps = s:GetPlayerStageStats(player):GetPossibleSteps()[a]
			local trueSeconds = tonumber(LoadFromCache(Song,Steps,"TrueSeconds"))
			fSecs = fSecs + trueSeconds
		else
			fSecs = fSecs + s:GetPossibleSongs()[a]:GetStepsSeconds()
		end
	end

	local songoptions = GAMESTATE:GetSongOptionsObject("ModsLevel_Song")
	if not songoptions then return fSecs end

    return fSecs / songoptions:MusicRate()
end

function prepSummary()
	local currentStage = GAMESTATE:GetCurrentStageIndex()+SummaryAdjust
	local offsetInfo = getenv("OffsetTable")
	local scores = isOpenDDR() and {
		"TapNoteScore_W1",
		"TapNoteScore_W2",
		"TapNoteScore_W3",
		"TapNoteScore_W4",
		"TapNoteScore_Miss"
	} or {
		"TapNoteScore_W1",
		"TapNoteScore_W2",
		"TapNoteScore_W3",
		"TapNoteScore_W4",
		"TapNoteScore_W5",
		"TapNoteScore_Miss"
	}

	function playerData(player)
		local Step = {}
		local early = {
			["TapNoteScore_W0"] = 0,
			["TapNoteScore_W1"] = 0,
			["TapNoteScore_W2"] = 0,
			["TapNoteScore_W3"] = 0,
			["TapNoteScore_W4"] = 0,
			["TapNoteScore_W5"] = 0
		}
		local late = {
			["TapNoteScore_W0"] = 0,
			["TapNoteScore_W1"] = 0,
			["TapNoteScore_W2"] = 0,
			["TapNoteScore_W3"] = 0,
			["TapNoteScore_W4"] = 0,
			["TapNoteScore_W5"] = 0
		}
		
		if offsetInfo and ThemePrefs.Get("ShowOffset") then
			for t in ivalues(offsetInfo[player]) do
				if t[2] and type(t[2]) == "number" then
					if t[2] < 0 then
						early[t[3]] = early[t[3]] + 1
					elseif t[2] > 0 then
						late[t[3]] = late[t[3]] + 1
					end
				end
			end
		end
		for score in ivalues(scores) do Step[score] = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores(score) end
		Step["FA"] = getenv("SetScoreFA"..pname(player)) or false
		if Step["FA"] then
			local W0 = getenv("W0"..pname(player))
			Step["TapNoteScore_W0"] = W0
			Step["TapNoteScore_W1"] = Step["TapNoteScore_W1"] - W0
		end
		for score,amount in pairs(early) do Step[score.."_Early"] = amount end
		for score,amount in pairs(late) do Step[score.."_Late"] = amount end
		if isVS() then
			Step["AutoPlayer"] = GAMESTATE:IsHumanPlayer(player) and not getenv("EvalCombo"..pname(player)) or false
		else
			Step["AutoPlayer"] = not getenv("EvalCombo"..pname(player))
		end
		Step["Score"] = DP(player)
		if Step["FA"] then
			local W0Count = getenv("W0"..pname(player)) or 0
			local WXCount = getenv("WX"..pname(player)) or 0
			local W0Total = getMaxNotes(player)
			local W0Percent = scale(W0Total/(W0Total+(WXCount-W0Count)),0.5,1.0,0.9,1.0)
			Step["ScoreFA"] = DP(player)*W0Percent
		end
		Step["Grade"] = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetGrade()
		Step["Difficulty"] = GAMESTATE:GetCurrentSteps(player):GetDifficulty()
		Step["Meter"] = GAMESTATE:GetCurrentSteps(player):GetMeter()
		if ThemePrefs.Get("ShowCalcDiff") then
			local calced = getCalculatedDifficulty(GAMESTATE:GetCurrentSteps(player))
			calced = split("\n",calced)
			calced = split(" ",calced[1])[1]
			Step["CalcedMeter"] = calced
		end
		if ThemePrefs.Get("ShowTime") then
			local fail = STATSMAN:GetCurStageStats(player):GetPlayerStageStats(player):GetFailed()
			local alive = STATSMAN:GetCurStageStats(player):GetPlayerStageStats(player):GetAliveSeconds()
			local first = LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player),"TrueFirstSecond")
			local last = LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player),"TrueLastSecond")
			Step["PlayedTime"] = math.min(alive-first,last-first)
			Step["TotalTime"] = last-first
		end
		if player == PLAYER_1 then
			P1[0] = {["Name"]=PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)}
			P1[currentStage] = Step
		else
			P2[0] = {["Name"]=PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)}
			P2[currentStage] = Step
		end
	end

	if ThemePrefs.Get("ShowSummary") then
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do playerData(pn) end
		Master[currentStage] = {
			["Banner"] = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetBannerPath() or GAMESTATE:GetCurrentSong():GetBannerPath(),
			["Title"] = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),
			["Subtitle"] = GAMESTATE:IsCourseMode() and "" or GAMESTATE:GetCurrentSong():GetDisplaySubTitle(),
			["Artist"] = GAMESTATE:IsCourseMode() and "" or GAMESTATE:GetCurrentSong():GetDisplayArtist(),
			["Restart"] = getenv("Restart")
		}
		if checkBMS() and not GAMESTATE:IsCourseMode() then
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			Master[currentStage]["Title"] = GetBMSTitle(steps,1)
			Master[currentStage]["Subtitle"] = GetBMSTitle(steps,2)
			Master[currentStage]["Artist"] = GetBMSArtist(steps)
		end
	end
end

function SummaryBackup()
	local path = "Save/SummaryBackup"

	if #Master > 0 then
		IniFile.WriteFile(path.."Master.ini",Master)
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."Master.ini") end
	end
	if P1 and #P1 > 0 then
		IniFile.WriteFile(path.."P1.ini",P1)
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P1.ini") end
	end
	if P2 and #P2 > 0 then
		IniFile.WriteFile(path.."P2.ini",P2)
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P2") end
	end
end

function SummaryBackupClear()
	local path = "Save/SummaryBackup"
	if FILEMAN:DoesFileExist(path.."Master.ini") then
		IniFile.WriteFile(path.."Master.ini", { [""] = {} })
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."Master.ini") end
	end
	if FILEMAN:DoesFileExist(path.."P1.ini") then
		IniFile.WriteFile(path.."P1.ini", { [""] = {} })
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P1.ini") end
	end
	if FILEMAN:DoesFileExist(path.."P2.ini") then
		IniFile.WriteFile(path.."P2.ini", { [""] = {} })
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P2") end
	end
end

function SummaryBackupCheck()
	local path = "Save/SummaryBackup"
	if FILEMAN:DoesFileExist(path.."Master.ini") then
		local loaded = IniFile.ReadFile(path.."Master.ini")
		for _,value in pairs(loaded) do
			Master[tonumber(_)] = value
			SummaryAdjust = tonumber(_)
		end
	end
	if FILEMAN:DoesFileExist(path.."P1.ini") then
		local loaded = IniFile.ReadFile(path.."P1.ini")
		for _,value in pairs(loaded) do P1[tonumber(_)] = value end
	end
	if FILEMAN:DoesFileExist(path.."P2.ini") then
		local loaded = IniFile.ReadFile(path.."P2.ini")
		for _,value in pairs(loaded) do P2[tonumber(_)] = value end
	end
end

function ITGJudgments(beginner)
	return {
		TapNoteScore_W0 = "Fantastic+",
		TapNoteScore_W1 = "Fantastic",
		TapNoteScore_W2 = "Excellent",
		TapNoteScore_W3 = "Great",
		TapNoteScore_W4 = (beginner and "Too Early/Late" or "Decent"),
		TapNoteScore_W5 = (beginner and "Way Early/Late" or "Way Off"),
		TapNoteScore_Miss = "Miss",
	}
end

function IIDXJudgments()
	return {
		TapNoteScore_W0 = "Great+",
		TapNoteScore_W1 = "Great",
		TapNoteScore_W2 = "Great",
		TapNoteScore_W3 = "Good",
		TapNoteScore_W4 = "Bad",
		TapNoteScore_W5 = "Bad",
		TapNoteScore_Miss = "Poor",
	}
end

function POPNJudgments()
	return {
		TapNoteScore_W0 = "Cool+",
		TapNoteScore_W1 = "Cool",
		TapNoteScore_W2 = "Great",
		TapNoteScore_W3 = "Good",
		TapNoteScore_W4 = "Bad",
		TapNoteScore_W5 = "Bad",
		TapNoteScore_Miss = "Poor",
	}
end