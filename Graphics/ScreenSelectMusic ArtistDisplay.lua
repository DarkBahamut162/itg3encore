return Def.ActorFrame{
	LoadFont("_r bold shadow 30px")..{
		InitCommand=function(self) self:zoom(0.66):maxwidth(350):halign(0) end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self) 
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local text = ""
			if song then 
				text = song:GetDisplayArtist()
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
				if trail then
					local artists = trail:GetArtists()
					for i=1,#artists do
						if not string.find(text,artists[i]) then
							if i == 1 then
								text = artists[i]
							elseif i < #artists then
								text = text .. ", " .. artists[i]
							end
							if string.len(text) >= 60 then
								text = "Various Artists"
								break
							end
						end
					end
				else
					text = ""
				end
			end;
			self:settext(text)
		end;
	};
};