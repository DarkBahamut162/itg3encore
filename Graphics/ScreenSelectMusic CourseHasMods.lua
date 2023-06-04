return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		InitCommand=function(self) self:halign(0) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end,
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
					if curStep then
						if ThemePrefs.Get("ShowHasLua") then -- load cache HasLua
							if isOutFox() then
								if tobool(LoadFromCache(curSelection,curStep,"HasLua")) then output = addToOutput(output,"HAS LUA","\n") end
							else
								if HasLuaCheck() then output = addToOutput(output,"HAS LUA","\n") end
							end
						end
						if ThemePrefs.Get("ShowStepCounter") and isOutFox() then -- load cache StepCounter
							output = addToOutput(output,table.concat(getStepCounter(curSelection,curStep),"|"),"\n")
						end
						if ThemePrefs.Get("ShowTrueBPMs") then -- Get true BPM range
							local timingdata = curStep:GetTimingData()
							local bpms = curStep:GetDisplayBpms()
							local truebpms = timingdata:GetActualBPM()

							bpms[1] = math.round(bpms[1] * 1000) / 1000
							bpms[2] = math.round(bpms[2] * 1000) / 1000
							truebpms[1] = math.round(truebpms[1] * 1000) / 1000
							truebpms[2] = math.round(truebpms[2] * 1000) / 1000

							for i=1,2 do
								if bpms[i] then if math.abs(1-bpms[i]/math.round(bpms[i])) < 0.005 then bpms[i] = math.round(bpms[i]) end end
								if truebpms[i] then if math.abs(1-truebpms[i]/math.round(truebpms[i])) < 0.005 then truebpms[i] = math.round(truebpms[i]) end end
							end

							if bpms[1] == truebpms[1] and bpms[2] == truebpms[2] and bpms[1] == bpms[2] then
								output = addToOutput(output,"BPM: "..truebpms[1],"\n")
							else
								local sets = timingdata:GetBPMsAndTimes()
								local currentSet, lastSet
								local BPMs, duration, lastDuration = {}, 0, 0
								local fastestBPM, fastestBPM_backup = 0, 0

								for i, set in ipairs(sets) do
									currentSet = split("=",set)
									currentSet[2]=math.round(currentSet[2] * 1000 / 1000)

									if lastSet then
										duration = (currentSet[1]-lastSet[1]) / lastSet[2] * 60
										if BPMs[lastSet[2]] then
											BPMs[lastSet[2]] = BPMs[lastSet[2]] + duration
										else
											BPMs[lastSet[2]] = duration
										end
										if math.abs(1-lastSet[2]/currentSet[2]) <= 0.02 then
											duration = duration + lastDuration
											if truebpms[1] <= currentSet[2] and truebpms[2] >= currentSet[2] then
												if fastestBPM < currentSet[2] then fastestBPM = currentSet[2] end
											end
										end
										if duration >= 6 then
											if truebpms[1] <= lastSet[2] and truebpms[2] >= lastSet[2] then
												if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
											end
											if truebpms[1] <= currentSet[2] and truebpms[2] >= currentSet[2] then
												if math.abs(1-lastSet[2]/currentSet[2]) <= 0.02 then
													if fastestBPM < currentSet[2] then fastestBPM = currentSet[2] end
												end
											end
										end
									end
									lastSet, lastDuration = currentSet, duration
								end

								duration = (curSelection:GetLastBeat()-lastSet[1]) / lastSet[2] * 60
								if BPMs[lastSet[2]] then
									BPMs[lastSet[2]] = BPMs[lastSet[2]] + duration
								else
									BPMs[lastSet[2]] = duration
								end
								if duration >= 4 then
									if truebpms[1] <= lastSet[2] and truebpms[2] >= lastSet[2] then
										if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
									end
								end
								if math.abs(1-fastestBPM/truebpms[2]) <= 0.04 then fastestBPM = truebpms[2] end
								--[[
								local function pairsByKeys (t, f)
									local a = {}
									for n in pairs(t) do table.insert(a, n) end
									table.sort(a, f)
									local i = 0
									local iter = function()
										i = i + 1
										if a[i] == nil then return nil
										else return a[i], t[ a[i] ]
										end
									end
									return iter
								end
								for _bpm, _seconds in pairsByKeys(BPMs) do if _seconds >= 10 then fastestBPM_backup = _bpm end end
								if fastestBPM_backup > fastestBPM then fastestBPM = fastestBPM_backup end
								]]--
								if fastestBPM == truebpms[1] or fastestBPM == 0 then
									if truebpms[1] ~= truebpms[2] then
										output = addToOutput(output,"BPM: "..truebpms[1] .. " (" .. truebpms[2] .. ")","\n")
									else
										output = addToOutput(output,"BPM: "..truebpms[1],"\n")
									end
								elseif fastestBPM < truebpms[2] then
									output = addToOutput(output,"BPM: "..truebpms[1] .. " - " .. fastestBPM .. " (" .. truebpms[2] .. ")","\n")
								else
									output = addToOutput(output,"BPM: "..truebpms[1] .. " - " .. truebpms[2],"\n")
								end
							end
						end
						if ThemePrefs.Get("ShowCalcDiff") then --Calculate Difficulty
							local totalSeconds = isOutFox() and (LoadFromCache(curSelection,curStep,"TrueLastSecond") - LoadFromCache(curSelection,curStep,"TrueFirstSecond")) or (curSelection:GetLastSecond() - curSelection:GetFirstSecond())
							local stepCounter = isOutFox() and getStepCounter(curSelection,curStep)
							local stepSum = isOutFox() and 0 or math.round(curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() / 2)
							if isOutFox() then
								for i=1,#stepCounter do if stepCounter[i] then stepSum = stepSum + (stepCounter[i] * i) end end
								stepSum = math.round( ( stepSum / totalSeconds ) * (#stepCounter/2) )
							end
							output = addToOutput(output,"Calc'd Difficulty (DB9): "..stepSum,"\n")
							output = addToOutput(output,"Calc'd Difficulty (Y&A): "..math.round(GetConvertDifficulty(curSelection,curStep)*GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()/4),"\n")
							if isOutFox() then output = addToOutput(output,"Calc'd Difficulty (SPS): "..math.round(tonumber(LoadFromCache(curSelection,curStep,"StepsPerSecond"))*GAMESTATE:GetCurrentStyle():ColumnsPerPlayer()/4),"\n") end
						end
						if ThemePrefs.Get("ShowRounds") then -- show amount of rounds for this song if not in EventMode
							if not GAMESTATE:IsEventMode() then
								if curSelection:IsLong() then
									output = addToOutput(output,"COUNTS AS 2 ROUNDS","\n")
								elseif curSelection:IsMarathon() then
									output = addToOutput(output,"COUNTS AS 3 ROUNDS","\n")
								end
							end
						end
					end
				end
			end
			self:settext(output):valign(1)
		end
	}
}