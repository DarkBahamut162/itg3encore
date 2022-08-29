local player = ...
assert(player,"[Graphics/_player scores] player required")

return Def.ActorFrame{
	Def.ActorFrame{
		Name="MachineScore",
		InitCommand=function(self) self:x(-55) end,
		SetCommand=function(self)
			local name = self:GetChild("ScoreName")
			local score = self:GetChild("ScorePercent")
			local profile = PROFILEMAN:GetMachineProfile()
			local song = GAMESTATE:GetCurrentSong()
			local scoreText = "xxx"
			local nameText = "xxx"
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local hsl = profile:GetHighScoreList(song,steps)
					local scores = hsl and hsl:GetHighScores()
					if scores[1] then
						nameText = scores[1]:GetName()
						scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
					else
						nameText = "N/A"
						scoreText = "0.00%"
					end
				else
					nameText = "no"
					scoreText = "steps"
				end
			elseif GAMESTATE:IsCourseMode() then
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(player)
					if trail then
						local hsl = profile:GetHighScoreList(course,trail)
						local scores = hsl and hsl:GetHighScores()
						if scores[1] then
							nameText = scores[1]:GetName()
							scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
						else
							nameText = "N/A"
							scoreText = "0.00%"
						end
					else
						nameText = "NO" scoreText = "TRAIL"
					end
				else
					nameText = "CRS" scoreText = "-100%"
				end
			else
				nameText = "N/A" scoreText = "0.00%"
			end
			name:settext(nameText)
			score:settext(scoreText)
		end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end,
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end,
		CurrentTrailP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end,
		CurrentTrailP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end,
		LoadFont("_z 36px shadowx")..{
			Name="ScoreName",
			Text="MACH",
			InitCommand=function(self) self:y(85):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175) end,
			OnCommand=function(self) self:sleep(0.5):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		},
		LoadFont("_z 36px shadowx")..{
			Name="ScorePercent",
			Text="0.00%",
			InitCommand=function(self) self:y(100):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175):diffusebottomedge(color("#AAAAAA")) end,
			OnCommand=function(self) self:sleep(0.6):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		}
	},

	Def.ActorFrame{
		Name="ProfileScore",
		InitCommand=function(self) self:x(46) end,
		SetCommand=function(self)
			local name = self:GetChild("ScoreName")
			local score = self:GetChild("ScorePercent")
			local profile = PROFILEMAN:GetProfile(player)
			local song = GAMESTATE:GetCurrentSong()
			local scoreText = "xxx"
			local nameText = "YOU"
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local hsl = profile:GetHighScoreList(song,steps)
					local scores = hsl and hsl:GetHighScores()
					if scores[1] then
						scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
					else
						scoreText = "0.00%"
					end
				else
					scoreText = "steps"
				end
			elseif GAMESTATE:IsCourseMode() then
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(player)
					if trail then
						local hsl = profile:GetHighScoreList(course,trail)
						local scores = hsl and hsl:GetHighScores()
						if scores[1] then
							scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
						else
							scoreText = "0.00%"
						end
					else
						scoreText = "?"
					end
				else
					scoreText = "?"
				end
			else
				scoreText = "?"
			end
			name:settext(nameText)
			score:settext(scoreText)
		end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end,
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end,
		CurrentTrailP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end,
		CurrentTrailP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end,
		LoadFont("_z 36px shadowx")..{
			Name="ScoreName",
			Text="CARD",
			InitCommand=function(self) self:y(85):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175) end,
			OnCommand=function(self) self:sleep(0.85):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		},
		LoadFont("_z 36px shadowx")..{
			Name="ScorePercent",
			Text="0.00%",
			InitCommand=function(self) self:y(100):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175):diffusebottomedge(PlayerColor(player)) end,
			OnCommand=function(self) self:sleep(0.6):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		}
	}
}