local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")
local record = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPersonalHighScoreIndex()

if getenv("EvalCombo"..pname(player)) then
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
				local trueSeconds = song:GetLastSecond()-song:GetFirstSecond()
				if not VersionDateCheck(20150500) then
					SPS = RadarCategory_Notes(song,steps)/trueSeconds
				else
					SPS = steps:GetRadarValues(player):GetValue("RadarCategory_Notes")/trueSeconds
				end
			end
		end
	end
	if record == 0 then
		local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
		PaceMaker[player][category][math.floor(SPS)]=PaceMaker[player][category] and PaceMaker[player][category][math.floor(SPS)] or {}
		local DP = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints()
		if DP > 0.5 then
			PaceMaker[player][category][math.floor(SPS)][#PaceMaker[player][category][math.floor(SPS)]+1] = DP
			local highscores = PROFILEMAN:GetProfile(player):GetHighScoreList(song,steps):GetHighScores()
			if #highscores > 1 then
				local toDelete = highscores[2]:GetPercentDP()
				local index = FindInTable(toDelete,PaceMaker[player][category][math.floor(SPS)])
				if index then table.remove(PaceMaker[player][category][math.floor(SPS)],index) end
			end
			PacemakerSave(player)
		end
	end
end

local hasPersonalRecord = (record == 0) and STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints() > 0
--if hasPersonalRecord and not STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetFailed() then setenv("HighScoreable"..pname(player),true) end

return Def.ActorFrame{
	Def.BitmapText {
		File = "_v 26px bold white",
		Text="New Personal Record!",
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(2*WideScreenDiff()):cropright(1):visible(hasPersonalRecord) end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}