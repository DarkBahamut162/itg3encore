local pn = GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20-SCREEN_WIDTH/2) or (SCREEN_LEFT+34-SCREEN_WIDTH/4*3)

return Def.ActorFrame{
	OnCommand=function(self)
		self:x( SCREEN_CENTER_X )
		self:y( SCREEN_CENTER_Y)
	end;

	Def.ActorFrame{
		Name="Player";
		InitCommand=function(self) self:x(xPos):addx(100) end;
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end;
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -100 or 100) end;
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and 100 or -100) end;

		LoadActor("d_bg");
		LoadActor("d_bar_fantastic")..{
			InitCommand=function(self) self:vertalign(bottom):x(-4):y(164):zoomx(4.66/14):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
						self:zoomy(w1Notes/TotalSteps)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
						self:zoomy(w1Notes/TotalSteps)
					end
				end
			end;
		};
		LoadActor("d_bar_excellent")..{
			InitCommand=function(self) self:vertalign(bottom):y(164):zoomx(4.66/14):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
						self:zoomy(w2Notes/TotalSteps)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
						self:zoomy(w2Notes/TotalSteps)
					end
				end
			end;
		};
		LoadActor("d_bar_other")..{
			InitCommand=function(self) self:vertalign(bottom):x(4):y(164):zoomx(4.66/14):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
						otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
						otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
						self:zoomy(otherNotes/TotalSteps)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
						otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
						otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
						self:zoomy(otherNotes/TotalSteps)
					end
				end
			end;
		};
	};
};