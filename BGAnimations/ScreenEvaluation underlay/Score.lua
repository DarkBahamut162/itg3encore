local player = ...
local scoreType = getenv("SetScoreType"..pname(GAMESTATE:IsHumanPlayer(player) and player or OtherPlayer[player]))
local enableEPL = ThemePrefs.Get("ExperimentalProfileLevel")
local Data = nil
local EXP_STEPS = 0
local EXP_MAX = 0
local CALC_LV = 1
local allowed = getenv("EvalCombo"..pname(player))
local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
local length = TotalPossibleStepSeconds(player)
local cleared = isEtterna("0.55") and not STATSMAN:GetCurStageStats():Failed() or (not PSS:GetFailed() and PSS:GetAliveSeconds() > length)

if PROFILEMAN:IsPersistentProfile(player) and enableEPL then
	local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
	if cleared then allowed = getenv("EvalCombo"..pname(player)) else allowed = false end

	local Song = GAMESTATE:GetCurrentSong()
	local Steps = GAMESTATE:GetCurrentSteps(player)
	local SPS = tonumber(LoadFromCache(Song,Steps,"StepsPerSecond"))
	local trueSeconds = tonumber(LoadFromCache(Song,Steps,"TrueSeconds"))
	EXP_STEPS = math.floor(DP(player)*SPS*100*(trueSeconds/120))
	EXP_MAX = math.floor(SPS*100*(trueSeconds/120))

	Data = GetData(player)
	local CALC_EXP = 0
	local CALC_NEXT = 0

	while CALC_EXP < Data["EXP"] + EXP_STEPS do
		CALC_EXP = CALC_EXP + math.pow(2,CALC_LV)
		CALC_LV = CALC_LV + 1
	end
	if CALC_EXP > Data["EXP"] + EXP_STEPS then
		CALC_LV = CALC_LV - 1
		CALC_NEXT = CALC_EXP - math.pow(2,CALC_LV)
	end
	if not cleared or not allowed then EXP_STEPS = EXP_STEPS * -1 end
end

local stepSize = 1

