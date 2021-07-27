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
					if curSelection:HasMods() then
						text = "HAS MODS"
					else
						local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
						if trail then
							local entries = trail:GetTrailEntries()
							for i=1,#entries do
								if entries[i]:GetNormalModifiers() ~= "" then
									text = "HAS MODS"
									break
								end
							end
						end
					end
				end;
			else
				curSelection = GAMESTATE:GetCurrentSong();
				if curSelection then
					if HasLua(curSelection) then
						text = "HAS LUA"
					end;
				end;
			end;
			self:settext( text );
		end;
	};
};