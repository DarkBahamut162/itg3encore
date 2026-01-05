function OffsetLifebarHeight(pn)
	if getenv("Rotation"..pname(pn)) == 2 or getenv("Rotation"..pname(pn)) == 3 then
		return SCREEN_CENTER_Y
	else
		return SCREEN_CENTER_Y+30
	end
end

function DifficultyToState(diff)
	local diffState = {
		Difficulty_Beginner = 0,
		Difficulty_Easy = 1,
		Difficulty_Medium = 2,
		Difficulty_Hard = 3,
		Difficulty_Challenge = 4,
		Difficulty_Edit = 5
	}

	return diffState[diff] or 5
end

function GetSongFrame(pn)
	if IsGame("pump") then return "_piupro" end
	if GAMESTATE:IsCourseMode() then return "_normal" end
	local song = GAMESTATE:GetCurrentSong()
	local songTitle = song and song:GetDisplayFullTitle() or ""
	local songDir = song and song:GetSongDir() or ""
	local frame
	if string.find(songDir,"Dance Dance Revolution 8th Mix") or string.find(songDir,"Dance Dance Revolution Extreme") then
		frame = "_disconnect"
	elseif string.find(songTitle,"VerTex") then
		frame = "_vertex"
	elseif string.find(songTitle,"Dream to Nightmare") then
		frame = "_nightmare"
	elseif string.find(songTitle,"Summer ~Speedy Mix~") then
		frame = "_smiley"
	elseif string.find(songTitle,"Pandemonium") then
		frame = "_pandy"
	elseif string.find(songTitle,"Pink Fuzzy Bunnies") then
		frame = "_bunnies"
	elseif string.find(songTitle,"Virtual Emotion") then
		frame = "_virtual"
	elseif string.find(songTitle,"Hasse Mich") then
		frame = "_hasse"
	elseif string.find(songTitle,"Energizer") then
		frame = "_energy"
	elseif string.find(songTitle,"Love Eternal") then
		frame = "_love"
	elseif string.find(songTitle,"Disconnected Hardkore") then
		frame = "_disconnect"
	elseif getenv("SongFrame"..pname(pn and pn or GAMESTATE:GetMasterPlayerNumber())) then
		frame = getenv("SongFrame"..pname(pn and pn or GAMESTATE:GetMasterPlayerNumber()))
	else
		frame = "_normal"
	end
	return frame
end

function songfail(bVertex)
	local curSong = GAMESTATE:GetCurrentSong()
	if curSong then
		local title = curSong:GetDisplayFullTitle()
		if title == "VerTex" or title == "VerTex²" or title == "VerTex^3" or
			title == "VerTex³" or title == "VerTex3" or title == "VVV" then
			return bVertex and true or false
		end
	end

	return not bVertex
end

function AllowOptionsMenu()
	if isEtterna("0.65") then
		return true
	elseif GAMESTATE:IsAnExtraStage() then
		return false
	else
		return true
	end
end

function GetComboXOffset(pn)
	if getenv("HideCombo" .. pname(pn)) then
		return "SCREEN_WIDTH*2"
	else
		return 0
	end
end

function GetTapScore(pn, category)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	return pss:GetTapNoteScores(category)
end

function GetHoldScore(pn, category)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
	return pss:GetHoldNoteScores(category)
end

function GetNotesHit(pn)
	return GetTapScore(pn, "TapNoteScore_W1") + GetTapScore(pn, "TapNoteScore_W2") + GetTapScore(pn, "TapNoteScore_W3")
end

function PlayerFullComboed(pn)
	if GAMESTATE:IsPlayerEnabled(pn) then
		local StepsOrTrail

		if GAMESTATE:IsCourseMode() then
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
		else
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
		end

		local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
		local TotalHolds = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Holds')
		local TotalRolls = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_Rolls')

		if GetNotesHit(pn) == TotalSteps and GetHoldScore(pn, "HoldNoteScore_Held") == (TotalHolds + TotalRolls) then return true end
	end
	return false
end

function AnyPlayerFullComboed()
	local output = false

	for pn in ivalues(GAMESTATE:GetEnabledPlayers()) do
		if not output then
			output = PlayerFullComboed(pn)
		end
	end
	return output
end

local StepCount = {0,0}
function StepEvenOdd(player)
	local PX = (player == PLAYER_1) and 1 or 2
	StepCount[PX]=StepCount[PX]+1
	if StepCount[PX] % 2 == 0 then
		return 1
	else
		return -1
	end
