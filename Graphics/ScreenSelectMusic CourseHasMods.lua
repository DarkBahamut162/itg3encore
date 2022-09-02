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
						if false then -- check for BGChanges since OutFox hasn't fixed the ingame offset sync overwrite yet
							local BGCs = GetSMParameter(curSelection,"BGCHANGES")
							if #BGCs > 0 then
								text = "HAS BGCHANGES"
							end
						end
						if false then -- load cache HasLua
							if not LoadModule("Config.Exists.lua")("HasLua",getStepCacheFile(curStep)) then cacheStep(curStep) end
							if FILEMAN:DoesFileExist(getStepCacheFile(curStep)) then
								if tobool(LoadModule("Config.Load.lua")("HasLua",getStepCacheFile(curStep))) then
									if text ~= "" then text = text .. "\n" end text = text .. "HAS LUA"
								end
							end
						end
						if false then -- load cache StepCounter
							if text ~= "" then text = text .. "\n" end text = text .. table.concat(getStepCounter(curStep),"|")
						end
						if false then -- display data if Step has any timingData
							if curSelection:IsStepsUsingDifferentTiming(curStep) then
								if text ~= "" then text = text.."\n" end text = text.."SPLIT TIMING"
							end
							local timingData = curStep:GetTimingData()
							local bpms = #timingData:GetBPMsAndTimes(true)
							local stops = #timingData:GetStops(true)
							local delays = #timingData:GetDelays(true)
							local warps = #timingData:GetWarps(true)
							local fakes = #timingData:GetFakes(true)
							local scrolls = #timingData:GetScrolls(true)
							local speeds = #timingData:GetSpeeds(true)

							if bpms > 1 then		if text ~= "" then	text = text.."\n" end text = text.."HAS BPM CHANGES".." ("..(bpms-1)..")" end
							if stops > 0 then		if text ~= "" then	text = text.."\n" end text = text.."HAS STOPS".." ("..(stops)..")" end
							if delays > 0 then		if text ~= "" then	text = text.."\n" end text = text.."HAS DELAYS".." ("..(delays)..")" end
							if warps > 0 then		if text ~= "" then	text = text.."\n" end text = text.."HAS WARPS".." ("..(warps)..")" end
							if fakes > 0 then		if text ~= "" then	text = text.."\n" end text = text.."HAS FAKES".." ("..(fakes)..")" end
							if scrolls > 1 then		if text ~= "" then	text = text.."\n" end text = text.."HAS SCROLL CHANGES".." ("..(scrolls)..")" end
							if speeds > 1 then		if text ~= "" then	text = text.."\n" end text = text.."HAS SPEED CHANGES".." ("..(speeds)..")" end
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
										if math.abs(tonumber(lastSet[2])/tonumber(currentSet[2])) >= 0.98 and math.abs(tonumber(lastSet[2])/tonumber(currentSet[2])) <= 1.02 then
											duration = duration + lastDuration
											if truebpms[1] <= tonumber(currentSet[2]) and truebpms[2] >= tonumber(currentSet[2]) then
												if fastestBPM < currentSet[2] then fastestBPM = currentSet[2] end
											end
										end
										if duration > 3 then
											if truebpms[1] <= tonumber(lastSet[2]) and truebpms[2] >= tonumber(lastSet[2]) then
												if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
											end
											if truebpms[1] <= tonumber(currentSet[2]) and truebpms[2] >= tonumber(currentSet[2]) then
												if math.abs(tonumber(lastSet[2])/tonumber(currentSet[2])) >= 0.98 and math.abs(tonumber(lastSet[2])/tonumber(currentSet[2])) <= 1.02 then
													if fastestBPM < currentSet[2] then fastestBPM = currentSet[2] end
												end
											end
										end
									end
									lastSet = currentSet
									lastDuration = duration
								end

								duration = (curSelection:GetLastBeat()-lastSet[1]) / lastSet[2] * 60
								if math.abs(tonumber(lastSet[2])/tonumber(currentSet[2])) >= 0.98 and math.abs(tonumber(lastSet[2])/tonumber(currentSet[2])) <= 1.02 then
									duration = duration + lastDuration
								end
								if duration > 3 then
									if truebpms[1] <= tonumber(lastSet[2]) and truebpms[2] >= tonumber(lastSet[2]) then
										if fastestBPM < lastSet[2] then fastestBPM = lastSet[2] end
									end
								end

								if fastestBPM == truebpms[1] then
									if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1] .. " (" .. truebpms[2] .. ")"
								elseif fastestBPM < truebpms[2] then
									if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1] .. " - " .. fastestBPM .. " (" .. truebpms[2] .. ")"
								else
									if text ~= "" then text = text.."\n" end text = text .. "BPM: "..truebpms[1] .. " - " .. truebpms[2]
								end
							end
						end
						if false then -- check on OutFox's LastSecondHint fix for wrong cache data
							local totalsecond = GAMESTATE:GetCurrentSong():MusicLengthSeconds()
							local firstsecond = GAMESTATE:GetCurrentSong():GetFirstSecond()
							local lastsecond = GAMESTATE:GetCurrentSong():GetLastSecond()
							local difference = totalsecond - lastsecond
							local trueFirstSecond = 0
							local trueLastSecond = 0
							if not LoadModule("Config.Exists.lua")("TrueFirstSecond",getStepCacheFile(curStep)) or not LoadModule("Config.Exists.lua")("TrueLastSecond",getStepCacheFile(curStep)) then cacheStep(curStep) end
							if FILEMAN:DoesFileExist(getStepCacheFile(curStep)) then
								trueFirstSecond = LoadModule("Config.Load.lua")("TrueFirstSecond",getStepCacheFile(curStep))
								trueLastSecond = LoadModule("Config.Load.lua")("TrueLastSecond",getStepCacheFile(curStep))
							end
							if text ~= "" then text = text.."\n" end
							text = text ..
								"FIRST/TRUE sec: "..string.format("%0.3f",firstsecond).."/"..string.format("%0.3f",trueFirstSecond)..
								"\nLAST/TRUE sec: "..string.format("%0.3f",lastsecond).."/"..string.format("%0.3f",trueLastSecond)..
								"\nDIFF/TRUE sec: "..string.format("%0.3f",difference).."/"..string.format("%0.3f",totalsecond-trueLastSecond)
						end
					end
				end
			end
			self:settext( text ):valign(1)
		end
	}
}