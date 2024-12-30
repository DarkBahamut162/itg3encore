local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")

local HighscoreRecord = ""
local TargetRecord = ""
if getenv("EvalCombo"..pname(player)) then
	local total =  GAMESTATE:GetNumPlayersEnabled()
	if (total == 1 and (getenv("ShowStatsP1") == 7 or getenv("ShowStatsP2") == 7)) or (total == 2 and (getenv("ShowStatsP1") == 7 and getenv("ShowStatsP2") == 7)) then
		local SongOrCourse,StepsOrTrail,scorelist,topscore
		local DPCurrent = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetActualDancePoints()
		local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",18-getenv("SetPacemaker"..pname(player))))
		local HighScore = 0
		local Max = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPossibleDancePoints()
		local Target = target*Max

		if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(player) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player) end
		if not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
		if not scorelist then scorelist = PROFILEMAN:GetProfile(player):GetHighScoreList(SongOrCourse,StepsOrTrail) end
		if scorelist then topscore = scorelist:GetHighScores() end
		local first = #topscore <= 1
		if topscore and not first then HighScore = topscore[1]:GetPercentDP()*Max end

		if DPCurrent >= HighScore and not first and DPCurrent >= Target then
			HighscoreRecord = "HIGHSCORE\nPASSED"
			TargetRecord = "TARGET\nMET"
		elseif DPCurrent < HighScore and not first and DPCurrent >= Target then
			HighscoreRecord = "HIGHSCORE\nFAILED"
			TargetRecord = "TARGET\nMET"
		elseif DPCurrent >= HighScore and not first and DPCurrent < Target then
			HighscoreRecord = "HIGHSCORE\nPASSED"
			TargetRecord = "TARGET\nMISSED"
		elseif DPCurrent < HighScore and not first and DPCurrent < Target then
			HighscoreRecord = "HIGHSCORE\nFAILED"
			TargetRecord = "TARGET\nMISSED"
		elseif first and DPCurrent >= Target then
			TargetRecord = "TARGET\nMET"
		elseif first and DPCurrent < Target then
			TargetRecord = "TARGET\nMISSED"
		end

		local index = DPCurrent >= HighScore and 2 or 1

		if topscore and not first and DPCurrent >= HighScore then HighScore = topscore[index]:GetPercentDP()*Max end
		if HighScore > 0 then HighscoreRecord = HighscoreRecord.."::"..FormatPercentScore(topscore[index]:GetPercentDP()).."\n"..string.format("%+.2f",(DPCurrent-HighScore)/Max*100) end
		TargetRecord = TargetRecord.."::"..FormatPercentScore(target).."\n"..string.format("%+.2f",(DPCurrent/Max-target)*100)

	end
end

return Def.ActorFrame{
	Def.HelpDisplay {
		File=THEME:GetPathF("HelpDisplay", "text"),
		InitCommand=function(self)
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(HighscoreRecord)
			self:x(-40):zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):maxwidth(333):vertspacing(-10):hibernate(3)
		end,
		OnCommand=function(self) self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00FF00")) end
	},
	Def.HelpDisplay {
		File=THEME:GetPathF("HelpDisplay", "text"),
		InitCommand=function(self)
			self:SetSecsBetweenSwitches(THEME:GetMetric("HelpDisplay","TipSwitchTime"))
			self:SetTipsColonSeparated(TargetRecord)
			self:x(HighscoreRecord == "" and 0 or 40):zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):maxwidth(333):vertspacing(-10):hibernate(3)
		end,
		OnCommand=function(self) self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#FF0000")) end
	}
}