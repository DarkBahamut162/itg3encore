-- STATSMAN:GetStagesPlayed()

return Def.ActorFrame{
	-- banner, which is meant to fade between multiple banners... great.
	Def.Banner{
		InitCommand=function(self) self:ztest(true):scaletoclipped(174,68) end;

		ChangeDisplayedFeatMessageCommand=function(self,param)
			if GAMESTATE:IsCourseMode() then
				self:LoadFromCourse(GAMESTATE:GetCurrentCourse())
			else
				local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
				local playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
				local songs = playedSS:GetPlayedSongs()
				self:LoadFromSong(songs[1])
			end
		end,
	},

	-- banner frame, no big deal.
	LoadActor("banner frame")
}