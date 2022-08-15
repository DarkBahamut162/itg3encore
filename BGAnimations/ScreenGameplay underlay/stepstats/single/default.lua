-- single stats
local pn = GAMESTATE:GetMasterPlayerNumber()
local startX = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/4 or -SCREEN_WIDTH/4

local barWidth		= {202,	92,	57,	36,		26,	20,		57}
local barSpace		= {0,	18,	16,	19.5,	18,	16+1/3,	16}
local barHeight		= 228
local totalWidth	= 202
local barCenter		= 0

-- on 3 -> middle (2) 1 pixel off
-- on 4 -> right (4) 2 pixel off
-- on 6 -> left (3) 1 pixel off

local SongOrCourse, StepsOrTrail, scorelist, topscore
local mines, holds, rolls, holdsAndRolls = 0,0,0,0
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

if StepsOrTrail then
	local rv = StepsOrTrail:GetRadarValues(pn)
	mines = rv:GetValue('RadarCategory_Mines')
	holds = rv:GetValue('RadarCategory_Holds')
	rolls = rv:GetValue('RadarCategory_Rolls')
	holdsAndRolls = holds + rolls
end

local bgNum = getenv("ShowStats"..ToEnumShortString(pn))
if bgNum > 0 then
	barCenter	= -totalWidth/2+barWidth[bgNum]/2
end

