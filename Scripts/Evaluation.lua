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
	return isPlayMode("PlayMode_Rave") or isPlayMode("PlayMode_Battle") or false
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
				local trueSeconds = 0
				if UsesStepCache() then
					trueSeconds = tonumber(LoadFromCache(song,step,"TrueSeconds"))
				else
					trueSeconds = song:GetFirstSecond() > song:GetLastSecond() and 0 or (isOutFox(20211230) and step:GetChartLength() or song:GetLastSecond()-song:GetFirstSecond())
				end
				fSecs = fSecs + trueSeconds
			end
		end
	else
		local Song = GAMESTATE:GetCurrentSong()
		if UsesStepCache() then
			fSecs = tonumber(LoadFromCache(Song,StepsOrTrail,"TrueSeconds"))
		else
			fSecs = Song:GetFirstSecond() > Song:GetLastSecond() and 0 or (isOutFox(20211230) and StepsOrTrail:GetChartLength() or Song:GetLastSecond()-Song:GetFirstSecond())
		end
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
			local trueSeconds = 0
			if UsesStepCache() then
				trueSeconds = tonumber(LoadFromCache(Song,Steps,"TrueSeconds"))
			else
				trueSeconds = Song:GetFirstSecond() > Song:GetLastSecond() and 0 or (isOutFox(20211230) and Steps:GetChartLength() or Song:GetLastSecond()-Song:GetFirstSecond())
			end
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
	local offsetInfo = {
		[PLAYER_1] = getenv("OffsetTableP1"),
		[PLAYER_2] = getenv("OffsetTableP2")
	}
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
			local first = 0
			local last = 0
			if UsesStepCache() then
				first = LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player),"TrueFirstSecond")
				last = LoadFromCache(GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player),"TrueLastSecond")
			else
				first = GAMESTATE:GetCurrentSong():GetFirstSecond()
				last = GAMESTATE:GetCurrentSong():GetLastSecond()
			end
			Step["PlayedTime"] = math.min(alive-first,last-first)
			Step["TotalTime"] = last-first
		end

		local Song = GAMESTATE:GetCurrentSong()
		local seconds = 0
		if UsesStepCache() then
			local Steps = GAMESTATE:GetCurrentSteps(player)
			seconds = tonumber(LoadFromCache(Song,Steps,"TrueSeconds"))
		else
			seconds = Song:GetLastSecond()-Song:GetFirstSecond()
		end
		seconds = seconds / GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate()
		local total = getenv("TimePlayed"..pname(player))
		setenv("TimePlayed"..pname(player),total+seconds)

		if player == PLAYER_1 then
			P1[0] = {
				["Name"]=PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player),
				["TimePlayed"]=getenv("TimePlayedP1")+TimePlayerP1Adjust
			}
			P1[currentStage] = Step
		else
			P2[0] = {
				["Name"]=PROFILEMAN:GetPlayerName(player) == "" and ToEnumShortString(player) or PROFILEMAN:GetPlayerName(player),
				["TimePlayed"]=getenv("TimePlayedP2")+TimePlayerP2Adjust
			}
			P2[currentStage] = Step
		end
	end
	Master[0] = { ["SessionTime"]=GetTimeSinceStart() - getenv("SessionStart") }

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
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = "Save/SummaryBackup/"..category.."_"

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
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P2.ini") end
	end
end

function SummaryBackupClear()
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = "Save/SummaryBackup/"..category.."_"
	SummaryAdjust = 0
	TimePlayerP1Adjust = 0
	TimePlayerP2Adjust = 0
	SessionTimeAdjust = 0
	if FILEMAN:DoesFileExist(path.."Master.ini") then
		IniFile.WriteFile(path.."Master.ini",{[""]={}})
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."Master.ini") end
	end
	if FILEMAN:DoesFileExist(path.."P1.ini") then
		IniFile.WriteFile(path.."P1.ini",{[""]={}})
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P1.ini") end
	end
	if FILEMAN:DoesFileExist(path.."P2.ini") then
		IniFile.WriteFile(path.."P2.ini",{[""]={}})
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path.."P2.ini") end
	end
end

function SummaryBackupCheck()
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = "Save/SummaryBackup/"..category.."_"
	if FILEMAN:DoesFileExist(path.."Master.ini") then
		local loaded = IniFile.ReadFile(path.."Master.ini")
		for _,value in pairs(loaded) do
			Master[tonumber(_)] = value
			SummaryAdjust = tonumber(_)
		end
		if Master[0] and Master[0]["SessionTime"] then SessionTimeAdjust = Master[0]["SessionTime"] end
	end
	if FILEMAN:DoesFileExist(path.."P1.ini") then
		local loaded = IniFile.ReadFile(path.."P1.ini")
		for _,value in pairs(loaded) do P1[tonumber(_)] = value end
		if P1[0] and P1[0]["TimePlayed"] then TimePlayerP1Adjust = P1[0]["TimePlayed"] end
	end
	if FILEMAN:DoesFileExist(path.."P2.ini") then
		local loaded = IniFile.ReadFile(path.."P2.ini")
		for _,value in pairs(loaded) do P2[tonumber(_)] = value end
		if P2[0] and P2[0]["TimePlayed"] then TimePlayerP2Adjust = P2[0]["TimePlayed"] end
	end
	if SummaryAdjust > 0 then return true else return false end
end

local ProfileSlot = {
	[PLAYER_1] = "ProfileSlot_Player1",
	[PLAYER_2] = "ProfileSlot_Player2"
}

