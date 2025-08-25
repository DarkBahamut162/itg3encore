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
				self:settext(FormatPercentScore(math.max(0,getenv("WIFE3FA"..pname(player))))) -- WIFE3
			end
		end,
		OnCommand=function(self) self:addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()):sleep(3):decelerate(0.3):addx(player == PLAYER_1 and EvalTweenDistance() or -EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()) end
	}
}