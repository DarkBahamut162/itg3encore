local player = ...
local scoreType = getenv("SetScoreType"..pname(GAMESTATE:IsHumanPlayer(player) and player or OtherPlayer[player]))

local W0Count = getenv("W0"..pname(player)) or 0
local WXCount = getenv("WX"..pname(player)) or 0
local W0Total = getMaxNotes(player)
local W0Percent = scale(W0Total/(W0Total+(WXCount-W0Count)),0.5,1.0,0.9,1.0)

return Def.ActorFrame{
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Score"..pname(player),
		InitCommand=function(self)
			self:diffuse(PlayerColor(nil)):valign(0)
			if isTopScreen("ScreenEvaluationWorkout") or isTopScreen("ScreenEvaluationCourseWorkout") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-58*WideScreenDiff() or SCREEN_CENTER_X+58*WideScreenDiff()):y(SCREEN_CENTER_Y+102*WideScreenDiff()):zoom(1/3*WideScreenDiff())
			elseif isTopScreen("ScreenEvaluationRave") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-196*WideScreenDiff() or SCREEN_CENTER_X+196*WideScreenDiff()):y(SCREEN_CENTER_Y+170*WideScreenDiff()):zoom(0.5*WideScreenDiff())
			else
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-199*WideScreenDiff() or SCREEN_CENTER_X+199*WideScreenDiff()):y(SCREEN_CENTER_Y+62*WideScreenDiff()):zoom(0.5*WideScreenDiff())
			end
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if isSurvival(player) then
				self:settext(SecondsToMSSMsMs(pss:GetSurvivalSeconds()-pss:GetLifeRemainingSeconds())) -- SURVIVAL
			elseif scoreType == 1 then
				output = math.round(pss:GetScore()*W0Percent)
				self:settextf("%09d",output) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(9-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(nil),
				})
				if isTopScreen("ScreenEvaluationWorkout") or isTopScreen("ScreenEvaluationCourseWorkout") then self:zoomx(1/2*WideScreenDiff()) else self:zoomx(8/9*WideScreenDiff()) end
			elseif scoreType == 2 then
				self:settext(FormatPercentScore(DP(player)*W0Percent)) -- PERCENT
			elseif scoreType == 3 then
				output = math.round(DPCur(player)*W0Percent)
				self:settextf("%04d",output) -- EX
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(4-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(nil),
				})
			elseif scoreType == 4 then
				local score = 0
                local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
				local w1 = stats:GetTapNoteScores('TapNoteScore_W1')
				local w2 = stats:GetTapNoteScores('TapNoteScore_W2')
				local w3 = stats:GetTapNoteScores('TapNoteScore_W3')
				local hd = stats:GetHoldNoteScores('HoldNoteScore_Held')
				local score = (w1 + w2 + w3 + hd) * 100000 / stepSize
				local sub = (w3*0.5) * 100000 / stepSize
				output = (math.floor((score-sub)) - ((w1 - W0Count) + w2 + w3))*10
				self:settextf("%07d",output) -- SN SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(7-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			elseif scoreType == 5 then
				self:settext(FormatPercentScore(math.max(0,getenv("WIFE3FA"..pname(player))))) -- WIFE3
			end
		end,
		OnCommand=function(self) self:addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()):sleep(3):decelerate(0.3):addx(player == PLAYER_1 and EvalTweenDistance() or -EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()) end
	}
}