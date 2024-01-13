local course = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	LoadFont("_v 26px bold white")..{
		Text="ARTIST:",
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()):halign(0) end
	},
	LoadFont("_r bold shadow 30px")..{
		InitCommand=function(self) self:zoom(0.66*WideScreenDiff()):maxwidth(340):halign(0) end,
		CurrentSongChangedMessageCommand=function(self) if not course then self:playcommand("Set") end end,
		CurrentCourseChangedMessageCommand=function(self) if course then self:playcommand("Set") end end,
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local output = ""
			if song then
				output = song:GetDisplayArtist()
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
				if trail then
					local artists = trail:GetArtists()
					for i=1,#artists do
						if not string.find(output,artists[i]) then
							output = addToOutput(output,artists[i],", ")
							if string.len(output) >= 60 then
								output = "Various Artists"
								break
							end
						end
					end
				end
			end
			self:settext(output)
		end
	}
}