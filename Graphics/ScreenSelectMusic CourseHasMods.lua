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
						if false then -- load cache HasLua OR check for BGChanges since OutFox hasn't fixed the ingame offset sync overwrite yet
							if tobool(LoadFromCache(curStep,"HasLua")) then
								text = "HAS LUA"
							else
								local BGCs = GetSMParameter(curSelection,"BGCHANGES")
								if #BGCs > 0 then
									text = "HAS BGCHANGES"
								end
							end
						end
						if false then -- load cache StepCounter
							if text ~= "" then text = text .. "\n" end text = text .. table.concat(getStepCounter(curStep),"|")
						end
						if false then -- Get true BPM range
							local timingdata = curStep:GetTimingData()
							local bpms = curStep:GetDisplayBpms()
							local truebpms = timingdata:GetActualBPM()

							bpms[1]=math.round( bpms[1] * 1000 ) / 1000
							bpms[2]=math.round( bpms[2] * 1000 ) / 1000
							truebpms[1]=math.round( truebpms[1] * 1000 ) / 1000
							truebpms[2]=math.round( truebpms[2] * 1000 ) / 1000

							if bpms[1] == truebpms[1] and bpms[2] == truebpms[2] and bpms[1] == bpms[2] then
								if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1]
							else
								local sets = timingdata:GetBPMsAndTimes()
								local currentSet, lastSet
								local duration, lastDuration, fastestBPM = 0, 0, 0

								for i, set in ipairs(sets) do
									currentSet = split("=",set)
									currentSet[2]=math.round( currentSet[2] * 1000 ) / 1000

									if lastSet then
										duration = (currentSet[1]-lastSet[1]) / lastSet[2] * 60
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
								--if math.abs(1-lastSet[2]/currentSet[2]) <= 0.02 then duration = duration + lastDuration end
								if duration >= 4 then
									if truebpms[1] <= lastSet[2] and truebpms[2] >= lastSet[2] then
										if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
									end
								end
								if math.abs(1-fastestBPM/truebpms[2]) <= 0.04 then fastestBPM = truebpms[2] end
								if fastestBPM == truebpms[1] then
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
						if false then -- check on OutFox's LastSecondHint fix for wrong cache data
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
							local totalSeconds = LoadFromCache(curStep,"TrueLastSecond") - LoadFromCache(curStep,"TrueFirstSecond")
							local stepCounter,stepSum = getStepCounter(curStep),0
							local avg_bps_OLD= curSelection:GetLastBeat() / curSelection:MusicLengthSeconds()
							local avg_bps_NEW= LoadModule("Config.Load.lua")("TrueLastBeat",getStepCacheFile(curStep)) / totalSeconds
							local stream_OLD = curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Stream')
							local stream_NEW = stream_OLD * curSelection:MusicLengthSeconds() / totalSeconds
							local voltage_OLD = curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Voltage')
							local voltage_NEW = voltage_OLD / avg_bps_OLD * avg_bps_NEW
							local air_OLD = curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Air')
							local air_NEW = air_OLD * curSelection:MusicLengthSeconds() / totalSeconds
							local freeze_OLD = curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Freeze')
							local freeze_NEW = freeze_OLD * curSelection:MusicLengthSeconds() / totalSeconds
							local chaos_OLD = curStep:GetRadarValues(GAMESTATE:GetMasterPlayerNumber()):GetValue('RadarCategory_Chaos')
							local chaos_NEW = chaos_OLD * curSelection:MusicLengthSeconds() / totalSeconds
							for i=1,#stepCounter do if stepCounter[i] then stepSum = stepSum + stepCounter[i] end end
							stepSum = math.round( ( stepSum / totalSeconds ) * (#stepCounter/2) )

							if text ~= "" then text = text.."\n" end text = text .. "Calc'd Difficulty (DB162): "..stepSum
							if text ~= "" then text = text.."\n" end text = text .. "Calc'd Difficulty (WAIEI): "..GetConvertDifficulty(curStep)
							if text ~= "" then text = text.."\n" end text = text .. "Old GR: "..
							string.format("%1.0f",stream_OLD*100).."|"..string.format("%1.0f",voltage_OLD*100).."|"..
							string.format("%1.0f",air_OLD*100).."|"..string.format("%1.0f",freeze_OLD*100).."|"..string.format("%1.0f",chaos_OLD*100)
							if text ~= "" then text = text.."\n" end text = text .. "New GR: "..
							string.format("%1.0f",stream_NEW*100).."|"..string.format("%1.0f",voltage_NEW*100).."|"..
							string.format("%1.0f",air_NEW*100).."|"..string.format("%1.0f",freeze_NEW*100).."|"..string.format("%1.0f",chaos_NEW*100)
						end
					end
				end
			end
			self:settext( text ):valign(1)
		end
	}
}