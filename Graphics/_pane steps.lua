local player = ...
assert(player,"[Graphics/_pane steps] player required")

return Def.ActorFrame{
	LoadFont("_z 36px shadowx")..{
		Name="StepCount";
		InitCommand=cmd(x,-67;y,120+4;horizalign,center;zoom,.35;diffusealpha,0;);
		OnCommand=cmd(sleep,.4;linear,0.2;diffusealpha,1;shadowlength,2);
		OffCommand=cmd(linear,0.4;diffusealpha,0);
		--[[
		SongNumStepsTextGainFocusCommand=cmd(stoptweening;sleep,.15;linear,.2;diffusealpha,1);
		SongNumStepsTextLoseFocusCommand=cmd(stoptweening;linear,.2;diffusealpha,0);
		--]]
		SetCommand=function(self)
			local val = 0
			local song = GAMESTATE:GetCurrentSong()
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
			else
				val = "?"
			end
			self:settext(val)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end
		end;
	};
	LoadFont("_v 26px bold diffuse")..{
		Name="Label";
		InitCommand=cmd(x,-67;y,120+17;settext,"STEPS";shadowlength,2;zoomx,.45;zoomy,.4;horizalign,center;diffusealpha,0;);
		OnCommand=cmd(sleep,.85;linear,0.2;diffusebottomedge,color("#8F8F8F");diffusealpha,1);
		OffCommand=cmd(linear,0.4;diffusealpha,0);
	};
};