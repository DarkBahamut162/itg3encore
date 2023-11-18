local player = ...
assert(player,"[Graphics/_player scores] player required")

return Def.ActorFrame{
	InitCommand=function(self) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end end,
	Def.ActorFrame{
		Name="MachineScore",
		InitCommand=function(self) self:x(-55) end,
		SetCommand=function(self)
			local name = self:GetChild("ScoreName")
			local score = self:GetChild("ScorePercent")
			local profile = PROFILEMAN:GetMachineProfile()
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepOrTrails = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			local scoreText = "?"
			local nameText = "?"

			if SongOrCourse and StepOrTrails then
				local hsl = profile:GetHighScoreList(SongOrCourse,StepOrTrails)
				local scores = hsl and hsl:GetHighScores()
				if scores[1] then
					nameText = scores[1]:GetName()
					scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
				else
					nameText = "N/A"
					scoreText = "0.00%"
				end
			else
				nameText = "?"
				scoreText = "?"
			end

			name:settext(nameText)
			score:settext(scoreText)
		end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
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
			local SongOrCourse = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepOrTrails = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			local scoreText = "?"
			local nameText = "YOU"

			if SongOrCourse and StepOrTrails then
				local hsl = profile:GetHighScoreList(SongOrCourse,StepOrTrails)
				local scores = hsl and hsl:GetHighScores()
				if scores[1] then
					scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
				else
					scoreText = "0.00%"
				end
			end
			name:settext(nameText)
			score:settext(scoreText)
		end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
		["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) self:playcommand("Set") end,
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