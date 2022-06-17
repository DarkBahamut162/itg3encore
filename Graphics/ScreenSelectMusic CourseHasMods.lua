return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		InitCommand=function(self) self:halign(0):diffusealpha(0):zoom(.8):sleep(1):linear(.1):zoom(.5):diffusealpha(1):shadowlength(0):diffuseramp():effectperiod(1):effectoffset(0):effectclock("beat"):effectcolor1(color("#693A3A")):effectcolor2(color("#FF0000")) end;
		OffCommand=function(self) self:linear(.1):diffusealpha(0) end;
		ShowCommand=function(self) self:visible(1) end;
		HideCommand=function(self) self:visible(0) end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTrailP1ChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentTrailP2ChangedMessageCommand=function(self) self:playcommand("Set") end;
		SetCommand=function(self)
			local curSelection = nil;
			local text = "";
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse();
				if curSelection then
					if curSelection:HasMods() or curSelection:HasTimedMods() then
						text = "HAS MODS"
					end
					local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
					if trail then
						local entries = trail:GetTrailEntries()
						for i=1,#entries do
							if entries[i]:GetNormalModifiers() ~= "" then
								if text == "" then
									text = "HAS SONG MODS"
								else
									text = text.."\nHAS SONG MODS"
								end
								break
							end
						end
					end
				end;
			else
				curSelection = GAMESTATE:GetCurrentSong();
				curStep = GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber());
				if curSelection then
					if HasLuaCheck() then
						text = "HAS LUA"
					end;
					if curStep then
						if false then -- load/save cache StepCounter
							local output = getStats(curStep);
							text = ""
							for i=1,#output do
								text = text .. output[i]
								if i ~= #output then text = text .. "|" end
							end
						end
						if false then -- display if Step has any timingData
							local timingData = curStep:GetTimingData();
							local bpms = timingData:GetBPMsAndTimes(true);
							local stops = timingData:GetStops(true);
							local delays = timingData:GetDelays(true);
							local warps = timingData:GetWarps(true);
							local fakes = timingData:GetFakes(true);
							local scrolls = timingData:GetScrolls(true);
							local speeds = timingData:GetSpeeds(true);

							if #bpms > 1 then if text == "" then text = "HAS BPM CHANGES" else text = text.."\nHAS BPM CHANGES" end end
							if #stops > 1 then if text == "" then text = "HAS STOPS" else text = text.."\nHAS STOPS" end end
							if #delays > 0 then if text == "" then text = "HAS DELAYS" else text = text.."\nHAS DELAYS" end end
							if #warps > 0 then if text == "" then text = "HAS WARPS" else text = text.."\nHAS WARPS" end end
							if #fakes > 0 then if text == "" then text = "HAS FAKES" else text = text.."\nHAS FAKES" end end
							if #scrolls > 1 then if text == "" then text = "HAS SCROLL CHANGES" else text = text.."\nHAS SCROLL CHANGES" end end
							if #speeds > 1 then if text == "" then text = "HAS SPEED CHANGES" else text = text.."\nHAS SPEED CHANGES" end end
						end
					end
					if false and NeedsBPMfixCheck() then -- check for OutFox's "Extreme BPM to Warp" for possible desync
						if text == "" then text = "POTENTIAL WRONG WARPS!" else text = text.."\nPOTENTIAL WRONG WARPS!" end
					end
					if false then -- check on OutFox's LastSecondHint fix for wrong cache data
						local content = NeedsSecsFixCheck()
						text = "TOTAL sec: "..content[1].."\nLAST sec: "..content[2].."\nDIFF sec: "..content[3]
					end
				end;
			end;
			self:settext( text ):valign(1);
		end;
	};
};