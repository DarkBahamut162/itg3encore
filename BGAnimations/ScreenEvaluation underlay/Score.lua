local player = ...
local scoreType = getenv("SetScoreType"..pname(GAMESTATE:IsHumanPlayer(player) and player or OtherPlayer[player]))
return Def.ActorFrame{
	Def.BitmapText {
		File = "_r bold numbers",
		Name="Score"..pname(player),
		InitCommand=function(self)
			self:diffuse(PlayerColor(player))
			if isTopScreen("ScreenEvaluationWorkout") or isTopScreen("ScreenEvaluationCourseWorkout") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-58*WideScreenDiff() or SCREEN_CENTER_X+58*WideScreenDiff()):y(SCREEN_CENTER_Y+92*WideScreenDiff()):zoom(2/3*WideScreenDiff())
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
				self:settext(FormatPercentScore(math.max(0,getenv("WIFE3"..pname(player))))) -- WIFE3
			end
		end,
		OnCommand=function(self) self:addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()):sleep(3):decelerate(0.3):addx(player == PLAYER_1 and EvalTweenDistance() or -EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()) end
	}
}