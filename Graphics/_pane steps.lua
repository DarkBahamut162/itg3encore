local player = ...
assert(player,"[Graphics/_pane steps] player required")

return Def.ActorFrame{
	LoadFont("_z 36px shadowx")..{
		Name="StepCount";
		InitCommand=function(self) self:x(-67):y(120+4):horizalign(center):zoom(.35):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(.4):linear(0.2):diffusealpha(1):shadowlength(2) end;
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end;
		--[[
		SongNumStepsTextGainFocusCommand=function(self) self:stoptweening():sleep(.15):linear(.2):diffusealpha(1) end;
		SongNumStepsTextLoseFocusCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		--]]
		SetCommand=function(self)
			local val = 0
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local rv = steps:GetRadarValues(player)
					val = rv:GetValue('RadarCategory_TapsAndHolds')
					if val == 0 then
						self:diffusetopedge(color("#FFFFFF"))
						self:diffusebottomedge(color("#e2e2e2"))
					elseif val <= 249 then
						self:diffusetopedge(color("#00FF00"))
						self:diffusebottomedge(color("#58ff58"))
					elseif val <= 374 then
						self:diffusetopedge(color("#C0FF00"))
						self:diffusebottomedge(color("#d5ff53"))
					elseif val <= 499 then
						self:diffusetopedge(color("#FFFF00"))
						self:diffusebottomedge(color("#ffff60"))
					elseif val <= 624 then
						self:diffusetopedge(color("#FF8800"))
						self:diffusebottomedge(color("#ffa53f"))
					elseif val <= 749 then
						self:diffusetopedge(color("#FF6600"))
						self:diffusebottomedge(color("#ff944d"))
					elseif val <= 874 then
						self:diffusetopedge(color("#00C0FF"))
						self:diffusebottomedge(color("#61d8ff"))
					elseif val <= 999 then
						self:diffusetopedge(color("#a800ff"))
						self:diffusebottomedge(color("#c34eff"))
					elseif val <= 1199 then
						self:diffusetopedge(color("#FF0000"))
						self:diffusebottomedge(color("#ff5353"))
					else
						self:diffusetopedge(color("#fd49ff"))
						self:diffusebottomedge(color("#ffffff"))
					end
				else
					val = 0
				end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(GAMESTATE:GetMasterPlayerNumber())
				if trail then
					val = trail:GetRadarValues(player):GetValue('RadarCategory_TapsAndHolds');
				end
				local numSongs = TrailUtil.GetNumSongs(trail);
				if val == 0 then
					self:diffusetopedge(color("#FFFFFF"))
					self:diffusebottomedge(color("#e2e2e2"))
				elseif val <= 249 * numSongs then
					self:diffusetopedge(color("#00FF00"))
					self:diffusebottomedge(color("#58ff58"))
				elseif val <= 374 * numSongs then
					self:diffusetopedge(color("#C0FF00"))
					self:diffusebottomedge(color("#d5ff53"))
				elseif val <= 499 * numSongs then
					self:diffusetopedge(color("#FFFF00"))
					self:diffusebottomedge(color("#ffff60"))
				elseif val <= 624 * numSongs then
					self:diffusetopedge(color("#FF8800"))
					self:diffusebottomedge(color("#ffa53f"))
				elseif val <= 749 * numSongs then
					self:diffusetopedge(color("#FF6600"))
					self:diffusebottomedge(color("#ff944d"))
				elseif val <= 874 * numSongs then
					self:diffusetopedge(color("#00C0FF"))
					self:diffusebottomedge(color("#61d8ff"))
				elseif val <= 999 * numSongs then
					self:diffusetopedge(color("#a800ff"))
					self:diffusebottomedge(color("#c34eff"))
				elseif val <= 1199 * numSongs then
					self:diffusetopedge(color("#FF0000"))
					self:diffusebottomedge(color("#ff5353"))
				else
					self:diffusetopedge(color("#fd49ff"))
					self:diffusebottomedge(color("#ffffff"))
				end
			else
				val = "?"
			end
			self:settext(val)
			self:maxwidth(150)
		end;
		CurrentSongChangedMessageCommand=function(self) self:playcommand("Set") end;
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end;
		CurrentTrailP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set") end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end;
		CurrentTrailP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set") end
		end;
	};
	LoadFont("_v 26px bold diffuse")..{
		Name="Label";
		InitCommand=function(self) self:x(-67):y(120+17):settext("STEPS"):shadowlength(2):zoomx(.45):zoomy(.4):horizalign(center):diffusealpha(0) end;
		OnCommand=function(self) self:sleep(.85):linear(0.2):diffusebottomedge(color("#8F8F8F")):diffusealpha(1) end;
		OffCommand=function(self) self:linear(0.4):diffusealpha(0) end;
	};
};