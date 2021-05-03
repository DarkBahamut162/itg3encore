local player = ...
assert(player,"[Graphics/_player scores] player required")

return Def.ActorFrame{
	Def.ActorFrame{
		Name="MachineScore";
		InitCommand=cmd(x,-55;);
		SetCommand=function(self)
			local name = self:GetChild("ScoreName")
			local score = self:GetChild("ScorePercent")
			local profile = PROFILEMAN:GetMachineProfile()
			local song = GAMESTATE:GetCurrentSong()
			local scoreText = "xxx";
			local nameText = "xxx";
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local hsl = profile:GetHighScoreList(song,steps)
					local scores = hsl and hsl:GetHighScores()
					if scores[1] then
						nameText = scores[1]:GetName()
						scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
					else
						nameText = "N/A";
						scoreText = "0.00%"
					end
				else
					-- no steps
					nameText = "no";
					scoreText = "steps"
				end
			elseif GAMESTATE:IsCourseMode() then
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(player)
					if trail then
						local hsl = profile:GetHighScoreList(course,trail)
						local scores = hsl and hsl:GetHighScores()
						if scores[1] then
							nameText = scores[1]:GetName()
							scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
						else
							nameText = "N/A";
							scoreText = "0.00%"
						end
					else
						nameText = "NO" scoreText = "TRAIL"
					end
				else
					nameText = "CRS" scoreText = "-100%"
				end
			else
				-- no song, no course
				nameText = "N/A" scoreText = "0.00%"
			end
			name:settext(nameText)
			score:settext(scoreText)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end;
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end;
		end;
		CurrentTrailP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end;
		end;
		CurrentTrailP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end;
		end;
		LoadFont("_z 36px shadowx")..{
			Name="ScoreName";
			Text="MACH";
			InitCommand=cmd(y,85;diffusealpha,0;zoom,.55;shadowlength,2;maxwidth,135;);
			OnCommand=cmd(sleep,.5;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.4;diffusealpha,0);
		};
		LoadFont("_z 36px shadowx")..{
			Name="ScorePercent";
			Text="0.00%";
			InitCommand=cmd(y,100;diffusealpha,0;zoom,.55;shadowlength,2;maxwidth,175;diffusebottomedge,color("#AAAAAA"));
			OnCommand=cmd(sleep,.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.4;diffusealpha,0);
		};
	};

	Def.ActorFrame{
		Name="ProfileScore";
		InitCommand=cmd(x,46;);
		SetCommand=function(self)
			local name = self:GetChild("ScoreName")
			local score = self:GetChild("ScorePercent")
			local profile = PROFILEMAN:GetProfile(player)
			local song = GAMESTATE:GetCurrentSong()
			local scoreText = "xxx";
			local nameText = "YOU";
			if song then
				local steps = GAMESTATE:GetCurrentSteps(player)
				if steps then
					local hsl = profile:GetHighScoreList(song,steps)
					local scores = hsl and hsl:GetHighScores()
					if scores[1] then
						scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
					else
						scoreText = "0.00%"
					end
				else
					-- no steps
					scoreText = "steps"
				end
			elseif GAMESTATE:IsCourseMode() then
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(player)
					if trail then
						local hsl = profile:GetHighScoreList(course,trail)
						local scores = hsl and hsl:GetHighScores()
						if scores[1] then
							scoreText = string.format("%0.2f%%",scores[1]:GetPercentDP()*100)
						else
							scoreText = "0.00%"
						end
					else
						scoreText = "?"
					end
				else
					scoreText = "?"
				end
			else
				-- no song
				scoreText = "?"
			end
			name:settext(nameText)
			score:settext(scoreText)
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		CurrentStepsP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end;
		end;
		CurrentStepsP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end;
		end;
		CurrentTrailP1ChangedMessageCommand=function(self)
			if player == PLAYER_1 then self:playcommand("Set"); end;
		end;
		CurrentTrailP2ChangedMessageCommand=function(self)
			if player == PLAYER_2 then self:playcommand("Set"); end;
		end;
		LoadFont("_z 36px shadowx")..{
			Name="ScoreName";
			Text="CARD";
			InitCommand=cmd(y,85;diffusealpha,0;zoom,.55;shadowlength,2;maxwidth,200;);
			OnCommand=cmd(sleep,.85;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.4;diffusealpha,0);
		};
		LoadFont("_z 36px shadowx")..{
			Name="ScorePercent";
			Text="0.00%";
			InitCommand=cmd(y,100;diffusealpha,0;zoom,.55;shadowlength,2;maxwidth,175;diffusebottomedge,PlayerColor(player));
			OnCommand=cmd(sleep,.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.4;diffusealpha,0);
		};
	};
};