local player = ...
assert(player,"[Graphics/ScreenSelectMusic PaneNumbers] player required")

return Def.ActorFrame{
	LoadFont("smallnumbers")..{
		Name="Jumps";
		InitCommand=function(self) self:x(-127+100):diffusealpha(0):horizalign(center):maxwidth(22) end;
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
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local rv = steps:GetRadarValues(player)
					num = rv:GetValue('RadarCategory_Jumps')
				else
					num = 0
				end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Jumps');
					numSongs = TrailUtil.GetNumSongs(trail);
				else
					num = 0
				end
			end
			if song or course then
				self:visible(true)
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 24 * numSongs then itemColor = color("0,1,0,1")
				elseif num <= 49 * numSongs then itemColor = color("1,1,0,1")
				elseif num <= 99 * numSongs then itemColor = color("1,.53,0,1")
				elseif num <= 199 * numSongs then itemColor = color("1,0,0,1")
				else itemColor = color("0,.75,1,1")
				end
				num = string.format("%03i",num)
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end;
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end;
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		OffCommand=function(self) self:stoptweening():linear(.12):diffusealpha(0) end;
	};
	LoadFont("smallnumbers")..{
		Name="Holds";
		InitCommand=function(self) self:x(-102+100):diffusealpha(0):horizalign(center):maxwidth(22) end;
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
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local rv = steps:GetRadarValues(player)
					num = rv:GetValue('RadarCategory_Holds')
				else
					num = 0
				end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Holds');
					numSongs = TrailUtil.GetNumSongs(trail);
				else
					num = 0
				end
			end
			if song or course then
				self:visible(true)
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 24 * numSongs then itemColor = color("0,1,0,1")
				elseif num <= 49 * numSongs then itemColor = color("1,1,0,1")
				elseif num <= 99 * numSongs then itemColor = color("1,.53,0,1")
				elseif num <= 150 * numSongs then itemColor = color("1,0,0,1")
				else itemColor = color("0,.75,1,1")
				end
				num = string.format("%03i",num)
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end;
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end;
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		OffCommand=function(self) self:stoptweening():linear(.12):diffusealpha(0) end;
	};
	LoadFont("smallnumbers")..{
		Name="Mines";
		InitCommand=function(self) self:x(-77+100):diffusealpha(0):horizalign(center):maxwidth(22) end;
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
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local rv = steps:GetRadarValues(player)
					num = rv:GetValue('RadarCategory_Mines')
				else
					num = 0
				end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Mines');
					numSongs = TrailUtil.GetNumSongs(trail);
				else
					num = 0
				end
			end
			if song or course then
				self:visible(true)
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 24 * numSongs then itemColor = color("0,1,0,1")
				elseif num <= 49 * numSongs then itemColor = color("1,1,0,1")
				elseif num <= 89 * numSongs then itemColor = color("1,.53,0,1")
				elseif num <= 139 * numSongs then itemColor = color("1,0,0,1")
				else itemColor = color("0,.75,1,1")
				end
				num = string.format("%03i",num)
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end;
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end;
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		OffCommand=function(self) self:stoptweening():linear(.12):diffusealpha(0) end;
	};
	LoadFont("smallnumbers")..{
		Name="Hands";
		InitCommand=function(self) self:x(-52+100):diffusealpha(0):horizalign(center):maxwidth(22) end;
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
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local rv = steps:GetRadarValues(player)
					num = rv:GetValue('RadarCategory_Hands')
				else
					num = 0
				end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Hands');
					numSongs = TrailUtil.GetNumSongs(trail);
				else
					num = 0
				end
			end
			if song or course then
				self:visible(true)
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 14 * numSongs then itemColor = color("0,1,0,1")
				elseif num <= 29 * numSongs then itemColor = color("1,1,0,1")
				elseif num <= 39 * numSongs then itemColor = color("1,.53,0,1")
				elseif num <= 51 * numSongs then itemColor = color("1,0,0,1")
				else itemColor = color("0,.75,1,1")
				end
				num = string.format("%03i",num)
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end;
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end;
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		OffCommand=function(self) self:stoptweening():linear(.12):diffusealpha(0) end;
	};
	LoadFont("smallnumbers")..{
		Name="Rolls";
		InitCommand=function(self) self:x(-27+100):diffusealpha(0):horizalign(center):maxwidth(22) end;
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
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local num, numSongs = 1
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local rv = steps:GetRadarValues(player)
					num = rv:GetValue('RadarCategory_Rolls')
				else
					num = 0
				end
			elseif course then
				local trail = GAMESTATE:GetCurrentTrail(player)
				if trail then
					num = trail:GetRadarValues(player):GetValue('RadarCategory_Rolls');
					numSongs = TrailUtil.GetNumSongs(trail);
				else
					num = 0
				end
			end
			if song or course then
				self:visible(true)
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 9 * numSongs then itemColor = color("0,1,0,1")
				elseif num <= 19 * numSongs then itemColor = color("1,1,0,1")
				elseif num <= 29 * numSongs then itemColor = color("1,.53,0,1")
				elseif num <= 39 * numSongs then itemColor = color("1,0,0,1")
				else itemColor = color("0,.75,1,1")
				end
				num = string.format("%03i",num)
				self:settext(num)
				self:diffusecolor(itemColor)
			else
				self:visible(false)
			end
		end;
		SelectMenuOpenedMessageCommand=function(self) self:stoptweening():playcommand("Set"):linear(0.2):diffusealpha(1) end;
		SelectMenuClosedMessageCommand=function(self) self:stoptweening():linear(0.2):diffusealpha(0) end;
		OffCommand=function(self) self:stoptweening():linear(.12):diffusealpha(0) end;
	};
};