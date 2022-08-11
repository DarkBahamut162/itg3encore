local pn = GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20-SCREEN_WIDTH/2) or (SCREEN_LEFT+34-SCREEN_WIDTH/4*3)

local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3};
local barHeight		= 268;
local totalWidth	= 14;
local barCenter		= 0;

local bgNum = getenv("ShowStats"..ToEnumShortString(pn));
if bgNum > 0 then
	barCenter	= -totalWidth/2+barWidth[bgNum]/2;
end

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
		LoadActor("../w1")..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 1;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then self:queuecommand("Update") end
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
						self:zoomy(w1Notes/TotalSteps*barHeight)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
						self:zoomy(w1Notes/TotalSteps*barHeight)
					end
				end
			end;
		};
		LoadActor("../w2")..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*1):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then self:queuecommand("Update") end
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
						self:zoomy(w2Notes/TotalSteps*barHeight)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
						self:zoomy(w2Notes/TotalSteps*barHeight)
					end
				end
			end;
		};
		LoadActor("../w3")..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*2):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
						self:zoomy(w3Notes/TotalSteps*barHeight)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
						self:zoomy(w3Notes/TotalSteps*barHeight)
					end
				end
			end;
		};
		LoadActor("../w4")..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*3):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
						self:zoomy(w4Notes/TotalSteps*barHeight)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
						self:zoomy(w4Notes/TotalSteps*barHeight)
					end
				end
			end;
		};
		LoadActor("../w5")..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*4):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
						self:zoomy(w5Notes/TotalSteps*barHeight)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
						self:zoomy(w5Notes/TotalSteps*barHeight)
					end
				end
			end;
		};
		LoadActor("../w6")..{
			InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*5):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then self:queuecommand("Update") end
			end;
			UpdateCommand=function(self)
				local song = GAMESTATE:GetCurrentSong()
				local course = GAMESTATE:GetCurrentCourse()
				if course then
					local trail = GAMESTATE:GetCurrentTrail(pn)
					if trail then
						local TotalSteps = trail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
						self:zoomy(missNotes/TotalSteps*barHeight)
					end
				elseif song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
						local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
						local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
						self:zoomy(missNotes/TotalSteps*barHeight)
					end
				end
			end;
		};
	};
};