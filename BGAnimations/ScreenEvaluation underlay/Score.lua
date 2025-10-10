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
				local stepSize = 1
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
				self:settext(FormatPercentScore(math.max(0,getenv("WIFE3"..pname(player))))) -- WIFE3
			end
		end,
		OnCommand=function(self) self:addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()):sleep(3):decelerate(0.3):addx(player == PLAYER_1 and EvalTweenDistance() or -EvalTweenDistance()) end,
		OffCommand=function(self) self:accelerate(0.3):addx(player == PLAYER_1 and -EvalTweenDistance() or EvalTweenDistance()) end
	}
}