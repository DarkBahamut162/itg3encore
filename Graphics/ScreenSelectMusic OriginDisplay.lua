local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	InitCommand = function(self) c = self:GetChildren() end,
	Def.BitmapText {
		File = "_v 26px bold white",
		Name="FROM",
		Text="FROM:",
		InitCommand=function(self) self:shadowlength(2.5):zoom(0.5*WideScreenDiff()):y(-17.5*WideScreenDiff()):halign(0) end
	},
	Def.BitmapText {
		File = "_r bold shadow 30px",
		InitCommand=function(self) self:zoom(0.66*WideScreenDiff()):maxwidth(340):halign(0) end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then self:queuecommand("Set") end end,
		CurrentCourseChangedMessageCommand=function(self) if courseMode then self:queuecommand("Set") end end,
		SetCommand=function(self)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local output = ""
			if not courseMode then
				if SongOrCourse then output = GetSMParameter(SongOrCourse,"ORIGIN") end
			end
			if output == "" then
				if courseMode then
					if SongOrCourse then
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
				else
					if SongOrCourse then output = SongOrCourse:GetDisplayArtist() end
				end
				c.FROM:settext("ARTIST:")
			else
				c.FROM:settext("FROM:")
			end
			self:settext(output)
		end
	}
}