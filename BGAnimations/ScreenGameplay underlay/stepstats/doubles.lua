local pn = GAMESTATE:GetMasterPlayerNumber()
local xPos = pn == PLAYER_1 and (SCREEN_RIGHT-20-SCREEN_WIDTH/2) or (SCREEN_LEFT+20-SCREEN_WIDTH/2)

return Def.ActorFrame{
	OnCommand=function(self)
		self:x( SCREEN_CENTER_X )
		self:y( SCREEN_CENTER_Y)
	end;

	Def.ActorFrame{
		Name="Player";
		InitCommand=function(self) self:x(xPos):addx(100) end;
		BeginCommand=function(self) self:visible(GAMESTATE:IsHumanPlayer(pn)) end;
		OnCommand=function(self) self:sleep(0.5):decelerate(0.8):addx(-100) end;

		LoadActor("d_bg");
		LoadActor("d_bar_fantastic")..{
			InitCommand=function(self) self:vertalign(bottom):x(-4):y(164):zoomx(4.66/14):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then self:playcommand("Update") end
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
		LoadActor("d_bar_excellent")..{
			InitCommand=function(self) self:vertalign(bottom):y(164):zoomx(4.66/14):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then self:playcommand("Update") end
			end;
			UpdateCommand=function(self)
				local steps = GAMESTATE:GetCurrentSteps(pn)
				if steps then
					local TotalSteps = steps:GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds')
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:zoomy(w1Notes/TotalSteps)
				end
			end;
		};
		LoadActor("d_bar_other")..{
			InitCommand=function(self) self:vertalign(bottom):x(4):y(164):zoomx(4.66/14):zoomy(0) end;
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then self:playcommand("Update") end
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

		Def.ActorFrame{
			Name="Labels";
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-4):y(-204+15*0):zoom(0.5):horizalign(left):diffuse(color("#b2f9ff")):settext("F") end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-4):y(-204+15*1):zoom(0.5):horizalign(left):diffuse(color("#ffe2bd")):settext("E") end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-4):y(-204+15*2):zoom(0.5):horizalign(left):diffuse(color("#c9fb9f")):settext("D") end;
			};
		};
		Def.ActorFrame{
			Name="Numbers";
			StepMessageCommand=function(self,p)
				if p.PlayerNumber == pn then
					self:RunCommandsOnChildren(self:playcommand("Update"))
				end
			end;
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-10):y(-204+15*0):zoom(0.5):horizalign(right):settext("0") end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w1Notes = pss:GetTapNoteScores('TapNoteScore_W1')
					self:settext(w1Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-10):y(-204+15*1):zoom(0.5):horizalign(right):settext("0") end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local w2Notes = pss:GetTapNoteScores('TapNoteScore_W2')
					self:settext(w2Notes)
				end;
			};
			LoadFont("ScreenGameplay judgment")..{
				InitCommand=function(self) self:x(-10):y(-204+15*2):zoom(0.5):horizalign(right):settext("0") end;
				UpdateCommand=function(self)
					local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
					local otherNotes = pss:GetTapNoteScores('TapNoteScore_W3')
					otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W4')
					otherNotes = otherNotes + pss:GetTapNoteScores('TapNoteScore_W5')
					self:settext(otherNotes)
				end;
			};
		};
	};
};