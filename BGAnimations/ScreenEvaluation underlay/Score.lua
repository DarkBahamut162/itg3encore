local player = ...
local scoreType = getenv("SetScoreType"..ToEnumShortString(player))
return Def.ActorFrame{
	LoadFont("_r bold numbers") .. {
		Name="Score"..ToEnumShortString(player),
		InitCommand=function(self)
			self:diffuse(PlayerColor(player))
			if isTopScreen("ScreenEvaluationWorkout") or isTopScreen("ScreenEvaluationCourseWorkout") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-56 or SCREEN_CENTER_X+56):y(SCREEN_CENTER_Y+86):zoom(1/3*2)
			elseif isTopScreen("ScreenEvaluationRave") then
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-199 or SCREEN_CENTER_X+199):y(SCREEN_CENTER_Y+175)
			else
				self:x(player == PLAYER_1 and SCREEN_CENTER_X-199 or SCREEN_CENTER_X+199):y(SCREEN_CENTER_Y+52)
			end
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local output = 0
			if scoreType == 1 then
				output = pss:GetScore()
				self:settextf("%09d",output) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(9-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
				self:settextf("%09d",0) -- SCORE
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(8, 0),
					Diffuse = PlayerColorSemi(player),
				}):zoomx(0.9)
			elseif scoreType == 2 then
				self:settext(FormatPercentScore(pss:GetPercentDancePoints())) -- PERCENT
			elseif scoreType == 3 then
				output = pss:GetActualDancePoints()
				self:settextf("%04d",output) -- EX
				self:ClearAttributes()
				self:AddAttribute(0, {
					Length = math.max(4-string.len(''..output), 0),
					Diffuse = PlayerColorSemi(player),
				})
			end
		end,
		OnCommand=function(self) self:addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()):sleep(3):decelerate(0.3):addx(player == PLAYER_1 and EvalTweenDistance() or -EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()) end
	}
}