return LoadFont("_r bold bevel numbers")..{
    InitCommand=function(self) self:x(SCREEN_CENTER_X+177+71):y(SCREEN_CENTER_Y-43) end;
    OnCommand=function(self) self:diffusealpha(1):shadowlength(2.5):zoom(.5):addx(SCREEN_WIDTH):decelerate(0.75):addx(-SCREEN_WIDTH) end;
    OffCommand=function(self) self:accelerate(0.75):addx(SCREEN_WIDTH) end;
    SetCommand=function(self)
		local curSelection = nil;
		local length = 0.0;
		if GAMESTATE:IsCourseMode() then
			curSelection = GAMESTATE:GetCurrentCourse();
			if curSelection then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber());
				if trail then
					length = TrailUtil.GetTotalSeconds(trail);
				else
					length = 0.0;
				end;
			else
				length = 0.0;
			end;
		else
			curSelection = GAMESTATE:GetCurrentSong();
			if curSelection then
				length = curSelection:MusicLengthSeconds();
			else
				length = 0.0;
			end;
		end;
		self:settext( SecondsToMMSSMsMs(length) );
	end;
	CurrentSongChangedMessageCommand=function(self) self:queuecommand("Set") end;
	CurrentCourseChangedMessageCommand=function(self) self:queuecommand("Set") end;
	CurrentTrailP1ChangedMessageCommand=function(self) self:queuecommand("Set") end;
	CurrentTrailP2ChangedMessageCommand=function(self) self:queuecommand("Set") end;
};