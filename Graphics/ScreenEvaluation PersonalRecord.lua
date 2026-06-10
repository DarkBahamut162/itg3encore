local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")
local record = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPersonalHighScoreIndex()
local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]

local passed = false
if getenv("EvalCombo"..pname(player)) then
	if isEtterna("0.71") then passed = not STATSMAN:GetCurStageStats():Failed() else passed = STATSMAN:GetCurStageStats():OnePassed() end
	if isEtterna("0.55") then
		local score = SCOREMAN:GetMostRecentScore()
		local origTable = getScoresByKey(player)
		local rtTable = getRateTable(origTable) or {}
		local hsTable = rtTable[getRate(score)] or {score}
		record = getHighScoreIndex(hsTable, score)-1
	end
	local SPS

	local song = GAMESTATE:GetCurrentSong()
	local steps
	if song then
		steps = GAMESTATE:GetCurrentSteps(player)
		if steps then
			if ThemePrefs.Get("UseStepCache") then
				SPS = tonumber(LoadFromCache(song,steps,"StepsPerSecond"))
			else
				local trueSeconds = isOutFox(20211230) and steps:GetChartLength() or song:GetLastSecond()-song:GetFirstSecond()
				if not VersionDateCheck(20150500) then
					SPS = RadarCategory_Notes(song,steps)/trueSeconds
				else
					SPS = steps:GetRadarValues(player):GetValue("RadarCategory_Notes")/trueSeconds
				end
			end
		end
	end

	if song and steps and passed and PROFILEMAN:IsPersistentProfile(player) then
		local songDir = GAMESTATE:IsCourseMode() and song:GetCourseDir() or song:GetSongDir()
		local arr = split("/",songDir)
		local difficulty = ToEnumShortString(steps:GetDifficulty())
		local identifier = steps.GetHash and steps:GetHash() or 0
		if identifier == 0 then identifier = steps:GetMeter() end
		songDir = arr[4].."/"..difficulty.."/"..identifier

		local DP = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
		if DP > 0.5 then
			if tonumber(PaceMaker[player][category][math.floor(SPS)] and PaceMaker[player][category][math.floor(SPS)][arr[3].."/"..songDir] or 0) < DP then
				if not PaceMaker[player][category][math.floor(SPS)] then PaceMaker[player][category][math.floor(SPS)] = {} end
				PaceMaker[player][category][math.floor(SPS)][arr[3].."/"..songDir] = DP
				PacemakerSave(player)
			end
		end

		local WIFE3Score = getenv("WIFE3"..pname(player))
		if tonumber(WIFE3[player][category][arr[3]] and WIFE3[player][category][arr[3]][songDir] or 0) < WIFE3Score then
			if not WIFE3[player][category][arr[3]] then WIFE3[player][category][arr[3]] = {} end
			WIFE3[player][category][arr[3]][songDir] = WIFE3Score
			WIFE3Save(player)
		end

		local W0Count = getenv("W0"..pname(player))
		if getenv("SetScoreFA"..pname(player)) then
			if tonumber(FAplus[player][category][arr[3]] and FAplus[player][category][arr[3]][songDir] or 0) < W0Count then
				if not FAplus[player][category][arr[3]] then FAplus[player][category][arr[3]] = {} end
				FAplus[player][category][arr[3]][songDir] = W0Count
				FAplusSave(player)
			end
		end
	end
end

local hasPersonalRecord = (record == 0) and STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints() > 0
--if hasPersonalRecord and not STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed() then setenv("HighScoreable"..pname(player),true) end

return Def.ActorFrame{
	Def.BitmapText {
		File = "_v 26px bold white",
		Text="New Personal Record!",
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(2*WideScreenDiff()):cropright(1):visible(hasPersonalRecord and passed) end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}