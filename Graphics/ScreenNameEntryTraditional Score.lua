local Player = ...
if not Player then error("[ScreenNameEntryTraditional Score] score needs player badly") end

local machineProfile = PROFILEMAN:GetMachineProfile()

-- xxx: this is a PercentageDisplay in the hardcoded version
return LoadFont("_r bold numbers")..{
	BeginCommand=cmd(diffuse,PlayerColor(Player)),
	ChangeDisplayedFeatMessageCommand=function(self,param)
		if param.Player == Player then
			local playedSS,playerSS
			if GAMESTATE:IsCourseMode() then
				playedSS = STATSMAN:GetPlayedStageStats(1)
				playerSS = playedSS:GetPlayerStageStats(Player)
				self:settext(FormatPercentScore(playerSS:GetPercentDancePoints()))
			else
				local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
				playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
				playerSS = playedSS:GetPlayerStageStats(Player)
				self:settext(FormatPercentScore(playerSS:GetPercentDancePoints()))
			end
		end
	end,
}
