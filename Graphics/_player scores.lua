local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()
local c

return Def.ActorFrame{
	InitCommand=function(self) c = self:GetChildren() if IsUsingWideScreen() and hasAvatar(player) then self:x(player == PLAYER_1 and 48 or -48) end end,
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
					c.MachineScore:GetChild("ScoreName"):settext("NEXT")
					local grade = scores:GetWifeGrade()
					if grade == "Grade_Failed" then grade = "Grade_Tier16" end
					c.MachineScore:GetChild("ScorePercent"):settext(FormatPercentScore(GetPercentFromGradeWife(string.format("Grade_Tier%02d",(tonumber(grade:sub(-2))-1)))))
					c.ProfileScore:GetChild("ScorePercent"):settext( string.format("%0.2f%%",scores:GetWifeScore()*100))
				else
					c.MachineScore:GetChild("ScoreName"):settext("NEXT")
					c.MachineScore:GetChild("ScorePercent"):settext(FormatPercentScore(GetPercentFromGradeWife("Grade_Tier15")))
					c.ProfileScore:GetChild("ScorePercent"):settext("0.00%")
				end
			else
				local profileMachine = PROFILEMAN:GetMachineProfile()
				local hsl = profileMachine:GetHighScoreList(SongOrCourse,StepsOrTrail)
				local scores = hsl and hsl:GetHighScores()
				if scores[1] then
					c.MachineScore:GetChild("ScoreName"):settext(scores[1]:GetName())
					c.MachineScore:GetChild("ScorePercent"):settext(string.format("%0.2f%%",scores[1]:GetPercentDP()*100))
				else
					c.MachineScore:GetChild("ScoreName"):settext("N/A")
					c.MachineScore:GetChild("ScorePercent"):settext("0.00%")
				end

				local profilePlayer = PROFILEMAN:GetProfile(player)
				local hsl = profilePlayer:GetHighScoreList(SongOrCourse,StepsOrTrail)
				local scores = hsl and hsl:GetHighScores()
				if scores[1] then
					c.ProfileScore:GetChild("ScorePercent"):settext(string.format("%0.2f%%",scores[1]:GetPercentDP()*100))
				else
					c.ProfileScore:GetChild("ScorePercent"):settext("0.00%")
				end
			end
			flare = GetFlare(player,SongOrCourse,StepsOrTrail)
		else
			c.MachineScore:GetChild("ScoreName"):settext("?")
			c.MachineScore:GetChild("ScorePercent"):settext("?")
			c.ProfileScore:GetChild("ScorePercent"):settext("?")
		end
		if flare == 10 then
			c.ProfileScore:GetChild("ScoreName"):rainbow()
			c.ProfileScore:GetChild("FlareName"):settext("FX")
		elseif flare == 0 then
			c.ProfileScore:GetChild("ScoreName"):stopeffect():diffuse(color("#fff"))
			c.ProfileScore:GetChild("FlareName"):settext("")
		else
			c.ProfileScore:GetChild("ScoreName"):stopeffect():diffuse(color(flareColor[flare]))
			c.ProfileScore:GetChild("FlareName"):settext("F"..flare)
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
			InitCommand=function(self) self:x(32):y(85):rotationz(90):zoom(0.25):shadowlength(2):maxwidth(175) end
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