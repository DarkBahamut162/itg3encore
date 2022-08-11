-- single stats
local pn = GAMESTATE:GetMasterPlayerNumber()
local startX = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/4 or -SCREEN_WIDTH/4

local barWidth		= {202,	92,	57,	36,		26,	20};
local barSpace		= {0,	18,	16,	19.5,	18,	16+1/3};
local barHeight		= 228;
local totalWidth	= 202;
local barCenter		= 0;

-- on 3 -> middle (2) 1 pixel off
-- on 4 -> right (4) 2 pixel off
-- on 6 -> left (3) 1 pixel off

local mines, holds, rolls, holdsAndRolls = 0,0,0,0

local song = GAMESTATE:GetCurrentSong()
local course = GAMESTATE:GetCurrentCourse()
local steps
if song then
	steps = GAMESTATE:GetCurrentSteps(pn)
elseif course then
	steps = GAMESTATE:GetCurrentTrail(pn)
end
if steps then
	local rv = steps:GetRadarValues(pn)
	mines = rv:GetValue('RadarCategory_Mines')
	holds = rv:GetValue('RadarCategory_Holds')
	rolls = rv:GetValue('RadarCategory_Rolls')
	holdsAndRolls = holds + rolls
end

local bgNum = getenv("ShowStats"..ToEnumShortString(pn));
if bgNum > 0 then
	barCenter	= -totalWidth/2+barWidth[bgNum]/2;
end

return Def.ActorFrame{
	InitCommand=function(self)
		self:Center()
	end;
	Def.ActorFrame{
		Name="JudgePane";
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end;
		OnCommand=function(self)
			self:x(startX+(getenv("RotationSolo"..ToEnumShortString(pn)) and 64 or 0));
			self:y(getenv("RotationSolo"..ToEnumShortString(pn)) and 34 or 0);
			self:zoom(getenv("RotationSolo"..ToEnumShortString(pn)) and .75 or 1);
			self:addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2);
			self:decelerate(1);
			self:addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and -SCREEN_WIDTH/2 or SCREEN_WIDTH/2);
		end;
		OffCommand=function(self)
			if AnyPlayerFullComboed() then self:sleep(1) end;
			self:accelerate(0.8):addx(GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/2 or -SCREEN_WIDTH/2)
		end;
		LoadActor("s_bg" .. bgNum);

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
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 2;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then
					self:queuecommand("Update")
				end
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
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 3;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then
					self:queuecommand("Update")
				end
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
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*3):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 4;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then
					self:queuecommand("Update")
				end
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
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*4):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 5;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then
					self:queuecommand("Update")
				end
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
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*5):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStats"..ToEnumShortString(pn)) >= 6;
			JudgmentMessageCommand=function(self,param)
				if param.Player == pn then
					self:queuecommand("Update")
				end
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