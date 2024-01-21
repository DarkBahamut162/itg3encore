local courseMode = GAMESTATE:IsCourseMode()

return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		InitCommand=function(self) self:halign(0):diffuseramp():effectperiod(1):effectoffset(0.2):effectclock("beat"):effectcolor1(color("#693A3A")):effectcolor2(color("#FF0000")) end,
		CurrentSongChangedMessageCommand=function(self) if not courseMode then self:playcommand("Blink") end end,
		CurrentStepsP1ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		CurrentStepsP2ChangedMessageCommand=function(self) if not courseMode then self:playcommand("Set") end end,
		SetCommand=function(self)
			local curSelection = nil
			local output = ""
			if not GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentSong()
				if curSelection then
					curStep = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
					--[[ Automate my video timestamping this way... Work smarter not harder... ]]--
					--lua.ReportScriptError( curSelection:GetGroupName().." | "..curSelection:GetDisplayFullTitle().." / "..curSelection:GetDisplayArtist() )
					if curStep then
						if ThemePrefs.Get("ShowCalcDiff") then --Calculate Difficulty
							local totalSeconds = isOutFox() and tonumber(LoadFromCache(curSelection,curStep,"TrueSeconds")) or (curSelection:GetLastSecond() - curSelection:GetFirstSecond())
							local stepCounter = isOutFox() and split("_",LoadFromCache(curSelection,curStep,"StepCounter"))
							local stepType = split("_",curStep:GetStepsType())
							local stepSum = isOutFox() and 0 or math.round(curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * getColumnsPerPlayer(stepType[2],stepType[3],true) / 2)
							if isOutFox() then
								for i=1,#stepCounter do if stepCounter[i] then stepSum = stepSum + (stepCounter[i] * i) end end
								if IsGame("be-mu") then
									stepSum = math.round( ( stepSum / totalSeconds ) )
								else
									stepSum = math.round( ( stepSum / totalSeconds ) * (getColumnsPerPlayer(stepType[2],stepType[3],true)/2) )
								end
							end
							output = addToOutput(output,"Calc'd Difficulty (DB9): "..stepSum,"\n")
							if IsGame("be-mu") then
								output = addToOutput(output,"Calc'd Difficulty (Y&A): "..math.round(GetConvertDifficulty(curSelection,curStep,totalSeconds)/2),"\n")
								if isOutFox() then output = addToOutput(output,"Calc'd Difficulty (SPS): "..math.round(tonumber(LoadFromCache(curSelection,curStep,"StepsPerSecond"))/2),"\n") end
							else
								output = addToOutput(output,"Calc'd Difficulty (Y&A): "..math.round(GetConvertDifficulty(curSelection,curStep,totalSeconds)*getColumnsPerPlayer(stepType[2],stepType[3],true)/4),"\n")
								if isOutFox() then output = addToOutput(output,"Calc'd Difficulty (SPS): "..math.round(tonumber(LoadFromCache(curSelection,curStep,"StepsPerSecond"))*getColumnsPerPlayer(stepType[2],stepType[3],true)/4),"\n") end
							end
						end
					end
				end
			end
			self:settext(output):valign(1)
		end,
		BlinkCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				local spmp = song:GetPreviewMusicPath()
				local effectclock = spmp ~= "" and "beat" or "timerglobal"
				self:effectclock(effectclock)
			else
				self:effectclock("beat"):settext("")
			end
		end
	}
}