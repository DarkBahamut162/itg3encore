function OffsetLifebarHeight(pn)
	if getenv("RotationLeft"..ToEnumShortString(pn)) or getenv("RotationRight"..ToEnumShortString(pn)) then
		return SCREEN_CENTER_Y
	else
		return SCREEN_CENTER_Y+30
	end
end

local diffState = {
	Difficulty_Beginner = 0,
	Difficulty_Easy = 1,
	Difficulty_Medium = 2,
	Difficulty_Hard = 3,
	Difficulty_Challenge = 4,
	Difficulty_Edit = 5,
};

function DifficultyToState(diff)
	return diffState[diff]
end

function GetSongFrame()
	if GAMESTATE:IsCourseMode() then return "_normal" end
	local song = GAMESTATE:GetCurrentSong()
	local songTitle = song:GetDisplayFullTitle()
	local songArtist = song:GetDisplayArtist()
	local songDir = song:GetSongDir()
	local frame
	if string.find(songDir,"Dance Dance Revolution 8th Mix") or string.find(songDir,"Dance Dance Revolution Extreme") then
		frame = "_extreme"
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
	if GAMESTATE:IsAnExtraStage() then
		return false
	else
		return true
	end
end

function GetComboXOffset(pn)
	if getenv("HideCombo" .. ToEnumShortString(pn)) then
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
		local SongOrCourse, StepsOrTrail

		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse()
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
		else
			SongOrCourse = GAMESTATE:GetCurrentSong()
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

local StepCount = {0,0};
function StepEvenOdd(player)
	local PX = (player == PLAYER_1) and 1 or 2;
	StepCount[PX]=StepCount[PX]+1;
	if StepCount[PX] % 2 == 0 then
		return 1
	else
		return -1
	end
end

local HoldCount = {0,0};
function HoldEvenOdd(player)
	local PX = (player == PLAYER_1) and 1 or 2;
	HoldCount[PX]=HoldCount[PX]+1;
	if HoldCount[PX] % 2 == 0 then
		return 1
	else
		return -1
	end
end