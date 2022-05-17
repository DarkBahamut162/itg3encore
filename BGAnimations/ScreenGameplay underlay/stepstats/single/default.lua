-- single stats
local pn = GAMESTATE:GetMasterPlayerNumber()
local startX = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and SCREEN_WIDTH/4 or -SCREEN_WIDTH/4

local barWidth		= {202	,92	,57	,36		,26	,20};
local barSpace		= {0	,18	,16	,19.5	,18	,16+1/3};
local barHeight		= 228;
local totalWidth	= 202;
local barCenter		= 0;

-- on 3 -> middle (2) 1 pixel off
-- on 4 -> right (4) 2 pixel off
-- on 6 -> left (3) 1 pixel off

local bgNum = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and getenv("ShowStatsP1") or getenv("ShowStatsP2");
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
			self:x(startX+((getenv("RotationSoloP1") or getenv("RotationSoloP2")) and 64 or 0));
			self:y((getenv("RotationSoloP1") or getenv("RotationSoloP2")) and 34 or 0);
			self:zoom((getenv("RotationSoloP1") or getenv("RotationSoloP2")) and .75 or 1);
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
			OnCommand=function(self) self:addx(10) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					-- stuff
					local holdDropCount = self:GetChild("HoldMiss")
					local mineCount = self:GetChild("Mine")
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					mineCount:settext(pss:GetTapNoteScores('TapNoteScore_HitMine'))
					holdDropCount:settext(pss:GetHoldNoteScores('HoldNoteScore_LetGo'))
				end
			end;
			LoadFont("ScreenGameplay judgment")..{
				Text="Holds Dropped:";
				InitCommand=function(self) self:horizalign(left):zoom(0.75):shadowlength(0):addy(145):addx(-110) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Text="Mines Hit: ";
				InitCommand=function(self) self:horizalign(left):zoom(0.75):shadowlength(0):addy(125):addx(-110) end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="HoldMiss";
				InitCommand=function(self) self:horizalign(right):zoom(0.75):shadowlength(0):addy(145):addx(90):settext("0") end;
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="Mine";
				InitCommand=function(self) self:horizalign(right):zoom(0.75):shadowlength(0):addy(125):addx(90):settext("0") end;
			};
		};

		LoadFont("ScreenGameplay judgment")..{
			Name="NumbersW1";
			Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*3):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*4):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*5):shadowlength(0):maxwidth(barWidth[bgNum]*2) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
				Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
				InitCommand=function(self) self:rotationz(-90):addx(barCenter):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Excellents";
				Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
				InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*1):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Greats";
				Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
				InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*2):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Decents";
				Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
				InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*3):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Way-Offs";
				Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
				InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*4):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Misses";
				Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
				InitCommand=function(self) self:rotationz(-90):addx(barCenter+(barWidth[bgNum]+barSpace[bgNum])*5):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
			};
		};

		LoadActor("../w1")..{
			InitCommand=function(self) self:vertalign(bottom):addx(barCenter):addy(86):zoomx(0.01*barWidth[bgNum]):zoomy(0) end;
			Condition=getenv("ShowStatsP1") >= 1 or getenv("ShowStatsP2") >= 1;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 2 or getenv("ShowStatsP2") >= 2;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 3 or getenv("ShowStatsP2") >= 3;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 4 or getenv("ShowStatsP2") >= 4;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 5 or getenv("ShowStatsP2") >= 5;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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
			Condition=getenv("ShowStatsP1") >= 6 or getenv("ShowStatsP2") >= 6;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
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