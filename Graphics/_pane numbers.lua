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
			if not song then self:visible(false) return end

			local sel = GAMESTATE:GetCurrentSteps(player)
			if sel then
				self:visible(true)
				local num = sel:GetRadarValues(player):GetValue('RadarCategory_Jumps')
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 24 then itemColor = color("0,1,0,1")
				elseif num <= 49 then itemColor = color("1,1,0,1")
				elseif num <= 99 then itemColor = color("1,.53,0,1")
				elseif num <= 199 then itemColor = color("1,0,0,1")
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
			if not song then self:visible(false) return end

			local sel = GAMESTATE:GetCurrentSteps(player)
			if sel then
				self:visible(true)
				local num = sel:GetRadarValues(player):GetValue('RadarCategory_Holds')
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 24 then itemColor = color("0,1,0,1")
				elseif num <= 49 then itemColor = color("1,1,0,1")
				elseif num <= 99 then itemColor = color("1,.53,0,1")
				elseif num <= 150 then itemColor = color("1,0,0,1")
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
			if not song then self:visible(false) return end

			local sel = GAMESTATE:GetCurrentSteps(player)
			if sel then
				self:visible(true)
				local num = sel:GetRadarValues(player):GetValue('RadarCategory_Mines')
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 24 then itemColor = color("0,1,0,1")
				elseif num <= 49 then itemColor = color("1,1,0,1")
				elseif num <= 89 then itemColor = color("1,.53,0,1")
				elseif num <= 139 then itemColor = color("1,0,0,1")
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
			if not song then self:visible(false) return end

			local sel = GAMESTATE:GetCurrentSteps(player)
			if sel then
				self:visible(true)
				local num = sel:GetRadarValues(player):GetValue('RadarCategory_Hands')
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 14 then itemColor = color("0,1,0,1")
				elseif num <= 29 then itemColor = color("1,1,0,1")
				elseif num <= 39 then itemColor = color("1,.53,0,1")
				elseif num <= 51 then itemColor = color("1,0,0,1")
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
			if not song then self:visible(false) return end

			local sel = GAMESTATE:GetCurrentSteps(player)
			if sel then
				self:visible(true)
				local num = sel:GetRadarValues(player):GetValue('RadarCategory_Rolls')
				-- coloring
				local itemColor = color(".4,.4,.4,1")
				if num == 0 then itemColor = color(".4,.4,.4,1")
				elseif num <= 9 then itemColor = color("0,1,0,1")
				elseif num <= 19 then itemColor = color("1,1,0,1")
				elseif num <= 29 then itemColor = color("1,.53,0,1")
				elseif num <= 39 then itemColor = color("1,0,0,1")
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