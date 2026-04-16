local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	InitCommand=function(self) if IsUsingWideScreen() and (hasAvatar(player) or hasSLAvatar(player)) then self:x(player == PLAYER_1 and 48 or -48) end end,
	OnCommand=function(self) self:addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH):decelerate(0.75):addx(player == PLAYER_2 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	OffCommand=function(self) self:accelerate(0.75):addx(player == PLAYER_1 and -SCREEN_WIDTH or SCREEN_WIDTH) end,
	CurrentSongChangedMessageCommand=function(self) if not courseMode then self:queuecommand("Set") end end,
	CurrentCourseChangedMessageCommand=function(self) if courseMode then self:queuecommand("Set") end end,
	["CurrentSteps".. pname(player) .."ChangedMessageCommand"]=function(self) if not courseMode then self:queuecommand("Set") end end,
	CurrentStepsChangedMessageCommand=function(self) if not courseMode then self:queuecommand("Set") end end,
	["CurrentTrail".. pname(player) .."ChangedMessageCommand"]=function(self) if courseMode then self:queuecommand("Set") end end,
	SetCommand=function(self)
		local SongOrCourse = courseMode and GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong()
		local StepsOrTrail = courseMode and GAMESTATE:GetCurrentTrail(player) or GAMESTATE:GetCurrentSteps(player)
		local flare = 0

		if SongOrCourse and StepsOrTrail then
			if isEtterna("0.50") then
				local scores = GetDisplayScore()
				if scores then
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext("NEXT")
					local grade = scores:GetWifeGrade()
					if grade == "Grade_Failed" then grade = "Grade_Tier16" end
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext(FormatPercentScore(GetPercentFromGradeWife(string.format("Grade_Tier%02d",(tonumber(grade:sub(-2))-1)))))
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext( string.format("%0.2f%%",scores:GetWifeScore()*100))
				else
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext("NEXT")
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext(FormatPercentScore(GetPercentFromGradeWife("Grade_Tier15")))
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext("0.00%")
				end
			else
				local profileMachine = PROFILEMAN:GetMachineProfile()
				local hsl = profileMachine:GetHighScoreList(SongOrCourse,StepsOrTrail)
				local scores = hsl and hsl:GetHighScores()
				if scores[1] then
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext(scores[1]:GetName())
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext(string.format("%0.2f%%",scores[1]:GetPercentDP()*100))
				else
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext("N/A")
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext("0.00%")
				end

				local profilePlayer = PROFILEMAN:GetProfile(player)
				local hsl = profilePlayer:GetHighScoreList(SongOrCourse,StepsOrTrail)
				local scores = hsl and hsl:GetHighScores()
				if scores[1] then
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext(string.format("%0.2f%%",scores[1]:GetPercentDP()*100))
				else
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext("0.00%")
				end
			end
			flare = GetFlare(player,SongOrCourse,StepsOrTrail)
		else
			self:GetChild("MachineScore"):GetChild("ScoreName"):settext("?")
			self:GetChild("MachineScore"):GetChild("ScorePercent"):settext("?")
			self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext("?")
		end
		if flare == 10 then
			self:GetChild("ProfileScore"):GetChild("ScoreName"):rainbow()
			self:GetChild("ProfileScore"):GetChild("FlareName"):settext("FX")
		elseif flare == 0 then
			self:GetChild("ProfileScore"):GetChild("ScoreName"):stopeffect():diffuse(color("#fff"))
			self:GetChild("ProfileScore"):GetChild("FlareName"):settext("")
		else
			self:GetChild("ProfileScore"):GetChild("ScoreName"):stopeffect():diffuse(color(flareColor[flare]))
			self:GetChild("ProfileScore"):GetChild("FlareName"):settext("F"..flare)
		end
	end,
	Def.ActorFrame{
		Name="MachineScore",
		InitCommand=function(self) self:x(-55) end,
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScoreName",
			Text="MACH",
			InitCommand=function(self) self:y(85):zoom(0.55):shadowlength(2):maxwidth(175) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScorePercent",
			Text="0.00%",
			InitCommand=function(self) self:y(100):zoom(0.55):shadowlength(2):maxwidth(175):diffusebottomedge(color("#AAAAAA")) end
		}
	},

	Def.ActorFrame{
		Name="ProfileScore",
		InitCommand=function(self) self:x(46) end,
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="FlareName",
			OnCommand=function(self) self:x(self:GetParent():GetChild("ScoreName"):GetWidth()/3.3):y(85):rotationz(90):zoom(0.25):shadowlength(2):maxwidth(175) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScoreName",
			Text=HumanAndUSBReady(player) and "CARD" or "YOU",
			InitCommand=function(self) self:y(85):zoom(0.55):shadowlength(2):maxwidth(175) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="ScorePercent",
			Text="0.00%",
			InitCommand=function(self) self:y(100):zoom(0.55):shadowlength(2):maxwidth(175):diffusebottomedge(PlayerColor(player)) end
		}
	}
}