local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")

local PacemakerRecord = ""
local total =  GAMESTATE:GetNumPlayersEnabled()
if (total == 1 and (getenv("ShowStatsP1") == 7 or getenv("ShowStatsP2") == 7)) or (total == 2 and (getenv("ShowStatsP1") == 7 and getenv("ShowStatsP2") == 7)) then
	local SongOrCourse,StepsOrTrail,scorelist,topscore
	local DPCurrent = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetActualDancePoints()
	local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",17-getenv("SetPacemaker"..ToEnumShortString(player))))
	local HighScore = 0
	local Target = math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPossibleDancePoints())

	if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(player) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player) end
	if not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
	if not scorelist then scorelist = PROFILEMAN:GetProfile(player):GetHighScoreList(SongOrCourse,StepsOrTrail) end
	if scorelist then topscore = scorelist:GetHighScores() end
	local first = #topscore <= 1
	if topscore and not first then HighScore = math.ceil(topscore[2]:GetPercentDP()*STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPossibleDancePoints()) end
	if DPCurrent >= HighScore and not first and DPCurrent >= Target then
		PacemakerRecord = "HIGHSCORE & TARGET MET"
	elseif DPCurrent < HighScore and not first and DPCurrent >= Target then
		PacemakerRecord = "HIGHSCORE FAILED | TARGET MET"
	elseif DPCurrent >= HighScore and not first and DPCurrent < Target then
		PacemakerRecord = "HIGHSCORE PASSED | TARGET MISSED"
	elseif DPCurrent < HighScore and not first and DPCurrent < Target then
		PacemakerRecord = "HIGHSCORE & TARGET MISSED"
	elseif first and DPCurrent >= Target then
		PacemakerRecord = "TARGET MET"
	elseif first and DPCurrent < Target then
		PacemakerRecord = "TARGET MISSED"
	end
end

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		Text=PacemakerRecord,
		InitCommand=function(self) self:zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):maxwidth(333) end,
		OnCommand=function(self) self:sleep(3):linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00C0FF")) end
	}
}