end

local HoldCount = {0,0}
function HoldEvenOdd(player)
	local PX = (player == PLAYER_1) and 1 or 2
	HoldCount[PX]=HoldCount[PX]+1
	if HoldCount[PX] % 2 == 0 then
		return 1
	else
		return -1
	end
end

function Actor:LyricCommand(side)
	self:settext( Var "LyricText" ):draworder(102):vertspacing(-10):stoptweening():zoomx( math.min(1,SCREEN_WIDTH / (self:GetWidth()+1) * (isFinal() and 17/20 or 9/10)) )

	local lyricColor = Var "LyricColor"
	local Factor = 1
	if side == "Back" then Factor = 0.5 elseif side == "Front" then Factor = 0.9 end
	self:diffuse({lyricColor[1]*Factor,lyricColor[2]*Factor,lyricColor[3]*Factor,lyricColor[4]*Factor})
	if side == "Front" then self:cropright(1) else self:cropleft(0) end
	self:diffusealpha(0):linear(0.1):diffusealpha(1):linear( Var "LyricDuration" * 0.75)
	if side == "Front" then self:cropright(0) else self:cropleft(1) end
	self:sleep( Var "LyricDuration" * 0.25 ):linear(0.1):diffusealpha(0)

	return self
end

function GameplayMarginsFix(enabled_players,styletype)
	local style = GAMESTATE:GetCurrentStyle()
	if styletype == nil then styletype = style:GetStyleType() end
	if enabled_players == nil then enabled_players = GAMESTATE:GetEnabledPlayers() end
	local other = {
		[PLAYER_1] = PLAYER_2,
		[PLAYER_2] = PLAYER_1
	}
	local margins = {
		[PLAYER_1] = {40, 40},
		[PLAYER_2] = {40, 40}
	}

	if Center1Player() then
		local style_width = style:GetWidth(GAMESTATE:GetMasterPlayerNumber())
		local pn = enabled_players[1]
		local center = _screen.cx
		local left = center - style_width
		local right = _screen.w - center - style_width
		if not THEME:GetMetric("ScreenGameplay","AllowCenter1Player") then
			center = (_screen.w - style_width) / WideScreenDiff()
			left = center / 4 * WideScreenDiff()
			right = center / 4 * WideScreenDiff()
		end
		return math.abs(left), -math.abs(center), math.abs(right)
	end

	local half_screen = _screen.w / 2
	local left = {[PLAYER_1]= 0, [PLAYER_2]= half_screen}

	for i, pn in ipairs(enabled_players) do
		local edge = left[pn]
		local center = THEME:GetMetric("ScreenGameplay","Player"..ToEnumShortString(pn)..ToEnumShortString(styletype).."X")
		local style_width = style:GetWidth(pn)

		center = center - edge
		margins[pn][1] = center - (style_width / 2)
		margins[pn][2] = half_screen - center - (style_width / 2)

		if #enabled_players == 1 then
			margins[other[pn]][1] = margins[pn][2]
			margins[other[pn]][2] = margins[pn][1]
		end
	end

	local left = margins[PLAYER_1][1]
	local center = margins[PLAYER_1][2] + margins[PLAYER_2][1]
	local right = margins[PLAYER_2][2]

	return math.abs(left), math.abs(center), math.abs(right)
end

function NotefieldZoom()
	local leftPX, centerPX, rightPX = GameplayMarginsFix()
	local screen_space = Center1Player() and SCREEN_WIDTH or SCREEN_CENTER_X
	local field_space = screen_space - math.abs(leftPX) - math.abs(rightPX)
	local style_width = GAMESTATE:GetCurrentStyle():GetWidth(GAMESTATE:GetMasterPlayerNumber())

	return field_space / style_width
end

function NotefieldZoomOutFox()
	local style_width = GAMESTATE:GetCurrentStyle():GetWidth(GAMESTATE:GetMasterPlayerNumber())
	if GAMESTATE:GetNumPlayersEnabled() == 1 then
		return (SCREEN_WIDTH - 36 - 36) / style_width
	end
	local field_space = SCREEN_CENTER_X - 40 * WideScreenDiff_(16/10) - 40 * WideScreenDiff_(16/10)

	return field_space / style_width
end

