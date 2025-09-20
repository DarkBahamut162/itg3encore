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

function prepSummary()
	local currentStage = GAMESTATE:GetCurrentStageIndex()
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
		if player == PLAYER_1 then
			P1[0] = PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)
			P1[currentStage] = Step
		else
			P2[0] = PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player)
			P2[currentStage] = Step
		end
	end

	if ThemePrefs.Get("ShowSummary") then
		for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do playerData(pn) end
		Master[currentStage] = {
			["Banner"] = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetBannerPath() or GAMESTATE:GetCurrentSong():GetBannerPath(),
			["Title"] = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayMainTitle(),
			["Subtitle"] = GAMESTATE:IsCourseMode() and "" or GAMESTATE:GetCurrentSong():GetDisplaySubTitle(),
			["Artist"] = GAMESTATE:IsCourseMode() and "" or GAMESTATE:GetCurrentSong():GetDisplayArtist()
		}
		if checkBMS() and not GAMESTATE:IsCourseMode() then
			local steps = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
			Master[currentStage]["Title"] = GetBMSTitle(steps,1)
			Master[currentStage]["Subtitle"] = GetBMSTitle(steps,2)
			Master[currentStage]["Artist"] = GetBMSArtist(steps)
		end
	end
end