return Def.ActorFrame{
	Def.Banner{
		InitCommand=function(self) self:ztest(true):scaletoclipped((isFinal() and 170 or 174)*WideScreenDiff(),(isFinal() and 64 or 68)*WideScreenDiff()) end,
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
	loadfile(THEME:GetPathG("ScreenEvaluation","BannerFrame"))()
}