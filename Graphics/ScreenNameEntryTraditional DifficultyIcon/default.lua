local Player = ...
if not Player then error("[ScreenNameEntryTraditional DifficultyIcon] needs player.") end

local DifficultyToFrame = {
	['Difficulty_Beginner']		= 0,
	['Difficulty_Easy']			= 1,
	['Difficulty_Medium']		= 2,
	['Difficulty_Hard']			= 3,
	['Difficulty_Challenge']	= 4,
	['Difficulty_Edit']			= 5
}

return LoadActor("DifficultyIcon")..{
	InitCommand=function(self) self:animate(false) end;
	ChangeDisplayedFeatMessageCommand=function(self,param)
		if param.Player == Player then
			if GAMESTATE:IsCourseMode() then
				local trail = GAMESTATE:GetCurrentTrail(Player)
				local difficulty = trail:GetDifficulty()
				self:setstate(DifficultyToFrame[difficulty])
			else
				local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
				local playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
				local playerSS = playedSS:GetPlayerStageStats(Player)
				local steps = playerSS:GetPlayedSteps()
				self:setstate(DifficultyToFrame[steps[1]:GetDifficulty()])
			end
		end
	end
}