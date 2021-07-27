-- single stats
local pn = GAMESTATE:GetMasterPlayerNumber()

return Def.ActorFrame{
	InitCommand=function(self)
		self:Center()
	end;
	Def.ActorFrame{
		Name="JudgePane";
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end;
		OnCommand=function(self)
			self:x(SCREEN_WIDTH/4+((getenv("RotationSoloP1") or getenv("RotationSoloP2")) and 64 or 0));
			self:y((getenv("RotationSoloP1") or getenv("RotationSoloP2")) and 34 or 0);
			self:zoom((getenv("RotationSoloP1") or getenv("RotationSoloP2")) and .75 or 1);
			self:addx(SCREEN_WIDTH/2);
			self:decelerate(1);
			self:addx(-SCREEN_WIDTH/2);
		end;
		LoadActor("stats bg");

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
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(73*-1):shadowlength(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
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
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):shadowlength(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
				self:settext(w2Notes)
			end;
		};
		LoadFont("ScreenGameplay judgment")..{
			Name="NumbersOther";
			InitCommand=function(self) self:settext("0"):zoom(0.75):addy(100):addx(73*1):shadowlength(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
				otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
				otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
				self:settext(otherNotes)
			end;
		};

		Def.ActorFrame{
			Name="BarLabels";
			-- only show on first stage
			InitCommand=function(self) self:visible(GAMESTATE:GetCurrentStageIndex()==0) end;
			LoadFont("_v 26px bold black")..{
				Text="Fantastics";
				InitCommand=function(self) self:rotationz(-90):addx(73*-1):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Excellents";
				InitCommand=function(self) self:rotationz(-90):addx(73*-0):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.25):linear(1):diffusealpha(0) end;
			};
			LoadFont("_v 26px bold black")..{
				Text="Greats, Decents\nWay-Offs";
				InitCommand=function(self) self:rotationz(-90):zoom(0.8):addx(73*1):addy(-20):shadowlength(0):queuecommand("FadeOn") end;
				FadeOnCommand=function(self) self:sleep(2.5):linear(1):diffusealpha(0) end;
			};
		};

		LoadActor("bar_fantastic")..{
			InitCommand=function(self) self:vertalign(bottom):addx(73*-1):addy(86):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
					self:zoomy(w1Notes/TotalSteps)
				end
			end;
		};
		LoadActor("bar_excellent")..{
			InitCommand=function(self) self:vertalign(bottom):addy(86):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:zoomy(w2Notes/TotalSteps)
				end
			end;
		};
		LoadActor("bar_other")..{
			InitCommand=function(self) self:vertalign(bottom):addx(73*1):addy(86):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:playcommand("Update")
				end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
					otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
					otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
					self:zoomy(otherNotes/TotalSteps)
				end
			end;
		};
	};
};