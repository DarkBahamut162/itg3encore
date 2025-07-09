local player = ...
assert(player,"[ScreenEvaluation PersonalRecord] requires player")

local HighscoreRecord = ""
local TargetRecord = ""
if getenv("EvalCombo"..pname(player)) then
	local total =  GAMESTATE:GetNumPlayersEnabled()
	if (total == 1 and (getenv("ShowStatsP1") == (isOpenDDR() and 6 or 7) or getenv("ShowStatsP2") == (isOpenDDR() and 6 or 7))) or (total == 2 and (getenv("ShowStatsP1") == (isOpenDDR() and 6 or 7) and getenv("ShowStatsP2") == (isOpenDDR() and 6 or 7))) then
		local SongOrCourse,StepsOrTrail,scorelist,topscore
		local DPCurrent = isEtterna() and DP(player) or DPCur(player)
		local target = THEME:GetMetric("PlayerStageStats","GradePercentTier"..string.format("%02d",18-getenv("SetPacemaker"..pname(player))))
		local HighScore = 0
		local Max = isEtterna() and 1 or STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPossibleDancePoints()
		local Target = target*Max

		if GAMESTATE:IsCourseMode() then SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentCourse(),GAMESTATE:GetCurrentTrail(player) else SongOrCourse,StepsOrTrail = GAMESTATE:GetCurrentSong(),GAMESTATE:GetCurrentSteps(player) end
		if not isEtterna() and not scorelist then scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail) end
		if not isEtterna() and not scorelist then scorelist = PROFILEMAN:GetProfile(player):GetHighScoreList(SongOrCourse,StepsOrTrail) end
		if scorelist then topscore = scorelist:GetHighScores() end
		if isEtterna() then
			local score = SCOREMAN:GetMostRecentScore()
			local origTable = getScoresByKey(player)
			local rtTable = getRateTable(origTable) or {}
			topscore = rtTable[getRate(score)] or {score}
		end

		local first = topscore and #topscore >= 1 or false
		local second = topscore and #topscore > 1 or false
		local hasHighscore = STATSMAN:GetCurStageStats():GetPlayerStageStats(player):GetPercentDancePoints() > 0
		local hasHighscoreCheck = second or (first and not hasHighscore)

		if topscore and hasHighscoreCheck then HighScore = PercentDP(topscore[1])*Max end

		if DPCurrent >= HighScore and hasHighscoreCheck and DPCurrent >= Target then
			HighscoreRecord = "HIGHSCORE\nPASSED"
			TargetRecord = "TARGET\nMET"
		elseif DPCurrent < HighScore and hasHighscoreCheck and DPCurrent >= Target then
			HighscoreRecord = "HIGHSCORE\nFAILED"
			TargetRecord = "TARGET\nMET"
		elseif DPCurrent >= HighScore and hasHighscoreCheck and DPCurrent < Target then
			HighscoreRecord = "HIGHSCORE\nPASSED"
			TargetRecord = "TARGET\nMISSED"
		elseif DPCurrent < HighScore and hasHighscoreCheck and DPCurrent < Target then
			HighscoreRecord = "HIGHSCORE\nFAILED"
			TargetRecord = "TARGET\nMISSED"
		elseif DPCurrent >= Target then
			TargetRecord = "TARGET\nMET"
		elseif DPCurrent < Target then
			TargetRecord = "TARGET\nMISSED"
		end

		local index = (second and DPCurrent >= HighScore) and 2 or 1

		if topscore and hasHighscoreCheck and DPCurrent >= HighScore then HighScore = PercentDP(topscore[index])*Max end
		if HighScore > 0 then HighscoreRecord = HighscoreRecord.."::"..FormatPercentScore(PercentDP(topscore[index])).."\n"..string.format("%+.2f%%",math.floor((DPCurrent-HighScore)/Max*10000)/100) end
		TargetRecord = TargetRecord.."::"..FormatPercentScore(target).."\n"..string.format("%+.2f%%",math.floor((DPCurrent/Max-target)*10000)/100)
	end
end

local textA = {}
local textB = {}
local indexA = 1
local indexB = 1
local switch = THEME:GetMetric("HelpDisplay","TipSwitchTime")
local startA = GetTimeSinceStart()
local startB = GetTimeSinceStart()

local HelpDisplay = isEtterna() and Def.ActorFrame{
	Def.BitmapText {
		File=THEME:GetPathF("HelpDisplay","text"),
		InitCommand=function(self)
			local s = HighscoreRecord
			textA = split("::",s)
			self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5)
			self:x(-40):zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):maxwidth(333):vertspacing(-10):sleep(3):queuecommand("Update")
			self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#00FF00"))
		end,
		UpdateCommand=function(self)
			if #textA == 1 then
				self:settext(textA[1])
			else
				local current = GetTimeSinceStart()
				if current-startA >= switch then
					startA = current
					if #textA == indexA then indexA = 1 else indexA = indexA + 1 end
				end

				self:settext(textA[indexA]):sleep(1/60):queuecommand("Update")
			end
		end
	},
	Def.BitmapText {
		File=THEME:GetPathF("HelpDisplay","text"),
		InitCommand=function(self)
			local s = TargetRecord
			textB = split("::",s)
			self:shadowlength(0):diffuseshift():effectcolor1(color("#FFFFFF")):effectcolor2(color("#9A9999")):effectperiod(1.5)
			self:x(HighscoreRecord == "" and 0 or 40):zoomx(0.6):zoomy(0.5):shadowlength(1):cropright(1):maxwidth(333):vertspacing(-10):sleep(3):queuecommand("Update")
			self:linear(0.3):cropright(0):diffuseshift():effectcolor1(color("#FF0000"))
		end,
		UpdateCommand=function(self)
			if #textB == 1 then
				self:settext(textB[1])
			else
				local current = GetTimeSinceStart()
				if current-startB >= switch then
					startB = current
					if #textB == indexB then indexB = 1 else indexB = indexB + 1 end
				end

				self:settext(textB[indexB]):sleep(1/60):queuecommand("Update")
			end
		end
	}
} or Def.ActorFrame{
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

return HelpDisplay