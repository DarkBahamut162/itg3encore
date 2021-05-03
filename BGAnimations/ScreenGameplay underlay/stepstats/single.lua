-- single stats
local pn = GAMESTATE:GetMasterPlayerNumber()

return Def.ActorFrame{
	InitCommand=function(self)
		local x = SCREEN_CENTER_X
		self:x(x)
		self:y(SCREEN_CENTER_Y)
	end;
	Def.ActorFrame{
		Name="JudgePane";
		BeginCommand=cmd(visible,GAMESTATE:IsHumanPlayer(pn));
		OnCommand=function(self)
			--self:x(SCREEN_WIDTH/4+(CustomMods[pn].solo and 64 or 0));
			self:x(SCREEN_WIDTH/4);
			--self:y(CustomMods[pn].solo and 34 or 0);
			self:y(0);
			--self:zoom(CustomMods[pn].solo and .75 or 1)
			self:zoom(1)
			self:addx(SCREEN_WIDTH/2);
			self:decelerate(1);
			self:addx(-SCREEN_WIDTH/2);
		end;
		LoadActor("stats bg");

		Def.ActorFrame{
			OnCommand=cmd(addx,10);
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
				InitCommand=cmd(horizalign,right;zoom,0.5;shadowlength,0;addy,120;addx,-24;);
			};
			LoadFont("ScreenGameplay judgment")..{
				Text="Mines Hit: ";
				InitCommand=cmd(horizalign,right;zoom,0.5;shadowlength,0;addy,140;addx,-24;);
			};
			LoadFont("ScreenGameplay judgment")..{
				Text="Current BPM";
				InitCommand=cmd(zoom,0.5;shadowlength,0;addy,116;addx,56;);
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="HoldMiss";
				InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,0;addy,120;addx,-20;settext,"0");
			};
			LoadFont("ScreenGameplay judgment")..{
				Name="Mine";
				InitCommand=cmd(horizalign,left;zoom,0.5;shadowlength,0;addy,140;addx,-20;settext,"0");
			};
		};

		LoadFont("ScreenGameplay judgment")..{
			Name="NumbersW1";
			InitCommand=cmd(settext,"0";zoom,0.5;addy,96;addx,73*-1;shadowlength,0);
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
			InitCommand=cmd(settext,"0";zoom,0.5;addy,96;shadowlength,0);
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
			InitCommand=cmd(settext,"0";zoom,0.5;addy,96;addx,73*1;shadowlength,0);
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
			InitCommand=cmd(visible,GAMESTATE:GetCurrentStageIndex()==0);
			LoadFont("_v 26px bold black")..{
				Text="Fantastics";
				InitCommand=cmd(rotationz,-90;addx,73*-1;addy,-20;shadowlength,0;queuecommand,"FadeOn");
				FadeOnCommand=cmd(sleep,2;linear,1;diffusealpha,0);
			};
			LoadFont("_v 26px bold black")..{
				Text="Excellents";
				InitCommand=cmd(rotationz,-90;addx,73*-0;addy,-20;shadowlength,0;queuecommand,"FadeOn");
				FadeOnCommand=cmd(sleep,2.25;linear,1;diffusealpha,0);
			};
			LoadFont("_v 26px bold black")..{
				Text="Greats, Decents\nWay-Offs";
				InitCommand=cmd(rotationz,-90;zoom,.8;addx,73*1;addy,-20;shadowlength,0;queuecommand,"FadeOn");
				FadeOnCommand=cmd(sleep,2.5;linear,1;diffusealpha,0);
			};
		};

		LoadActor("bar_fantastic")..{
			InitCommand=cmd(vertalign,bottom;addx,73*-1;addy,86;zoomy,0;);
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
			InitCommand=cmd(vertalign,bottom;addy,86;zoomy,0;);
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
			InitCommand=cmd(vertalign,bottom;addx,73*1;addy,86;zoomy,0;);
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