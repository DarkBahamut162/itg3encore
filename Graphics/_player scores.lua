local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	InitCommand=function(self) if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:queuecommand("Set") end ) end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:queuecommand("Set") end )  end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:queuecommand("Set") end )  end end,
	CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:RunCommandsRecursively( function(self) self:queuecommand("Set") end )  end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:RunCommandsRecursively( function(self) self:queuecommand("Set") end )  end end,
	Def.ActorFrame{
		Name="MachineScore",
		InitCommand=function(self) self:x(-55) end,
		SetCommand=function(self)
			local name = self:GetChild("ScoreName")
			local score = self:GetChild("ScorePercent")
			local profile = PROFILEMAN:GetMachineProfile()
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			local scoreText = "?"
			local nameText = "?"

			if SongOrCourse and StepsOrTrail then
				if isEtterna() then
					local scores = GetDisplayScore()
					if scores then
						nameText = "NEXT"
						local grade = scores:GetWifeGrade()
						if grade == "Grade_Failed" then grade = "Grade_Tier16" end
						scoreText = FormatPercentScore(GetPercentFromGradeWife(string.format("Grade_Tier%02d",(tonumber(grade:sub(-2))-1))))
					else
						nameText = "NEXT"
						scoreText = FormatPercentScore(GetPercentFromGradeWife("Grade_Tier15"))
					end
				else
					local hsl = profile:GetHighScoreList(SongOrCourse,StepsOrTrail)
					local scores = hsl and hsl:GetHighScores()
					if scores[1] then
						nameText = scores[1]:GetName()
						scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
					else
						nameText = "N/A"
						scoreText = "0.00%"
					end
				end
			else
				nameText = "?"
				scoreText = "?"
			end

			name:settext(nameText)
			score:settext(scoreText)
		end,
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScoreName",
			Text="MACH",
			InitCommand=function(self) self:y(85):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175) end,
			OnCommand=function(self) self:sleep(0.5):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
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
			local f = self:GetChild("FlareName")
			local profile = PROFILEMAN:GetProfile(player)
			local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
			local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
			local scoreText = "?"
			local nameText = "YOU"
			local flare = 0

			if SongOrCourse and StepsOrTrail then
				if isEtterna() then
					local scores = GetDisplayScore()
					if scores then
						scoreText = string.format("%0.2f%%",scores:GetWifeScore()*100)
					else
						scoreText = "0.00%"
					end
				else
					local hsl = profile:GetHighScoreList(SongOrCourse,StepsOrTrail)
					local scores = hsl and hsl:GetHighScores()
					if scores[1] then
						scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
					else
						scoreText = "0.00%"
					end
				end
				flare = GetFlare(player,SongOrCourse,StepsOrTrail)
			end
			name:settext(nameText)
			score:settext(scoreText)
			if flare == 10 then
				name:rainbow()
				f:settext("FX")
			elseif flare == 0 then
				name:stopeffect():diffuse(color("#fff"))
				f:settext("")
			else
				name:stopeffect():diffuse(color(flareColor[flare]))
				f:settext("F"..flare)
			end
		end,
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="FlareName",
			Text="FX",
			InitCommand=function(self) self:x(32):y(85):rotationz(90):diffusealpha(0):zoom(0.25):shadowlength(2):maxwidth(175) end,
			OnCommand=function(self) self:sleep(0.85):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end,
			SetCommand=function(self)
				local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
				local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
				local flare = 0

				if SongOrCourse and StepsOrTrail then flare = GetFlare(player,SongOrCourse,StepsOrTrail) end
				if flare == 10 then
					self:settext("FX")
				elseif flare == 0 then
					self:settext("")
				else
					self:settext("F"..flare)
				end
			end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScoreName",
			Text="CARD",
			InitCommand=function(self) self:y(85):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175) end,
			OnCommand=function(self) self:sleep(0.85):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScorePercent",
			Text="0.00%",
			InitCommand=function(self) self:y(100):diffusealpha(0):zoom(0.55):shadowlength(2):maxwidth(175):diffusebottomedge(PlayerColor(player)) end,
			OnCommand=function(self) self:sleep(0.6):linear(0.2):diffusealpha(1) end,
			OffCommand=function(self) self:linear(0.4):diffusealpha(0) end
		}
	}
}