function DP(player)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	return math.max(0,isEtterna("0.50") and pss:GetWifeScore() or pss:GetPercentDancePoints())
end
function DPCur(player)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	return math.max(0,isEtterna("0.50") and pss:GetCurWifeScore() or pss:GetActualDancePoints())
end
function DPMax(player)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	return isEtterna("0.50") and math.round(pss:GetCurWifeScore()/pss:GetWifeScore()) or pss:GetPossibleDancePoints()
end
function DPCurMax(player)
	local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	return isEtterna("0.50") and pss:GetMaxWifeScore() or pss:GetCurrentPossibleDancePoints()
end
function PercentDP(topscore)
	return isEtterna("0.50") and topscore:GetWifeScore() or topscore:GetPercentDP()
end

function getMaxNotes(player)
	local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
	if StepsOrTrail then
		if GAMESTATE:GetCurrentGame():CountNotesSeparately() then
			if not VersionDateCheck(20150500) then
				return RadarCategory_Notes(SongOrCourse,StepsOrTrail)
			else
				return StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_Notes")
			end
		else
			return StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds") or 0
		end
	end
	return 0
end

local w1,w2,w3,w4,w5,miss = {},{},{},{},{},{}
function GetTrueJudgment(params,player)
	local _w1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores('TapNoteScore_W1')
	local _w2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores('TapNoteScore_W2')
	local _w3 = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores('TapNoteScore_W3')
	local _w4 = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores('TapNoteScore_W4')
	local _w5 = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores('TapNoteScore_W5')
	local _miss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetTapNoteScores('TapNoteScore_Miss')
	local currentJudgment = "TapNoteScore_None"
	if w1[player] and w2[player] and w3[player] and w4[player] and w5[player] and miss[player] then
		if w1[player] < _w1 then
			currentJudgment = "TapNoteScore_W1"
		elseif w2[player] < _w2 then
			currentJudgment = "TapNoteScore_W2"
		elseif w3[player] < _w3 then
			currentJudgment = "TapNoteScore_W3"
		elseif w4[player] < _w4 then
			currentJudgment = "TapNoteScore_W4"
		elseif w5[player] < _w5 then
			currentJudgment = "TapNoteScore_W5"
		elseif miss[player] < _miss then
			currentJudgment = "TapNoteScore_Miss"
		end
	end
	if params ~= nil and currentJudgment ~= "TapNoteScore_None" then
		local output = ""
		local semi = ""
		local late = -1
		local early = 1
		for col,tapnote in pairs(params.Notes) do
			local tnt = ToEnumShortString(tapnote:GetTapNoteType())
			if tnt == "Tap" or tnt == "HoldHead" or tnt == "LongNoteHead" or tnt == "Lift" then
				local tns = tapnote:GetTapNoteResult():GetTapNoteScore()
				local tno = string.format("%0.10f", tapnote:GetTapNoteResult():GetTapNoteOffset())
				if string.find(tns,"Miss") then tno = string.format("%0.10f", 1) end
				late = math.max(late,tonumber(tno))
				early = math.min(early,tonumber(tno))
				output = addToOutput(output,tns,"|")
				semi = addToOutput(semi,tno,"|")
			end
		end
		local check1 = split("|",output)
		local check2 = split("|",semi)
		if #check1 > 1 and #check2 > 1 then
			local check = math.abs(early) >= math.abs(late) and early or late
			local index = FindInTable(string.format("%0.10f",check),check2)
			if index then
				params.TapNoteScore = check1[index]
				params.TapNoteOffset = string.format("%0.10f",tonumber(check))
				params.Early = tonumber(check) < 0
			else
				lua.ReportScriptError(params.TapNoteScore.." (REGISTERED) ~= "..currentJudgment.." (COUNTED)".." | "..output.." | "..semi.." ("..late..")")
			end
		else
			params.TapNoteScore = output
			params.TapNoteOffset = string.format("%0.10f",tonumber(semi))
			params.Early = tonumber(semi) < 0
		end

		if GAMESTATE:GetCurrentGame():CountNotesSeparately() and getenv("SetScoreFA"..pname(player)) then
			local timing = GetTimingDifficulty()
			local timingChange = { 1.50,1.33,1.16,1.00,0.84,0.66,0.50,0.33,0.20 }
			local JudgeScale = isOutFoxV(20230624) and GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred"):JudgeScale() or 1
			local W0 = 0.0135*timingChange[timing]*JudgeScale
			local Wadd = (isOpenDDR() or isEtterna("0.72")) and 0.0000 or PREFSMAN:GetPreference("TimingWindowAdd")

			W0 = W0 + Wadd

			local W0Counter = getenv("W0"..pname(player)) or 0
			local W1Counter = getenv("W1"..pname(player)) or 0
			local WXCounter = getenv("WX"..pname(player)) or 0

			WXCounter = WXCounter + 1
			setenv("WX"..pname(player),WXCounter)

			if params.TapNoteScore == "TapNoteScore_W1" then
				if math.abs(params.TapNoteOffset) <= W0 then
					W0Counter = W0Counter + 1
					setenv("W0"..pname(player),W0Counter)
				else
					W1Counter = W1Counter + 1
					setenv("W1"..pname(player),W1Counter)
				end
			end

			MESSAGEMAN:Broadcast("W0",{Player=player,W0=W0Counter,W1=W1Counter,WX=WXCounter})
		end
	else
		if params ~= nil and not (IsGame("po-mu") or IsGame("popn")) then params.TapNoteScore = "TapNoteScore_None" end
	end
	w1[player] = _w1
	w2[player] = _w2
	w3[player] = _w3
	w4[player] = _w4
	w5[player] = _w5
	miss[player] = _miss

	return params