function PacemakerLoad(player)
	if UsesStepCache() then
		if not player then return false end
		if not ProfileSlot[player] then return false end
		local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
		if not dir or #dir == 0 then return false end
		local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
		local path = dir.."Pacemaker/"..category..".ini"

		PaceMaker[player] = {}
		PaceMaker[player][category] = {}
		if FILEMAN:DoesFileExist(path) then
			local PM = IniFile.ReadFile(path)
			local isOld = false

			for _, v in pairs(PM) do
				for key, _ in pairs(v) do
					if key:len() <= 4 then
						isOld = true
						break
					end
				end
				if isOld then break end
			end

			if isOld then
				return false
			else
				for k, v in pairs(PM) do
					PaceMaker[player][category][tonumber(k)] = v
				end
				return true
			end
		end
	end

	return false
end

function PacemakerSave(player)
	if UsesStepCache() then
		if not player then return end
		if not ProfileSlot[player] then return end
		local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
		local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
		local path = dir.."/Pacemaker/"..category..".ini"

		if PaceMaker[player] and PaceMaker[player][category] then
			IniFile.WriteFile(path,PaceMaker[player][category])
			if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
		end
	end
end

function ResetPacemaker(pn)
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	if PaceMaker[pn] and PaceMaker[pn][category] and #PaceMaker[pn][category] > 0 then PaceMaker[pn][category] = {} end
end

function PreparePacemaker(pn)
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	SetCategory(category)
	if not isEtterna("0.55") and not (PaceMaker[pn] and PaceMaker[pn][category] and #PaceMaker[pn][category] > 0) and not PacemakerLoad(pn) then
		local stepsType = StepsTypeSingle()[GetUserPrefN("StylePosition")]
		local stepType = split("_",stepsType)
		local songs = SONGMAN:GetAllSongs()
		for s=1,#songs do
			if songs[s]:HasStepsType(category) then
				local steps = songs[s]:GetStepsByStepsType(category)
				for ss=1,#steps do
					local highscores = PROFILEMAN:GetProfile(pn):GetHighScoreList(songs[s],steps[ss]):GetHighScores()
					if #highscores > 0 then
						local highscore = highscores[1]
						if highscore:GetGrade()~="Grade_Failed" then
							local SPS = 0

							if UsesStepCache() then
								SPS = tonumber(LoadFromCache(songs[s],steps[ss],"StepsPerSecond"))
							else
								local trueSeconds = isOutFox(20211230) and steps[ss]:GetChartLength() or songs[s]:GetLastSecond()-songs[s]:GetFirstSecond()
								if not VersionDateCheck(20150500) then
									SPS = RadarCategory_Notes(songs[s],steps[ss])/trueSeconds
								else
									SPS = steps[ss]:GetRadarValues(player):GetValue("RadarCategory_Notes")/trueSeconds
								end
							end

							if SPS then
								if IsGame("be-mu") or IsGame("beat") then
									SPS = SPS / 2
								else
									SPS = SPS * (getColumnsPerPlayer(stepType[2],stepType[3],true) / 4)
								end

								SPS = math.floor(SPS)
								PaceMaker[pn][category][math.floor(SPS)]=PaceMaker[pn][category][math.floor(SPS)] or {}

								if highscore:GetPercentDP() > 0.5 then
									local songDir = songs[s]:GetSongDir()
									local arr = split("/",songDir)
									local difficulty = ToEnumShortString(steps[ss]:GetDifficulty())
									local identifier = steps[ss]:GetHash()
									if identifier == 0 then identifier = steps[ss]:GetMeter() end
									songDir = arr[4].."/"..difficulty.."/"..identifier
									PaceMaker[pn][category][math.floor(SPS)][arr[3].."/"..songDir] = highscore:GetPercentDP()
								end
							end
						end
					end
				end
			end
		end
		PacemakerSave(pn)
	end
end

function WIFE3Load(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	if not dir or #dir == 0 then return end
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = dir.."/WIFE3/"..category..".ini"

	WIFE3[player] = {}
	WIFE3[player][category] = {}
	if FILEMAN:DoesFileExist(path) then
		WIFE3[player][category] = IniFile.ReadFile(path)
	end
end

function WIFE3Save(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = dir.."/WIFE3/"..category..".ini"

	if WIFE3[player] and WIFE3[player][category] then
		IniFile.WriteFile(path,WIFE3[player][category])
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
	end
end

function FAplusLoad(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	if not dir or #dir == 0 then return end
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = dir.."/FAplus/"..category..".ini"

	FAplus[player] = {}
	FAplus[player][category] = {}
	if FILEMAN:DoesFileExist(path) then
		FAplus[player][category] = IniFile.ReadFile(path)
	end
end

function FAplusSave(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = dir.."/FAplus/"..category..".ini"

	if FAplus[player] and FAplus[player][category] then
		IniFile.WriteFile(path,FAplus[player][category])
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
	end
end

function IIDXClearLoad(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	if not dir or #dir == 0 then return end
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = dir.."/IIDXClear/"..category..".ini"

	IIDXClear[player] = {}
	IIDXClear[player][category] = {}
	if FILEMAN:DoesFileExist(path) then
		IIDXClear[player][category] = IniFile.ReadFile(path)
	end
end

function IIDXClearSave(player)
	if not player then return end
	if not ProfileSlot[player] then return end
	local dir = PROFILEMAN:GetProfileDir(ProfileSlot[player])
	local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
	local path = dir.."/IIDXClear/"..category..".ini"

	if IIDXClear[player] and IIDXClear[player][category] then
		IniFile.WriteFile(path,IIDXClear[player][category])
		if FILEMAN.FlushDirCache then FILEMAN:FlushDirCache(path) end
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