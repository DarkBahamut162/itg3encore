local pn = GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20-SCREEN_WIDTH/2) or (SCREEN_LEFT+34-SCREEN_WIDTH/4*3)

local barWidth		= {14,7,4+2/3,3+2/3,2.8,2+1/3,4+2/3}
local barHeight		= 268
local totalWidth	= 14
local barCenter		= 0

local SongOrCourse, StepsOrTrail, scorelist, topscore
local DPCurMax = 0

if GAMESTATE:IsCourseMode() then
	SongOrCourse = GAMESTATE:GetCurrentCourse()
	StepsOrTrail = GAMESTATE:GetCurrentTrail(pn)
else
	SongOrCourse = GAMESTATE:GetCurrentSong()
	StepsOrTrail = GAMESTATE:GetCurrentSteps(pn)
end

if not scorelist then
	scorelist = PROFILEMAN:GetMachineProfile():GetHighScoreList(SongOrCourse,StepsOrTrail)
end
if not scorelist then
	scorelist = PROFILEMAN:GetProfile(pn):GetHighScoreList(SongOrCourse,StepsOrTrail)
end

if scorelist then
	topscore = scorelist:GetHighScores()[1]
end

local bgNum = getenv("ShowStats"..ToEnumShortString(pn))
if bgNum > 0 then
	barCenter	= -totalWidth/2+barWidth[bgNum]/2
end

return Def.ActorFrame{
	OnCommand=function(self)
		self:x( SCREEN_CENTER_X )
		self:y( SCREEN_CENTER_Y)
	end;

	Def.ActorFrame{
		Name="Player";
		InitCommand=function(self) self:x(xPos):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and 100 or -100) end;
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end;
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -100 or 100) end;
		OffCommand=function(self) if AnyPlayerFullComboed() then self:sleep(1) end; self:accelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and 100 or -100) end;

		LoadActor("d_bg");

		Def.ActorFrame{
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) < 7;
			LoadActor("../w1")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 1;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
					self:zoomy(w1Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w2")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*1):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:zoomy(w2Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w3")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*2):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
					self:zoomy(w3Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w4")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*3):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
					self:zoomy(w4Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w5")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*4):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
					self:zoomy(w5Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*5):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
					self:zoomy(missNotes/TotalSteps*barHeight)
				end;
			};
		};
		Def.ActorFrame{
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) == 7;
			JudgmentMessageCommand=function(self,param)
				if param.TapNoteScore and
				param.TapNoteScore ~= 'TapNoteScore_Invalid' and
				param.TapNoteScore ~= 'TapNoteScore_AvoidMine' and
				param.TapNoteScore ~= 'TapNoteScore_HitMine' and
				param.TapNoteScore ~= 'TapNoteScore_CheckpointMiss' and
				param.TapNoteScore ~= 'TapNoteScore_CheckpointHit' and
				param.TapNoteScore ~= 'TapNoteScore_None' then
					DPCurMax = DPCurMax + 5
				end
			end;
			LoadActor("../w3")..{
				OnCommand=function(self)
					self:vertalign(bottom):x(barCenter+(barWidth[bgNum])*1):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0)
					if topscore then
						self:zoomy(topscore:GetPercentDP()*barHeight):diffusealpha(0.25)
					end
				end;
			};
			LoadActor("../w6")..{
				OnCommand=function(self)
					self:vertalign(bottom):x(barCenter+(barWidth[bgNum])*2):y(164):zoomx(0.01*barWidth[bgNum])
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:zoomy(target*barHeight):diffusealpha(0.25)
				end;
			};

			LoadActor("../w1")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DP = pss:GetPercentDancePoints()
					self:zoomy(DP*barHeight)
				end;
			};
			LoadActor("../w3")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*1):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					if topscore then
						local DPMax = pss:GetPossibleDancePoints()
						self:zoomy(DPCurMax/DPMax*topscore:GetPercentDP()*barHeight)
					else
						local DP = pss:GetPercentDancePoints()
						self:zoomy(DP*barHeight)
					end
				end;
			};
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):x(barCenter+barWidth[bgNum]*2):y(164):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then self:queuecommand("Update") end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DPMax = pss:GetPossibleDancePoints()
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:zoomy(DPCurMax/DPMax*target*barHeight)
				end;
			};
		};
	};
};