end

function GetTotalStageCost(before)
	local stagesPlayed = STATSMAN:GetStagesPlayed()
	local totalStageNum = math.huge
	local totalStage = { [PLAYER_1] = 0, [PLAYER_2] = 0 }
	local LongCutoff = PREFSMAN:GetPreference("LongVerSongSeconds")
	local MarathonCutoff = PREFSMAN:GetPreference("MarathonVerSongSeconds")
	local sub = before and 1 or 0

	for player in ivalues(GAMESTATE:GetHumanPlayers()) do
		for stage = 1, stagesPlayed-sub do
			local playedSS = STATSMAN:GetPlayedStageStats(stage)
			local playerSS = playedSS:GetPlayerStageStats(player)
			local steps = playerSS:GetPlayedSteps()[1]
			local song = playedSS:GetPlayedSongs()[1]
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

	return totalStageNum
end

function GetCurrentTrueStageCost()
	local curStage = math.huge
	local song = GAMESTATE:GetCurrentSong()
	if song then
		local LongCutoff = PREFSMAN:GetPreference("LongVerSongSeconds")
		local MarathonCutoff = PREFSMAN:GetPreference("MarathonVerSongSeconds")

		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			local steps = GAMESTATE:GetCurrentSteps(player)
			if steps then
				local trueSeconds = 0

				if ThemePrefs.Get("UseStepCache") then
					trueSeconds = tonumber(LoadFromCache(song,steps,"TrueSeconds")) or 0
				else
					trueSeconds = song:GetFirstSecond() > song:GetLastSecond() and 0 or song:GetLastSecond()-song:GetFirstSecond()
				end

				local IsMarathon = trueSeconds > MarathonCutoff
				local IsLong     = trueSeconds > LongCutoff
				local ActualSongCost = (IsMarathon and 3) or (IsLong and 2) or 1
				curStage = math.min(curStage,ActualSongCost)
			end
		end

		return curStage
	else
		return 0
	end
end

function GetTrueWidth(player)
	local style = GAMESTATE:GetCurrentStyle()
	local width = style:GetWidth(player)

	if IsGame("be-mu") or IsGame("beat") or IsGame("po-mu") or IsGame("popn") then
		local widthFixed = {
			["Key2"] = 28,
			["Key4"] = 28,
			["Key6"] = 28,
			["Blue"] = 28,
			["Yellow"] = 28,
			["Left Blue"] = 28,
			["Right Blue"] = 28,
			["Left Yellow"] = 28,
			["Right Yellow"] = 28,
			["Key1"] = 36,
			["Key3"] = 36,
			["Key5"] = 36,
			["Key7"] = 36,
			["Green"] = 36,
			["Left Green"] = 36,
			["Right Green"] = 36,
			["Red"] = 36,
			["Left Red"] = 36,
			["Right Red"] = 36,
			["White"] = 36,
			["Left White"] = 36,
			["Right White"] = 36,
			["foot"] = 40,
			["Foot"] = 40,
			["scratch"] = 60,
		}
		local NumColumns = style:ColumnsPerPlayer()
		width = 0
		for ColumnIndex = 1, NumColumns do
			local info = style:GetColumnInfo(player, ColumnIndex)
			width = width + widthFixed[info.Name] + 2
		end
	end

	return width
end