return Def.ActorFrame{
	InitCommand=function(self) self:Center() end;
	Def.ActorFrame{
		Name="JudgePane";
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end;
		OnCommand=function(self)
			self:x(startX+(getenv("RotationSolo"..ToEnumShortString(pn)) and 64 or 0))
			:y(getenv("RotationSolo"..ToEnumShortString(pn)) and 34 or 0)
			:zoom(getenv("RotationSolo"..ToEnumShortString(pn)) and .75 or 1)
			:addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
			:decelerate(1)
			:addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -SCREEN_WIDTH/2 or SCREEN_WIDTH/2)
		end;
		OffCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end
			self:accelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
		end;
		LoadActor("s_bg" .. bgNum);

		-- ITG STATS
		Def.ActorFrame{
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) < 7;
			Def.ActorFrame{
				OnCommand=function(self)
					self:addx(10)
					if mines == 0 then
						self:GetChild("MineName"):visible(false)
						self:GetChild("MineCounter"):visible(false)
					end
					if holdsAndRolls == 0 then
						self:GetChild("HoldName"):visible(false)
						self:GetChild("HoldCounter"):visible(false)
					else
						if holds > 0 and rolls > 0 then
							self:GetChild("HoldName"):settext("Holds/Rolls Dropped:")
						elseif holds == 0 and rolls > 0 then
							self:GetChild("HoldName"):settext("Rolls Dropped:")
						end
					end
					self:queuecommand("Update")
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local holdDropCount = self:GetChild("HoldCounter")
					local mineCount = self:GetChild("MineCounter")
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					mineCount:settext(pss:GetTapNoteScores('TapNoteScore_HitMine').."/"..mines)
					holdDropCount:settext(pss:GetHoldNoteScores('HoldNoteScore_LetGo').."/"..holdsAndRolls)
				end;
				LoadFont("ScreenGameplay judgment")..{
					Name="HoldName";
					Text="Holds Dropped:";
					OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-110) end;
				};
				LoadFont("ScreenGameplay judgment")..{
					Name="MineName";
					Text="Mines Hit: ";
					OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-110) end;
				};
				LoadFont("ScreenGameplay judgment")..{
					Name="HoldCounter";
					OnCommand=function(self) self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(145):addx(90) end;
				};
				LoadFont("ScreenGameplay judgment")..{
					Name="MineCounter";
					OnCommand=function(self) self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(125):addx(90) end;
				};
			};

			LoadFont("ScreenGameplay judgment")..{
				Name="NumbersW1";
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 1;
				InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
					self:settext(w1Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="NumbersW2";
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
				InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:settext(w2Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="NumbersW3";
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
				InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
					self:settext(w3Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="NumbersW4";
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
				InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*3):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
					self:settext(w4Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="NumbersW5";
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
				InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*4):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
					self:settext(w5Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="NumbersMiss";
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
				InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*5):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
					self:settext(missNotes)
				end;
			};

			Def.ActorFrame{
				Name="BarLabels";
				-- only show on first stage
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end;
				LoadFont("_v 26px bold black")..{
					Text="Fantastics";
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 1;
					InitCommand=function(self) self:rotationz(-90):addx(barCenter):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Excellents";
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Greats";
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Decents";
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*3):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Way-Offs";
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*4):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Misses";
					Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*5):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
			};

			LoadActor("../w1")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 1;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
					self:zoomy(w1Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w2")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:zoomy(w2Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w3")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w3Notes = pss:GetTapNoteScores('TapNoteScore_W3')
					self:zoomy(w3Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w4")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*3):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w4Notes = pss:GetTapNoteScores('TapNoteScore_W4')
					self:zoomy(w4Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w5")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*4):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w5Notes = pss:GetTapNoteScores('TapNoteScore_W5')
					self:zoomy(w5Notes/TotalSteps*barHeight)
				end;
			};
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*5):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local TotalSteps = StepsOrTrail:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local missNotes = pss:GetTapNoteScores('TapNoteScore_Miss')
					self:zoomy(missNotes/TotalSteps*barHeight)
				end;
			};
		};
		-- IIDX STATS
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
			LoadActor("s_bg_7");
			Def.ActorFrame{
				Name="BarLabels";
				-- only show on first stage
				InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end;
				LoadFont("_v 26px bold black")..{
					Text=PROFILEMAN:GetPlayerName(GAMESTATE:GetMasterPlayerNumber());
					InitCommand=function(self) self:rotationz(-90):addx(barCenter):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Highscore";
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end;
				};
				LoadFont("_v 26px bold black")..{
					Text="Target";
					InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):shadowlength(0):queuecommand("FadeOn") end;
					FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
				};
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="Pacemaker";
				Text="Pacemaker";
				OnCommand=function(self) self:horizalign(center):zoom(0.75):shadowlength(0):addy(-145) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerName";
				Text="Player:";
				OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-100) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="TargetName";
				Text="Target:";
				OnCommand=function(self) self:maxwidth(125):horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-100) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerPoints";
				Text="0";
				OnCommand=function(self)
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(145):addx(100)
					:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints())
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					self:settext(STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints())
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="TargetPoints";
				Text="0";
				OnCommand=function(self)
					self:maxwidth(125):horizalign(right):zoom(0.75):shadowlength(0):addy(125):addx(100)
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:settext(math.ceil(target*STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPossibleDancePoints()))
				end;
			};

			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerHighscoreDifference";
				OnCommand=function(self)
					self:diffuse(color("#00FF00FF")):maxwidth(125):horizalign(left):zoom(0.375):shadowlength(0):addy(140):addx(100)
					if topscore ~= nil then self:settextf( "%+04d", 0 ) end
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn and topscore ~= nil then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local curPlayerDP = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints()
					local curHighscoreDP = math.ceil(DPCurMax*topscore:GetPercentDP())
					self:settextf( "%+04d", (curPlayerDP-curHighscoreDP) )
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="PlayerTargetDifference";
				OnCommand=function(self)
					self:diffuse(color("#FF0000FF")):maxwidth(125):horizalign(left):zoom(0.375):shadowlength(0):addy(150):addx(100):settextf( "%+04d", 0 )
				end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local curPlayerDP = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetActualDancePoints()
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					local curTargetDP = math.ceil(DPCurMax*target)
					self:settextf( "%+04d", (curPlayerDP-curTargetDP) )
				end;
			};

			-- Highscore Target
			LoadActor("../w3")..{
				OnCommand=function(self)
					self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):addy(barHeight/2):zoomx(0.01*barWidth[bgNum]):zoomy(0)
					if topscore then
						self:zoomy(topscore:GetPercentDP()*barHeight):diffusealpha(0.25)
					end
				end;
			};
			-- Target Target
			LoadActor("../w6")..{
				OnCommand=function(self)
					self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):addy(barHeight/2):zoomx(0.01*barWidth[bgNum])
					local target = THEME:GetMetric("PlayerStageStats", "GradePercentTier" .. string.format("%02d", 17-getenv("SetPacemaker"..ToEnumShortString(pn))))
					self:zoomy(target*barHeight):diffusealpha(0.25)
				end;
			};

			-- Player Current
			LoadActor("../w1")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter):addy(barHeight/2):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
				end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local DP = pss:GetPercentDancePoints()
					self:zoomy(DP*barHeight)
				end;
			};
			-- Highscore Current
			LoadActor("../w3")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):addy(barHeight/2):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
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
			-- Target Current
			LoadActor("../w6")..{
				InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):addy(barHeight/2):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
				JudgmentMessageCommand=function(self,param)
					if param.Player == pn then
						self:queuecommand("Update")
					end
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