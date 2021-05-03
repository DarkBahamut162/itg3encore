local player = ...
assert(player,"[Graphics/_pane fill] player required")

return Def.ActorFrame{
	Def.Quad{
		Name="Jumps";
		InitCommand=cmd(x,-127+100;y,125+17;valign,1;zoomto,24,0;diffusealpha,0;blend,Blend.Add;);
		BeginCommand=cmd(playcommand,"Set");
		OnCommand=cmd(sleep,0.3;decelerate,0.1;diffusealpha,0.5);
		SetCommand=function(self)
			local yZoom = 0
			if GAMESTATE:IsCourseMode() then
			else
				local song = GAMESTATE:GetCurrentSong()
				if song then
					local steps = GAMESTATE:GetCurrentSteps(player)
					if steps then
						local rv = steps:GetRadarValues(player)
						local val = rv:GetValue('RadarCategory_Jumps')
						if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
						elseif val <= 24 then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
						elseif val <= 49 then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
						elseif val <= 99 then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
						elseif val <= 199 then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
						else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
						end
					else
						yZoom = 0
					end
				else
					yZoom = 0
				end
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end
		end;
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};
	Def.Quad{
		Name="Holds";
		InitCommand=cmd(x,-102+100;y,125+17;valign,1;zoomto,24,0;diffusealpha,0;blend,Blend.Add;);
		BeginCommand=cmd(playcommand,"Set");
		OnCommand=cmd(sleep,0.3;decelerate,0.1;diffusealpha,0.5);
		SetCommand=function(self)
			local yZoom = 0
			if GAMESTATE:IsCourseMode() then
			else
				local song = GAMESTATE:GetCurrentSong()
				if song then
					local steps = GAMESTATE:GetCurrentSteps(player)
					if steps then
						local rv = steps:GetRadarValues(player)
						local val = rv:GetValue('RadarCategory_Holds')
						if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
						elseif val <= 24 then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
						elseif val <= 49 then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
						elseif val <= 99 then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
						elseif val <= 150 then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
						else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
						end
					else
						yZoom = 0
					end
				else
					yZoom = 0
				end
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end
		end;
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};
	Def.Quad{
		Name="Mines";
		InitCommand=cmd(x,-77+100;y,125+17;valign,1;zoomto,24,0;diffusealpha,0;blend,Blend.Add;);
		BeginCommand=cmd(playcommand,"Set");
		OnCommand=cmd(sleep,0.3;decelerate,0.1;diffusealpha,0.5);
		SetCommand=function(self)
			local yZoom = 0
			if GAMESTATE:IsCourseMode() then
			else
				local song = GAMESTATE:GetCurrentSong()
				if song then
					local steps = GAMESTATE:GetCurrentSteps(player)
					if steps then
						local rv = steps:GetRadarValues(player)
						local val = rv:GetValue('RadarCategory_Mines')
						if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
						elseif val <= 24 then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
						elseif val <= 49 then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
						elseif val <= 89 then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
						elseif val <= 139 then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
						else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
						end
					else
						yZoom = 0
					end
				else
					yZoom = 0
				end
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end
		end;
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};
	Def.Quad{
		Name="Hands";
		InitCommand=cmd(x,-52+100;y,125+17;valign,1;zoomto,24,0;diffusealpha,0;blend,Blend.Add;);
		BeginCommand=cmd(playcommand,"Set");
		OnCommand=cmd(sleep,0.3;decelerate,0.1;diffusealpha,0.5);
		SetCommand=function(self)
			local yZoom = 0
			if GAMESTATE:IsCourseMode() then
			else
				local song = GAMESTATE:GetCurrentSong()
				if song then
					local steps = GAMESTATE:GetCurrentSteps(player)
					if steps then
						local rv = steps:GetRadarValues(player)
						local val = rv:GetValue('RadarCategory_Hands')
						if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
						elseif val <= 14 then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
						elseif val <= 29 then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
						elseif val <= 39 then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
						elseif val <= 51 then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
						else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
						end
					else
						yZoom = 0
					end
				else
					yZoom = 0
				end
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end
		end;
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};
	Def.Quad{
		Name="Rolls";
		InitCommand=cmd(x,-27+100;y,125+17;valign,1;zoomto,24,0;diffusealpha,0;blend,Blend.Add;);
		BeginCommand=cmd(playcommand,"Set");
		OnCommand=cmd(sleep,0.3;decelerate,0.1;diffusealpha,0.5);
		SetCommand=function(self)
			local yZoom = 0
			if GAMESTATE:IsCourseMode() then
			else
				local song = GAMESTATE:GetCurrentSong()
				if song then
					local steps = GAMESTATE:GetCurrentSteps(player)
					if steps then
						local rv = steps:GetRadarValues(player)
						local val = rv:GetValue('RadarCategory_Rolls')
						if val == 0 then self:diffusecolor( color(".4,.4,.4,1") ) yZoom = 0
						elseif val <=  9 then self:diffusecolor( color("#00FF00FF") ) yZoom = 0.2*24
						elseif val <= 19 then self:diffusecolor( color("#FFFF00FF") ) yZoom = 0.4*24
						elseif val <= 29 then self:diffusecolor( color("#FF8800FF") ) yZoom = 0.6*24
						elseif val <= 39 then self:diffusecolor( color("#FF0000FF") ) yZoom = 0.8*24
						else self:diffusecolor( color("#00C0FFFF") ) yZoom = 24
						end
					else
						yZoom = 0
					end
				else
					yZoom = 0
				end
			end
			self:finishtweening()
			self:decelerate(0.1)
			self:zoomy(yZoom)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end
		end;
		OffCommand=cmd(accelerate,0.2;diffusealpha,0);
	};
};