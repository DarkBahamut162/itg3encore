local player = ...
assert( player )

return Def.BitmapText{
	Font= "_r bold 30px",
	Name="RemainingTime",
	Text="",
	InitCommand=function(self)
		self:valign(1):halign(1)
		self:zoom(0.5):x( _screen.cx - _screen.w/8 + 60 ):y(80 - 7.5)
		if player == PLAYER_2 then
			self:x( _screen.cx + _screen.w/3.4 + 60 )
		end
		self:shadowlength(1):skewx(-0.125)
	end,
	CurrentSongChangedMessageCommand=function(self)
		local gainSeconds = GAMESTATE:GetCurrentCourse(player):GetCourseEntry(GAMESTATE:GetCourseSongIndex()):GetGainSeconds()
		self:stoptweening():diffuseshift():diffusealpha(1):zoom(0.75):linear(0.3):zoom(0.6):sleep(3):linear(0.5):diffusealpha(0)
		self:settextf("%+1.1fs", gainSeconds)
	end;
	JudgmentMessageCommand=function(self,params)
		if params.Player == player then
			if params.HoldNoteScore then
			elseif params.TapNoteScore then
				local tns = ToEnumShortString(params.TapNoteScore)
				local prefname= ("TimeMeterSecondsChange%s"):format(tns)
				if PREFSMAN:PreferenceExists(prefname) then
					self:stoptweening():stopeffect():diffusealpha(1):zoom(0.75):linear(0.3):zoom(0.6):sleep(1):diffusealpha(0)
					self:playcommand( "GainSeconds" )
					self:playcommand( tns )
					self:settextf( "%+1.1fs", PREFSMAN:GetPreference(prefname) )
				end
			else
				return
			end
		else
			return
		end
	end
}