local stageRemap = {
	Stage_1st	= 1, Stage_2nd	= 2, Stage_3rd	= 3,
	Stage_4th	= 4, Stage_5th	= 5, Stage_6th	= 6
}

return Def.ActorFrame{
	Def.Sprite{
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self)
			local curStage = GAMESTATE:GetCurrentStage()

			if GAMESTATE:IsCourseMode() then
				if GAMESTATE:GetCourseSongIndex()+1 <= 5 then
					self:Load(THEME:GetPathG("_gameplay","course song " .. GAMESTATE:GetCourseSongIndex()+1))
				end
				-- xxx: needs to handle course mode (song 1, song 2, etc.)
				-- and how to handle courses with more than 5 songs?
			else
				local songsPerPlay = PREFSMAN:GetPreference("SongsPerPlay")
				if stageRemap[curStage] == songsPerPlay then
					curStage = 'Stage_Final'
				end
				if GAMESTATE:IsEventMode() then curStage = 'Stage_Event' end

				curStage = ToEnumShortString(curStage)
				self:Load(THEME:GetPathG("_gameplay","stage "..curStage))
			end
		end;
	};
};