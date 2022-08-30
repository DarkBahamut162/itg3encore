return Def.ActorFrame{
	Def.Banner{
		InitCommand=function(self) self:ztest(true):scaletoclipped(174,68) end,
		ChangeDisplayedFeatMessageCommand=function(self,param)
			if GAMESTATE:IsCourseMode() then
				self:LoadFromCourse(GAMESTATE:GetCurrentCourse())
			else
				local stagesAgo = (STATSMAN:GetStagesPlayed() - (param.NewIndex-1))
				local playedSS = STATSMAN:GetPlayedStageStats(stagesAgo)
				local songs = playedSS:GetPlayedSongs()
				self:LoadFromSong(songs[1])
			end
		end
	},
	LoadActor(THEME:GetPathG("ScreenEvaluation","BannerFrame"))
}