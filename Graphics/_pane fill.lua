local player = ...
assert(player,"[Graphics/_pane fill] player required")

return Def.ActorFrame{
	Def.Quad{
		Name="Jumps";
		InitCommand=function(self) self:x(-127+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end;
		BeginCommand=function(self) self:playcommand("Set") end;
		OnCommand=function(self) self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end;
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1;
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local steps
			if song then
				steps = GAMESTATE:GetCurrentSteps(player)
			elseif course then
				steps = GAMESTATE:GetCurrentTrail(player)
				numSongs = TrailUtil.GetNumSongs(steps);
			else
				yZoom = 0
			end
			if steps then
				local rv = steps:GetRadarValues(player)
				local val = rv:GetValue('RadarCategory_Jumps')
				if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
				elseif val <= 24 * numSongs then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
				elseif val <= 49 * numSongs then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
				elseif val <= 99 * numSongs then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
				elseif val <= 199 * numSongs then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
				else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
				end
			else
				yZoom = 0
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
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
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end;
	};
	Def.Quad{
		Name="Holds";
		InitCommand=function(self) self:x(-102+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end;
		BeginCommand=function(self) self:playcommand("Set") end;
		OnCommand=function(self) self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end;
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1;
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local steps
			if song then
				steps = GAMESTATE:GetCurrentSteps(player)
			elseif course then
				steps = GAMESTATE:GetCurrentTrail(player)
				numSongs = TrailUtil.GetNumSongs(steps);
			else
				yZoom = 0
			end
			if steps then
				local rv = steps:GetRadarValues(player)
				local val = rv:GetValue('RadarCategory_Holds')
				if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
				elseif val <= 24 * numSongs then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
				elseif val <= 49 * numSongs then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
				elseif val <= 99 * numSongs then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
				elseif val <= 150 * numSongs then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
				else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
				end
			else
				yZoom = 0
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
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
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end;
	};
	Def.Quad{
		Name="Mines";
		InitCommand=function(self) self:x(-77+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end;
		BeginCommand=function(self) self:playcommand("Set") end;
		OnCommand=function(self) self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end;
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1;
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local steps
			if song then
				steps = GAMESTATE:GetCurrentSteps(player)
			elseif course then
				steps = GAMESTATE:GetCurrentTrail(player)
				numSongs = TrailUtil.GetNumSongs(steps);
			else
				yZoom = 0
			end
			if steps then
				local rv = steps:GetRadarValues(player)
				local val = rv:GetValue('RadarCategory_Mines')
				if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
				elseif val <= 24 * numSongs then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
				elseif val <= 49 * numSongs then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
				elseif val <= 89 * numSongs then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
				elseif val <= 139 * numSongs then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
				else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
				end
			else
				yZoom = 0
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
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
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end;
	};
	Def.Quad{
		Name="Hands";
		InitCommand=function(self) self:x(-52+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end;
		BeginCommand=function(self) self:playcommand("Set") end;
		OnCommand=function(self) self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end;
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1;
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local steps
			if song then
				steps = GAMESTATE:GetCurrentSteps(player)
			elseif course then
				steps = GAMESTATE:GetCurrentTrail(player)
				numSongs = TrailUtil.GetNumSongs(steps);
			else
				yZoom = 0
			end
			if steps then
				local rv = steps:GetRadarValues(player)
				local val = rv:GetValue('RadarCategory_Hands')
				if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
				elseif val <= 14 * numSongs then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
				elseif val <= 29 * numSongs then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
				elseif val <= 39 * numSongs then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
				elseif val <= 51 * numSongs then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
				else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
				end
			else
				yZoom = 0
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
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
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end;
	};
	Def.Quad{
		Name="Rolls";
		InitCommand=function(self) self:x(-27+100):y(125+17):valign(1):zoomto(24,0):diffusealpha(0):blend(Blend.Add) end;
		BeginCommand=function(self) self:playcommand("Set") end;
		OnCommand=function(self) self:sleep(0.3):decelerate(0.1):diffusealpha(0.5) end;
		SetCommand=function(self)
			local yZoom = 0
			local numSongs = 1;
			local song = GAMESTATE:GetCurrentSong()
			local course = GAMESTATE:GetCurrentCourse()
			local steps
			if song then
				steps = GAMESTATE:GetCurrentSteps(player)
			elseif course then
				steps = GAMESTATE:GetCurrentTrail(player)
				numSongs = TrailUtil.GetNumSongs(steps);
			else
				yZoom = 0
			end
			if steps then
				local rv = steps:GetRadarValues(player)
				local val = rv:GetValue('RadarCategory_Rolls')
				if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
				elseif val <=  9 * numSongs then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
				elseif val <= 19 * numSongs then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
				elseif val <= 29 * numSongs then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
				elseif val <= 39 * numSongs then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
				else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
				end
			else
				yZoom = 0
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
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
		OffCommand=function(self) self:accelerate(0.2):diffusealpha(0) end;
	};
};