return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		InitCommand=function(self) self:halign(0) end,
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end,
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end,
		SetCommand=function(self)
			local curSelection = nil
			local text = ""
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse()
				if curSelection then
					if curSelection:HasMods() or curSelection:HasTimedMods() then
						text = "HAS MODS"
					end
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							if entries[i]:GetNormalModifiers() ~= "" then
								if text ~= "" then text = text.."\n" end
								text = text.."HAS SONG MODS"
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
						if false then -- load cache HasLua
							if isOutFox() then
								if tobool(LoadFromCache(curStep,"HasLua")) then text = "HAS LUA" end
							else
								if HasLuaCheck() then text = "HAS LUA" end
							end
						end
						if false and isOutFox() then -- load cache StepCounter
							if text ~= "" then text = text .. "\n" end text = text .. table.concat(getStepCounter(curStep),"|")
						end
						if false then -- Get true BPM range
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
								if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1]
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
										if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1] .. " (" .. truebpms[2] .. ")"
									else
										if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1]
									end
								elseif fastestBPM < truebpms[2] then
									if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1] .. " - " .. fastestBPM .. " (" .. truebpms[2] .. ")"
								else
									if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1] .. " - " .. truebpms[2]
								end
							end
						end
						if false and isOutFox() then -- check on OutFox's LastSecondHint fix for wrong cache data
							local totalsecond = curSelection:MusicLengthSeconds()
							local firstsecond = curSelection:GetFirstSecond()
							local lastsecond = curSelection:GetLastSecond()
							local difference = totalsecond - lastsecond
							local trueFirstSecond = LoadFromCache(curStep,"TrueFirstSecond")
							local trueLastSecond = LoadFromCache(curStep,"TrueLastSecond")
							if text ~= "" then text = text.."\n" end
							text = text ..
								"FIRST/TRUE sec: "..string.format("%0.3f",firstsecond).."/"..string.format("%0.3f",trueFirstSecond)..
								"\nLAST/TRUE sec: "..string.format("%0.3f",lastsecond).."/"..string.format("%0.3f",trueLastSecond)..
								"\nDIFF/TRUE sec: "..string.format("%0.3f",difference).."/"..string.format("%0.3f",totalsecond-trueLastSecond)
						end
						if false then --Calculate Difficulty
							local totalSeconds = isOutFox() and (LoadFromCache(curStep,"TrueLastSecond") - LoadFromCache(curStep,"TrueFirstSecond")) or (curSelection:GetLastSecond() - curSelection:GetFirstSecond())
							local stepCounter = isOutFox() and getStepCounter(curStep)
							local stepSum = isOutFox() and 0 or math.round(curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_TapsAndHolds') / totalSeconds * GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() / 2)
							if isOutFox() then
								for i=1,#stepCounter do if stepCounter[i] then stepSum = stepSum + (stepCounter[i] * i) end end
								stepSum = math.round( ( stepSum / totalSeconds ) * (#stepCounter/2) )
							end

							if text ~= "" then text = text.."\n" end text = text .. "Calc'd Difficulty (DB9): "..stepSum
							if text ~= "" then text = text.."\n" end text = text .. "Calc'd Difficulty (Y&A): "..GetConvertDifficulty(curStep)
							if isOutFox() then
								local lastSec = 0
								local stepsPerSec = {}
								local currentSPS = 0
								local timingData = curStep:GetTimingData()
								local allowednotes = {
									["TapNoteType_Tap"] = true,
									["TapNoteSubType_Hold"] = true,
									["TapNoteSubType_Roll"] = true
								}
								local chartint = 1
								for k,v in pairs( GAMESTATE:GetCurrentSong():GetAllSteps() ) do
									if v == curStep then
										chartint = k
										break
									end
								end
								for k,v in pairs( GAMESTATE:GetCurrentSong():GetNoteData(chartint) ) do
									if allowednotes[ v[3] ] then
										local currentSec = timingData:GetElapsedTimeFromBeat(v[1] )
										if lastSec > 0 then
											if lastSec < currentSec then
												currentSPS = 1 / (currentSec - lastSec)
												if stepsPerSec[currentSPS] then
													stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1
												else
													stepsPerSec[currentSPS] = 1
												end
												lastSec = currentSec
											elseif lastSec == currentSec then
												if stepsPerSec[currentSPS] then
													stepsPerSec[currentSPS] = stepsPerSec[currentSPS] + 1
												else
													stepsPerSec[currentSPS] = 1
												end
											end
										else
											lastSec = currentSec
										end
									end
								end
								local total, times = 0, 0
								for _sps, _times in pairs(stepsPerSec) do
									total = total + (_sps * _times)
									times = times + _times
								end
								total = total / times * 2
								if text ~= "" then text = text.."\n" end text = text .. "Calc'd Difficulty (SPS): "..math.round(total)
							end
						end
					end
				end
			end
			self:settext( text ):valign(1)
		end
	}
}