if scoreType == 4 or scoreType == 5 then
	local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
	local StepsOrTrail = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
	if StepsOrTrail then
		if IsCourseSecret() or not IsCourseFixed() then
			stepSize = RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_TapsAndHolds")
			stepSize = math.max(stepSize + RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_Holds") + RadarCategory_Trail(StepsOrTrail,player,"RadarCategory_Rolls"),1)
		else
			stepSize = StepsOrTrail:GetRadarValues(player):GetValue("RadarCategory_TapsAndHolds") or 0
			stepSize = math.max(stepSize + StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Holds') + StepsOrTrail:GetRadarValues(player):GetValue('RadarCategory_Rolls'),1)
		end
	end
end

return Def.ActorFrame{
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Score"..pname(player),
		InitCommand=function(self)
			self:diffuse(PlayerColor(player))
			if isTopScreen("ScreenEvaluationWorkout") or isTopScreen("ScreenEvaluationCourseWorkout") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-58*WideScreenDiff() or SCREEN_CENTER_X+58*WideScreenDiff()):y(SCREEN_CENTER_Y+92*WideScreenDiff()):zoom(2/3*WideScreenDiff()):addy(getenv("SetScoreFA"..pname(player)) and -12*WideScreenDiff() or 0)
			elseif isTopScreen("ScreenEvaluationRave") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-196*WideScreenDiff() or SCREEN_CENTER_X+196*WideScreenDiff()):y(SCREEN_CENTER_Y+160*WideScreenDiff()):zoom(WideScreenDiff())
			else
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-199*WideScreenDiff() or SCREEN_CENTER_X+199*WideScreenDiff()):y(SCREEN_CENTER_Y+52*WideScreenDiff()):zoom(WideScreenDiff())
			end
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if isSurvival(player) then
				self:settext(SecondsToMSSMsMs(pss:GetSurvivalSeconds()-pss:GetLifeRemainingSeconds())) -- SURVIVAL
			elseif scoreType == 1 then
				output = pss:GetScore()
				self:settextf("%09d",output) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(9-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
				if isTopScreen("ScreenEvaluationWorkout") or isTopScreen("ScreenEvaluationCourseWorkout") then self:zoomx(1/2*WideScreenDiff()) else self:zoomx(8/9*WideScreenDiff()) end
			elseif scoreType == 2 then
				self:settext(FormatPercentScore(DP(player))) -- PERCENT
			elseif scoreType == 3 then
				output = DPCur(player)
				self:settextf("%04d",output) -- EX
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(4-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 4 then
				local w1 = pss:GetTapNoteScores('TapNoteScore_W1')
				local w2 = pss:GetTapNoteScores('TapNoteScore_W2')
				local w3 = pss:GetTapNoteScores('TapNoteScore_W3')
				local hd = pss:GetHoldNoteScores('HoldNoteScore_Held')
				local score = (w1 + w2 + w3 + hd) * 100000 / stepSize
				local sub = (w3*0.5) * 100000 / stepSize
				output = (math.floor(score-sub) - (w2 + w3))*10
				self:settextf("%07d",output) -- SN SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(7-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 5 then
				local w1 = pss:GetTapNoteScores('TapNoteScore_W1')
				local w2 = pss:GetTapNoteScores('TapNoteScore_W2')
				local w3 = pss:GetTapNoteScores('TapNoteScore_W3')
				local hd = pss:GetHoldNoteScores('HoldNoteScore_Held')
				local score = math.floor((w1+hd + w2*(2/3) + w3*(2/15)) * 200000 / stepSize)
				self:settextf("%06d",score) -- SN SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(6-string.len(''..score), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 6 then
				self:settext(FormatPercentScore(math.max(0,getenv("WIFE3"..pname(player)) or 0))) -- WIFE3
			end
		end,
		OnCommand=function(self)
			self:addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()):sleep(3):decelerate(0.3):addx(player == PLAYER_1 and EvalTweenDistance() or -EvalTweenDistance())
			if ThemePrefs.Get("ShowSummary") and not isEtterna("0.55") then
				local currentStage = GAMESTATE:GetCurrentStageIndex()
				Master[currentStage]["EXP"] = EXP_MAX
				if player == PLAYER_1 then P1[currentStage]["EXP"] = EXP_STEPS else P2[currentStage]["EXP"] = EXP_STEPS end
			end
		end,
		OffCommand=function(self)
			self:accelerate(0.3):addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance())
			local Song = GAMESTATE:GetCurrentSong()
			local seconds = 0
            if ThemePrefs.Get("UseStepCache") then
                local Steps = GAMESTATE:GetCurrentSteps(player)
                seconds = tonumber(LoadFromCache(Song,Steps,"TrueSeconds"))
            else
                seconds = Song:GetLastSecond()-Song:GetFirstSecond()
            end
			seconds = seconds / GAMESTATE:GetSongOptionsObject("ModsLevel_Preferred"):MusicRate()
			local total = getenv("TimePlayed"..pname(player))
			setenv("TimePlayed"..pname(player),total+seconds)
			if GAMESTATE:IsHumanPlayer(player) and allowed then if UpdateData(player,{["LV"]=CALC_LV,["EXP"]=Data["EXP"]+EXP_STEPS}) then SaveData(player) end end
		end
	},
	Def.BitmapText {
		Condition=allowed,
		File = "_v 26px bold black",
		Name="EXP"..pname(player),
		InitCommand=function(self)
			local adjust = WideScaleFixed(95*WideScreenDiff(),130*WideScreenDiff())
			self:x(player == PLAYER_1 and SCREEN_CENTER_X-adjust or SCREEN_CENTER_X+adjust)
			self:y(SCREEN_BOTTOM-11*WideScreenDiff()):zoom(0.5*WideScreenDiff()):shadowlength(0):halign(player == PLAYER_1 and 1 or 0):valign(1):vertspacing(-8):settext("EXP GAINED\n"..EXP_STEPS)
		end
	}
}