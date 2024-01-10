return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		InitCommand=function(self) self:halign(0):diffuseramp():effectperiod(1):effectoffset(0.2):effectclock("beat"):effectcolor1(color("#693A3A")):effectcolor2(color("#FF0000")) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Blink") end,
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local curSelection = nil
			local output = ""
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse()
				if curSelection then
					if curSelection:HasMods() or curSelection:HasTimedMods() then
						output = addToOutput(output,"HAS MODS","\n")
					end
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							if entries[i]:GetNormalModifiers() ~= "" then
								output = addToOutput(output,"HAS SONG MODS","\n")
								break
							end
						end
					end
				end
			else
				curSelection = GAMESTATE:GetCurrentSong()
				curStep = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
				if curSelection then
					--[[ Automate my video timestamping this way... Work smarter not harder... ]]--
					--lua.ReportScriptError( curSelection:GetGroupName().." | "..curSelection:GetDisplayFullTitle().." / "..curSelection:GetDisplayArtist() )
					if curStep then

						local Cache = isOutFox() and split("\n",LoadModule("Config.LoadEverything.lua")(getStepCacheFile(curStep))) or {}
						local CacheLoaded = {}

						for i=1,#Cache do
							Cache[i] = split("=",Cache[i])
							CacheLoaded[Cache[i][1]] = Cache[i][2]
						end

						if ThemePrefs.Get("ShowTrueBPMs") then -- Get true BPM range
							local bpms = {}
							if isOutFox() then
								local truebpms = curStep:GetTimingData():GetActualBPM()
								bpms[1]=math.round(truebpms[1])
								bpms[2]=math.round(truebpms[2])
								bpms[3]=math.round(tonumber(CacheLoaded["TrueMaxBPM"]))
							else
								bpms = getTrueBPMs(curSelection,curStep)
							end
							if bpms[1] == bpms[2] and bpms[2] == bpms[3] then
								output = addToOutput(output,"BPM: "..bpms[1],"\n")
							elseif bpms[3] == bpms[1] or bpms[3] == 0 then
								if bpms[1] ~= bpms[2] then
									output = addToOutput(output,"BPM: "..bpms[1] .. " (" .. bpms[2] .. ")","\n")
								else
									output = addToOutput(output,"BPM: "..bpms[1],"\n")
								end
							elseif bpms[3] < bpms[2] then
								output = addToOutput(output,"BPM: "..bpms[1] .. " - " .. bpms[3] .. " (" .. bpms[2] .. ")","\n")
							else
								output = addToOutput(output,"BPM: "..bpms[1] .. " - " .. bpms[2],"\n")
							end
						end
						if ThemePrefs.Get("ShowCalcDiff") then --Calculate Difficulty
							local totalSeconds = isOutFox() and tonumber(CacheLoaded["TrueSeconds"]) or (curSelection:GetLastSecond() - curSelection:GetFirstSecond())
							local stepCounter = isOutFox() and split("_",CacheLoaded["StepCounter"])
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
								if isOutFox() then output = addToOutput(output,"Calc'd Difficulty (SPS): "..math.round(tonumber(CacheLoaded["StepsPerSecond"])/2),"\n") end
							else
								output = addToOutput(output,"Calc'd Difficulty (Y&A): "..math.round(GetConvertDifficulty(curSelection,curStep,totalSeconds)*getColumnsPerPlayer(stepType[2],stepType[3],true)/4),"\n")
								if isOutFox() then output = addToOutput(output,"Calc'd Difficulty (SPS): "..math.round(tonumber(CacheLoaded["StepsPerSecond"])*getColumnsPerPlayer(stepType[2],stepType[3],true)/4),"\n") end
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