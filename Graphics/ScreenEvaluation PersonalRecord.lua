local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")
local record = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPersonalHighScoreIndex()

if getenv("EvalCombo"..pname(player)) and isEtterna() then
	local score = SCOREMAN:GetMostRecentScore()
	local origTable = getScoresByKey(player)
	local rtTable = getRateTable(origTable) or {}
	local hsTable = rtTable[getRate(score)] or {score}
	record = getHighScoreIndex(hsTable, score)-1
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