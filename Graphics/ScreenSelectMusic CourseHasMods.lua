return Def.ActorFrame{
	LoadFont("_r bold stroke")..{
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentCourseChangedMessageCommand=function(self) self:playcommand("Set") end;
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
			end;
			self:settext( text );
		end;
	};
};