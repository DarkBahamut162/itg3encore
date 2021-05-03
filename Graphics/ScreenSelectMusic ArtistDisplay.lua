return Def.ActorFrame{
	LoadFont("_r bold shadow 30px")..{
		InitCommand=cmd(zoom,0.66;maxwidth,360;halign,0);
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self) 
			local song = GAMESTATE:GetCurrentSong(); 
			local course = GAMESTATE:GetCurrentCourse()
			local text = ""
			if song then 
				text = song:GetDisplayArtist();
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
				if trail then
					local artists = trail:GetArtists()
					for i=1,#artists do
						text = text .." ".. artists[i]
						if i < #artists then
							text = text ..","
						end
					end
				else
					text = ""
				end
			end;
			self:settext(text);
		end;
	};
};