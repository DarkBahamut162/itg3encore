return LoadFont("_r bold bevel numbers")..{
	SetCommand=function(self)
		local curSelection = nil;
		local length = 0.0;
		if GAMESTATE:IsCourseMode() then
			curSelection = GAMESTATE:GetCurrentCourse()
			if curSelection then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
				if trail then
					length = TrailUtil.GetTotalSeconds(trail)
				end;
			end;
		else
			curSelection = GAMESTATE:GetCurrentSong()
			if curSelection then
				length = curSelection:MusicLengthSeconds()
			end;
		end;
		self:settext( SecondsToMMSSMsMs(length) )
	end;
	CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end;
	CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end;
	CurrentTrailP1ChangedMessageCommand=function(self) self:queuecommand("Set") end;
	CurrentTrailP2ChangedMessageCommand=function(self) self:queuecommand("Set") end;
};