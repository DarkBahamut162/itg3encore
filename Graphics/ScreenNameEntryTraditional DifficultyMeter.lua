local Player = ...
if not Player then error("[ScreenNameEntryTraditional DifficultyMeter] needs player.") end

return LoadFont("_v 26px bold white")..{
	ChangeDisplayedFeatMessageCommand=function(self,param)
		if param.Player == Player then
			if GAMESTATE:IsCourseMode() then
				local trail = GAMESTATE:GetCurrentTrail(Player)
				local difficulty = ToEnumShortString(trail:GetDifficulty())
				self:settext(trail:GetDifficulty().." "..trail:GetMeter())
				self:diffuse(CustomDifficultyToColor(trail:GetDifficulty()))
				self:diffusetopedge(ContrastingDifficultyColor(trail:GetDifficulty()))
			else
				local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
				local playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
				local playerSS = playedSS:GetPlayerStageStats(Player)
				local steps = playerSS:GetPlayedSteps()
				local difficulty = ToEnumShortString(steps[1]:GetDifficulty())
				self:settext(difficulty.." "..steps[1]:GetMeter())
				self:diffuse(CustomDifficultyToColor(difficulty))
				self:diffusetopedge(ContrastingDifficultyColor(difficulty))
			end
		end
	end
}