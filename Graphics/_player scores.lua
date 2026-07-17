local player = ...
assert(player,"[Graphics/_player scores] player required")
local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	InitCommand=function(self) if IsUsingWideScreen() and (hasAvatar(player) or hasSLAvatar(player)) then self:x(player == PLAYER_1 and 48 or -48) end end,
	ForceUpdateMessageCommand=function(self) self:playcommand("Init") end,
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
		local iidx = 0

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
				if not IsCourseFixed() then
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext("????")
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext("?.??%")
				elseif scores[1] then
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext(scores[1]:GetName())
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext(string.format("%0.2f%%",scores[1]:GetPercentDP()*100))
				else
					self:GetChild("MachineScore"):GetChild("ScoreName"):settext("N/A")
					self:GetChild("MachineScore"):GetChild("ScorePercent"):settext("0.00%")
				end

				local profilePlayer = PROFILEMAN:GetProfile(player)
				local hsl = profilePlayer:GetHighScoreList(SongOrCourse,StepsOrTrail)
				local scores = hsl and hsl:GetHighScores()
				if not IsCourseFixed() then
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext("?.??%")
				elseif scores[1] then
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext(string.format("%0.2f%%",scores[1]:GetPercentDP()*100))
				else
					self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext("0.00%")
				end
			end
			flare = GetFlare(player,SongOrCourse,StepsOrTrail)
			local songDir = courseMode and SongOrCourse:GetCourseDir() or SongOrCourse:GetSongDir()
			local arr = split("/",songDir)
			local difficulty = ToEnumShortString(StepsOrTrail:GetDifficulty())
			local identifier = StepsOrTrail.GetHash and StepsOrTrail:GetHash() or 0
			if identifier == 0 then identifier = StepsOrTrail:GetMeter() end
			songDir = arr[4].."/"..difficulty.."/"..identifier

			local category = isDouble() and StepsTypeDouble()[GetUserPrefN("StylePosition")] or StepsTypeSingle()[GetUserPrefN("StylePosition")]
			if IIDXClear[player][category] and IIDXClear[player][category][arr[3]] and IIDXClear[player][category][arr[3]][songDir] then
				iidx = IIDXClear[player][category][arr[3]][songDir] or ""
			end
		else
			self:GetChild("MachineScore"):GetChild("ScoreName"):settext("?")
			self:GetChild("MachineScore"):GetChild("ScorePercent"):settext("?")
			self:GetChild("ProfileScore"):GetChild("ScorePercent"):settext("?")
		end

		flare = split("_",flare)
		local flareLevel = tonumber(flare[1] or "0") or 0
		local flareScore = flare[2] or "???????"
		flares = {800000,850000,900000,930000,955000,960000,970000,980000,990000,995000,1000000}
		flareScore = tonumber(flareScore or 0)
		local flareFill = flareLevel > 0 and (flareScore-flares[flareLevel])/(flares[flareLevel+1]-flares[flareLevel]) or 0
		if flareLevel == 10 then
			self:GetChild("ProfileScore"):GetChild("ScoreName"):rainbow()
			self:GetChild("ProfileScore"):GetChild("FlareName"):settext("FX")
			self:GetChild("ProfileScore"):GetChild("Flare"):visible(true)
			self:GetChild("ProfileScore"):GetChild("FlareFill"):visible(true):stoptweening():decelerate(0.1):zoomx(math.min(flareFill,1)*13):stopeffect():rainbow():effectclock('beat')
		elseif flareLevel == 0 then
			self:GetChild("ProfileScore"):GetChild("ScoreName"):stopeffect():diffuse(color("FFFFFF"))
			self:GetChild("ProfileScore"):GetChild("FlareName"):settext("")
			self:GetChild("ProfileScore"):GetChild("Flare"):visible(false)
			self:GetChild("ProfileScore"):GetChild("FlareFill"):visible(false):stoptweening():decelerate(0.1):zoomx(0):stopeffect()
		else
			self:GetChild("ProfileScore"):GetChild("ScoreName"):stopeffect():diffuse(flareLevel > 0 and color(flareColor[flareLevel]) or color("#FFFFFF00"))
			self:GetChild("ProfileScore"):GetChild("FlareName"):settext("F"..flareLevel)
			self:GetChild("ProfileScore"):GetChild("Flare"):visible(true)
			self:GetChild("ProfileScore"):GetChild("FlareFill"):visible(true):stoptweening():decelerate(0.1):zoomx(math.min(flareFill,1)*13):stopeffect():diffuseramp():effectcolor1(ColorDarkTone(color(flareColor[flareLevel]))):effectcolor2(color(flareColor[flareLevel])):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
		end

		iidx = split("_",iidx)
		local iidxLevel = tonumber(iidx[1] or "0")
		local iidxFill = tonumber(iidx[2] or "0")
		local iidxLevels = {"VE","E","N","H","VH"}
		if iidxLevel == 0 then
			self:GetChild("ProfileScore"):GetChild("IIDXName"):settext("")
			self:GetChild("ProfileScore"):GetChild("IIDX"):visible(false)
			self:GetChild("ProfileScore"):GetChild("IIDXFill"):visible(false):stoptweening():decelerate(0.1):zoomx(0)
		else
			self:GetChild("ProfileScore"):GetChild("IIDXName"):settext(iidxLevels[iidxLevel])
			self:GetChild("ProfileScore"):GetChild("IIDX"):visible(true)
			local iidxColor = color("#00000000")
			if iidxLevel <= 3 then
				if iidxLevel == 1 and iidxFill >= 0.6 or iidxFill >= 0.8 then iidxColor = color("#FF0808") else iidxColor = color("#7BE8FF") end
			elseif iidxLevel == 4 then
				iidxColor = color("#FF0808")
			else
				iidxColor = color("#FFA959")
			end
			self:GetChild("ProfileScore"):GetChild("IIDXFill"):visible(true):stoptweening():decelerate(0.1):zoomx(math.min(iidxFill,1)*13):diffuseramp():effectcolor1(ColorDarkTone(iidxColor)):effectcolor2(iidxColor):effectperiod(0.5):effect_hold_at_full(0.5):effectclock('beat')
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
			OnCommand=function(self) self:x(self:GetParent():GetChild("ScoreName"):GetWidth()/3.4):y(85):rotationz(90):zoom(0.25):shadowlength(2):maxwidth(60) end
		},
		Def.BitmapText {
			File = "_z 36px shadowx",
			Name="IIDXName",
			OnCommand=function(self) self:x(-self:GetParent():GetChild("ScoreName"):GetWidth()/3.4):y(85):rotationz(-90):zoom(0.25):shadowlength(2):maxwidth(60) end
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
		},
		Def.Sprite {
			Name="Flare",
			Texture = THEME:GetPathG("_pane icons/_long",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(self:GetParent():GetChild("ScoreName"):GetWidth()/3.3+7):y(76.5):rotationz(90):halign(0):zoomx(2/3):shadowlength(1) end
		},
		Def.Quad{
			Name="FlareFill",
			InitCommand=function(self) self:x(self:GetParent():GetChild("ScoreName"):GetWidth()/3.3+7):y(91):rotationz(-90):halign(0):zoomto(13,4):blend(Blend.Add) end
		},
		Def.Sprite {
			Name="IIDX",
			Texture = THEME:GetPathG("_pane icons/_long",isFinal() and "final" or "normal"),
			InitCommand=function(self) self:x(-self:GetParent():GetChild("ScoreName"):GetWidth()/3.3-7):y(76.5):rotationz(90):halign(0):zoomx(2/3):shadowlength(1) end
		},
		Def.Quad{
			Name="IIDXFill",
			InitCommand=function(self) self:x(-self:GetParent():GetChild("ScoreName"):GetWidth()/3.3-7):y(91):rotationz(-90):halign(0):zoomto(13,4):blend(Blend.Add) end
		}
	}
}